//
//  SuggestionsViewController.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 15/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SuggestionsViewController.h"
#import "SuggestionsViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const reuseIdentifier = @"SuggestionCell";

@interface SuggestionsViewController ()

@property (strong, nonatomic) SuggestionsViewModel *viewModel;

@end

@implementation SuggestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    
    self.viewModel = [SuggestionsViewModel new];
    
    @weakify(self);
    [self.viewModel.didUpdateSuggestionsSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfSuggestions;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    cell.textLabel.text = [self.viewModel suggestionAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    self.viewModel.query = searchController.searchBar.text;
}

@end
