//
//  SuggestionsViewModel.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 15/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SuggestionsViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SuggestionsViewModel ()

@property (copy, nonatomic) NSArray *suggestions;

@end

@implementation SuggestionsViewModel

- (NSUInteger)numberOfSuggestions {
    return self.suggestions.count;
}

- (NSString *)suggestionAtIndex:(NSUInteger)index {
    return self.suggestions[index];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _suggestions = @[@"Hello", @"world"];
    }
    return self;
}

#pragma mark - Private

@end
