//
//  Character.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Character : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSNumber *identifier;

@property (copy, nonatomic, readonly) NSString *name;

@property (copy, nonatomic, readonly) NSURL *imageURL;

@end
