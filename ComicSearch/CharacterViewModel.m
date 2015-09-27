//
//  CharacterViewModel.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import "CharacterViewModel.h"

@implementation CharacterViewModel

- (instancetype)initWithImageURL:(NSURL *)imageURL name:(NSString *)name {
    self = [super init];
    
    if (self) {
        _imageURL = [imageURL copy];
        _name = [name copy];
    }
    
    return self;
}

@end
