//
//  ComicVineClient.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 16/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface ComicVineClient : NSObject

- (RACSignal *)fetchSuggestedVolumesWithQuery:(NSString *)query;

- (RACSignal *)fetchVolumesWithQuery:(NSString *)query
                                page:(NSUInteger)page;

@end
