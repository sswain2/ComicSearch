//
//  Volume.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 16/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Volume : MTLModel<MTLJSONSerializing>

@property (copy, nonatomic, readonly) NSString *title;

@end
