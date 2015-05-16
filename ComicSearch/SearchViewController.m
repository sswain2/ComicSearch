//
//  SearchViewController.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 15/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SearchViewController.h"
#import "SuggestionsViewController.h"

@interface SearchViewController ()<SuggestionsViewControllerDelegate, UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

#pragma mark - SuggestionsViewControllerDelegate

- (void)suggestionsViewController:(SuggestionsViewController *)viewController didSelectSuggestion:(NSString *)suggestion
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // TODO: implementar
    NSLog(@"didSelectSuggestion: %@", suggestion);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // TODO: implementar
    NSLog(@"searchBarButtonClicked: %@", searchBar.text);
}

#pragma mark - Actions

- (IBAction)presentSuggestions:(id)sender {
    SuggestionsViewController *suggestionsVC = [SuggestionsViewController new];
    suggestionsVC.delegate = self;
    
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:suggestionsVC];
    searchController.searchResultsUpdater = suggestionsVC;
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchBar.delegate = self;
    
    [self presentViewController:searchController animated:YES completion:nil];
}

@end
