//
//  ManagedVolume.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "ManagedVolume.h"


@implementation ManagedVolume

@dynamic identifier;
@dynamic imageURL;
@dynamic title;
@dynamic publisher;
@dynamic insertionDate;

- (void)awakeFromInsert {
    [super awakeFromInsert];
    self.insertionDate = [NSDate date];
}

+ (NSFetchRequest *)fetchRequestForAllVolumes {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Volume"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"insertionDate" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    fetchRequest.fetchBatchSize = 20;
    
    return fetchRequest;
}

+ (void)deleteAllVolumesInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    NSFetchRequest *fetchRequest = [self fetchRequestForAllVolumes];
    fetchRequest.includesPropertyValues = NO;
    
    NSArray *volumes = [managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    for (NSManagedObject *v in volumes) {
        [managedObjectContext deleteObject:v];
    }
}

@end
