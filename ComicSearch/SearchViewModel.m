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

@interface SearchViewModel ()

@property (strong, nonatomic) ComicVineClient *client;
@property (nonatomic) NSUInteger currentPage;

@property (strong, nonatomic) NSManagedObjectContext *privateContext;
@property (strong, nonatomic) NSManagedObjectContext *mainContext;

@end

@implementation SearchViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _client = [ComicVineClient new];
        _currentPage = 1;
    }
    return self;
}

- (void)setQuery:(NSString *)query {
    if (![_query isEqualToString:query]) {
        _query = [query copy];
        [self beginNewSearch];
    }
}

- (NSUInteger)numberOfResults {
    // FIXME: temporary
    return 1;
}

- (SearchResultViewModel *)resultAtIndex:(NSUInteger)index
{
    // FIXME: temporary
    return nil;
}

#pragma mark - Private

- (void)beginNewSearch {
    self.currentPage = 1;
    
    NSManagedObjectContext *context = self.privateContext;
    
    [context performBlock:^{
        [ManagedVolume deleteAllVolumesInManagedObjectContext:context];
    }];
    
    [[[self fetchNextPage] publish] connect];
}

- (RACSignal *)fetchNextPage {
    return [[[self.client fetchVolumesWithQuery:self.query page:self.currentPage++] doNext:^(Response *value) {
        // TODO: save data
    }] deliverOnMainThread];
}

@end
