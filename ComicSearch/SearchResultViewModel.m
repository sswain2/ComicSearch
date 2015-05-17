//
//  SearchResultViewModel.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SearchResultViewModel.h"

@implementation SearchResultViewModel

- (instancetype)initWithImageURL:(NSURL *)imageURL
                           title:(NSString *)title
                       publisher:(NSString *)publisher
{
    self = [super init];
    
    if (self) {
        _imageURL = [imageURL copy];
        _title = [title copy];
        _publisher = [publisher copy];
    }
    
    return self;
}

@end
