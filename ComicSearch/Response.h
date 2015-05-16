//
//  Response.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 16/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Response : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber *statusCode;

@property (copy, nonatomic, readonly) NSString *errorMessage;

@property (copy, nonatomic, readonly) NSNumber *numberOfTotalResults;

@property (copy, nonatomic, readonly) NSNumber *offset;

@property (strong, nonatomic, readonly) id results;

+ (instancetype)responseWithJSONDictionary:(NSDictionary *)JSONDictionary resultClass:(Class)resultClass;

- (NSError *)error;

@end
