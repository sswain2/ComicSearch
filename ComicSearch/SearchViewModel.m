//
//  SearchViewModel.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchResultViewModel.h"
#import "ComicVineClient.h"
#import "ManagedVolume.h"
#import "Response.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Groot/Groot.h>

@interface SearchViewModel () <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) ComicVineClient *client;
@property (nonatomic) NSUInteger currentPage;

@property (strong, nonatomic) GRTManagedStore *store;
@property (strong, nonatomic) NSManagedObjectContext *privateContext;
@property (strong, nonatomic) NSManagedObjectContext *mainContext;

@property (strong, nonatomic) NSFetchedResultsController *frc;

@end

@implementation SearchViewModel

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _client = [ComicVineClient new];
        _currentPage = 1;
        
        _store = [GRTManagedStore temporaryManagedStore];
        _mainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _mainContext.persistentStoreCoordinator = _store.persistentStoreCoordinator;
        
        _privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        _privateContext.persistentStoreCoordinator = _store.persistentStoreCoordinator;
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(privateContextDidSave:) name:NSManagedObjectContextDidSaveNotification object:_privateContext];
        
        _frc = [[NSFetchedResultsController alloc] initWithFetchRequest:[ManagedVolume fetchRequestForAllVolumes] managedObjectContext:_mainContext sectionNameKeyPath:nil cacheName:nil];
        _frc.delegate = self;
        
        [_frc performFetch:NULL];
        
        _didUpdateResults = [self rac_signalForSelector:@selector(controllerDidChangeContent:)];
    }
    return self;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
}

- (void)setQuery:(NSString *)query {
    if (![_query isEqualToString:query]) {
        _query = [query copy];
        [self beginNewSearch];
    }
}

- (NSUInteger)numberOfResults {
    id<NSFetchedResultsSectionInfo> sectionInfo = self.frc.sections[0];
    return [sectionInfo numberOfObjects];
}

- (SearchResultViewModel *)resultAtIndex:(NSUInteger)index
{
    ManagedVolume *volume = [self.frc objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    
    return [[SearchResultViewModel alloc] initWithImageURL:[NSURL URLWithString:volume.imageURL]
                                                     title:volume.title
                                                 publisher:volume.publisher];
}

#pragma mark - Private

- (void)beginNewSearch {
    self.currentPage = 1;
    
    NSManagedObjectContext *context = self.privateContext;
    
    [context performBlock:^{
        [ManagedVolume deleteAllVolumesInManagedObjectContext:context];
        [context save:NULL];
    }];
    
    [[[self fetchNextPage] publish] connect];
}

- (RACSignal *)fetchNextPage {
    NSManagedObjectContext *context = self.privateContext;
    
    return [[[self.client fetchVolumesWithQuery:self.query page:self.currentPage++] doNext:^(Response *response) {
        [GRTJSONSerialization insertObjectsForEntityName:@"Volume" fromJSONArray:response.results inManagedObjectContext:context error:NULL];
        
        [context performBlockAndWait:^{
            [context save:NULL];
        }];
    }] deliverOnMainThread];
}

- (void)privateContextDidSave:(NSNotification *)notification {
    NSManagedObjectContext *context = self.mainContext;
    
    [context performBlock:^{
        [context mergeChangesFromContextDidSaveNotification:notification];
    }];
}

@end
