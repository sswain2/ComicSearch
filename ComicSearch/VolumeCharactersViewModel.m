//
//  VolumeCharactersViewModel.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 27/09/15.
//  Copyright © 2015 Agbo. All rights reserved.
//

#import "VolumeCharactersViewModel.h"
#import "ComicVineClient.h"
#import "Response.h"
#import "Character.h"
#import "CharacterViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface VolumeCharactersViewModel ()

@property (copy, nonatomic) NSArray *characters;

@end

@implementation VolumeCharactersViewModel

- (NSUInteger)numberOfCharacters {
    return self.characters.count;
}

- (instancetype)initWithVolumeIdentifier:(NSNumber *)identifier {
    self = [super init];
    
    if (self) {
        _volumeIdentifier = [identifier copy];
        
        ComicVineClient *client = [ComicVineClient new];
        RAC(self, characters) = [[[[client fetchCharactersForVolumeWithIdentifier:identifier]
                                   map:^id(Response *response) {
                                       return response.results;
                                   }]
                                  deliverOnMainThread]
                                 catchTo:[RACSignal return:@[]]];
        
        _didUpdateSignal = [RACObserve(self, characters) mapReplace:nil];
    }
    
    return self;
}

- (CharacterViewModel *)characterAtIndex:(NSUInteger)index {
    Character *character = self.characters[index];
    
    return [[CharacterViewModel alloc] initWithImageURL:character.imageURL
                                                   name:character.name];
}

@end
