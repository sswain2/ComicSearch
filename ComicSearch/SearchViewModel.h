//
//  SearchViewModel.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchResultViewModel;
@class RACSignal;

@interface SearchViewModel : NSObject

@property (copy, nonatomic) NSString *query;

@property (nonatomic, readonly) NSUInteger numberOfResults;

@property (strong, nonatomic, readonly) RACSignal *didUpdateResults;

- (SearchResultViewModel *)resultAtIndex:(NSUInteger)index;

- (NSNumber *)identifierForResultAtIndex:(NSUInteger)index;

- (void)fetchMoreResults;

@end
