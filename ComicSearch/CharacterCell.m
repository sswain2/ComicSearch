//
//  CharacterCell.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import "CharacterCell.h"
#import "CharacterViewModel.h"

#import <AFNetworking/UIKit+AFNetworking.h>

@interface CharacterCell ()

@property (weak, nonatomic) IBOutlet UIImageView *characterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CharacterCell

- (void)configureWithCharacter:(CharacterViewModel *)character {
    [self.characterImageView setImageWithURL:character.imageURL];
    self.nameLabel.text = character.name;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    [self.characterImageView cancelImageRequestOperation];
    self.characterImageView.image = nil;
}

@end
