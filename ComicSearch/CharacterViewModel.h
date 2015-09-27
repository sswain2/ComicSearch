//
//  CharacterViewModel.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterViewModel : NSObject

@property (copy, nonatomic, readonly) NSURL *imageURL;

@property (copy, nonatomic, readonly) NSString *name;

- (instancetype)initWithImageURL:(NSURL *)imageURL name:(NSString *)name;

@end
