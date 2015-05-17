//
//  ManagedVolume.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ManagedVolume : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * publisher;
@property (nonatomic, retain) NSDate * insertionDate;

+ (NSFetchRequest *)fetchRequestForAllVolumes;

+ (void)deleteAllVolumesInManagedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
