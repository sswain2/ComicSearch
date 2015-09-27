//
//  Character.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import "Character.h"

@implementation Character

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
        @"identifier": @"id",
        @"name": @"name",
        @"imageURL": @"image.small_url",
    };
}

@end
