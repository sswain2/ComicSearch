//
//  CharactersViewController.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import "CharactersViewController.h"
#import "VolumeCharactersViewModel.h"

#import "CharacterCell.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface CharactersViewController ()

@property (strong, nonatomic) VolumeCharactersViewModel *viewModel;

@end

@implementation CharactersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Characters", @"");
    
    self.viewModel = [[VolumeCharactersViewModel alloc] initWithVolumeIdentifier:self.volumeIdentifier];
    
    @weakify(self);
    [self.viewModel.didUpdateSignal subscribeNext:^(id x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.numberOfCharacters;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CharacterCell"];
    CharacterViewModel *character = [self.viewModel characterAtIndex:indexPath.row];
    
    [cell configureWithCharacter:character];
    
    return cell;
}

@end
