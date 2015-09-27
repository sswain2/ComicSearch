//
//  Volume.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 16/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "Volume.h"
#import "Character.h"

@implementation Volume

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
         @"title": @"name",
         @"characters": @"characters"
    };
}

+ (NSValueTransformer *)charactersJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Character class]];
}

@end
