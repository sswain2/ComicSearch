//
//  SuggestionsViewController.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 15/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SuggestionsViewControllerDelegate;

@interface SuggestionsViewController : UITableViewController<UISearchResultsUpdating>

@property (weak, nonatomic) id<SuggestionsViewControllerDelegate> delegate;

@end

@protocol SuggestionsViewControllerDelegate <NSObject>

- (void)suggestionsViewController:(SuggestionsViewController *)viewController didSelectSuggestion:(NSString *)suggestion;

@end
