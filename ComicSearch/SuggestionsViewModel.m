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
        RACSignal *input = RACObserve(self, query);
        input = [input filter:^BOOL(NSString *value) {
            return value.length > 2;
        }];
        input = [input throttle:.4];
        
        RACSignal *suggestionsSignal = [input flattenMap:^RACStream *(NSString *query) {
            return [self fetchSuggestionsWithQuery:query];
        }];
        
        RAC(self, suggestions) = suggestionsSignal;
        
        _didUpdateSuggestionsSignal = [suggestionsSignal mapReplace:nil];
    }
    return self;
}

#pragma mark - Private

- (RACSignal *)fetchSuggestionsWithQuery:(NSString *)query {
    NSArray *fakeSuggestions = [query componentsSeparatedByString:@" "];
    
    return [[RACSignal return:fakeSuggestions] delay:.5];
}

@end
