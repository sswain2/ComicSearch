//
//  SuggestionsViewModel.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 15/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface SuggestionsViewModel : NSObject

@property (copy, nonatomic) NSString *query;

@property (nonatomic, readonly) NSUInteger numberOfSuggestions;

@property (strong, nonatomic, readonly) RACSignal *didUpdateSuggestionsSignal;

- (NSString *)suggestionAtIndex:(NSUInteger)index;

@end
