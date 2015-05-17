//
//  SearchResultViewModel.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResultViewModel : NSObject

@property (copy, nonatomic, readonly) NSURL *imageURL;

@property (copy, nonatomic, readonly) NSString *title;

@property (copy, nonatomic, readonly) NSString *publisher;

- (instancetype)initWithImageURL:(NSURL *)imageURL
                           title:(NSString *)title
                       publisher:(NSString *)publisher;

@end
