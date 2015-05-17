//
//  SearchResultCell.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchResultViewModel;

@interface SearchResultCell : UITableViewCell

- (void)configureWithSearchResult:(SearchResultViewModel *)searchResult;

@end
