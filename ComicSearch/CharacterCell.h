//
//  CharacterCell.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CharacterViewModel;

@interface CharacterCell : UITableViewCell

- (void)configureWithCharacter:(CharacterViewModel *)character;

@end
