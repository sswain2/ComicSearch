//
//  SearchViewModel.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 17/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "SearchViewModel.h"
#import "SearchResultViewModel.h"
#import "ComicVineClient.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation SearchViewModel

- (NSUInteger)numberOfResults {
    // FIXME: temporary
    return 1;
}

- (SearchResultViewModel *)resultAtIndex:(NSUInteger)index
{
    // FIXME: temporary
    return [[SearchResultViewModel alloc] initWithImageURL:[NSURL URLWithString:@"http://static.comicvine.com/uploads/scale_avatar/6/67663/2046031-01.jpg"] title:@"Lorem fistrum va usté muy cargadoo condemor diodeno" publisher:@"Marvel"];
}

@end
