//
//  VolumeCharactersViewModel.h
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;
@class CharacterViewModel;

@interface VolumeCharactersViewModel : NSObject

@property (copy, nonatomic, readonly) NSNumber *volumeIdentifier;

@property (nonatomic, readonly) NSUInteger numberOfCharacters;

@property (strong, nonatomic, readonly) RACSignal *didUpdateSignal;

- (instancetype)initWithVolumeIdentifier:(NSNumber *)identifier;

- (CharacterViewModel *)characterAtIndex:(NSUInteger)index;

@end
