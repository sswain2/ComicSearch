//
//  SearchViewController.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 15/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SearchViewController.h"
#import "SuggestionsViewController.h"
#import "CharacterViewController.h"

#import "SearchViewModel.h"
#import "SearchResultCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SearchViewController ()<SuggestionsViewControllerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) SearchViewModel *viewModel;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [SearchViewModel new];
    
    @weakify(self);
    [self.viewModel.didUpdateResults subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Characters"]) {
        [self prepareForCharactersSegue:segue sender:sender];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfResults;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    
    SearchResultViewModel *result = [self.viewModel resultAtIndex:indexPath.row];
    [cell configureWithSearchResult:result];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == (self.viewModel.numberOfResults - 1)) {
        [self.viewModel fetchMoreResults];
    }
}

#pragma mark - SuggestionsViewControllerDelegate

- (void)suggestionsViewController:(SuggestionsViewController *)viewController didSelectSuggestion:(NSString *)suggestion
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.viewModel.query = suggestion;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.viewModel.query = searchBar.text;
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

#pragma mark - Private

- (void)prepareForCharactersSegue:(UIStoryboardSegue *)segue sender:(SearchResultCell *)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    NSNumber *identifier = [self.viewModel identifierForResultAtIndex:indexPath.row];
    CharacterViewController *viewController = segue.destinationViewController;
    viewController.volumeIdentifier = identifier;
}

@end
