//
//  SearchResultCell.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SearchResultCell.h"
#import "SearchResultViewModel.h"

#import <AFNetworking/UIKit+AFNetworking.h>

@interface SearchResultCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publisherLabel;

@end

@implementation SearchResultCell

- (void)configureWithSearchResult:(SearchResultViewModel *)searchResult
{
    [self.coverImageView setImageWithURL:searchResult.imageURL];
    self.titleLabel.text = searchResult.title;
    self.publisherLabel.text = searchResult.publisher;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.coverImageView cancelImageRequestOperation];
    self.coverImageView.image = nil;
}

@end
