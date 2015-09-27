//
//  ComicVineClient.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 16/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "ComicVineClient.h"
#import "Response.h"
#import "Volume.h"
#import "Character.h"

#import <AFNetworking/AFNetworking.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString * const APIKey = @"75d580a0593b7320727309feb6309f62def786cd";
static NSString * const format = @"json";

@interface ComicVineClient ()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestManager;

@end

@implementation ComicVineClient

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.comicvine.com/api"]];
    }
    
    return self;
}

- (RACSignal *)fetchSuggestedVolumesWithQuery:(NSString *)query
{
    NSDictionary *parameters = @{
         @"api_key": APIKey,
         @"format": format,
         @"field_list": @"name",
         @"limit": @10,
         @"page": @1,
         @"query": query,
         @"resources": @"volume"
    };
    
    return [self GET:@"search" parameters:parameters resultClass:[Volume class]];
}

- (RACSignal *)fetchVolumesWithQuery:(NSString *)query page:(NSUInteger)page {
    NSDictionary *parameters = @{
         @"api_key": APIKey,
         @"format": format,
         @"field_list": @"id,image,name,publisher",
         @"limit": @20,
         @"page": @(page),
         @"query": query,
         @"resources": @"volume"
    };
    
    return [self GET:@"search" parameters:parameters resultClass:Nil];
}

- (RACSignal *)fetchCharactersForVolumeWithIdentifier:(NSNumber *)identifier {
    return [[self fetchCharacterIdentifiersForVolumeWithIdentifier:identifier]
            flattenMap:^RACStream *(NSArray *identifiers) {
                return [self fetchCharactersWithIdentifiers:identifiers];
            }];
}

#pragma mark - Private

- (RACSignal *)fetchCharacterIdentifiersForVolumeWithIdentifier:(NSNumber *)identifier {
    NSParameterAssert(identifier);
    
    NSString *path = [NSString stringWithFormat:@"volume/4050-%@", identifier];
    
    NSDictionary *parameters = @{
         @"api_key": APIKey,
         @"format": format,
         @"field_list": @"characters",
    };
    
    return [[self GET:path parameters:parameters resultClass:[Volume class]]
            map:^id(Response *response) {
                // Map the characters to their identifiers...
                Volume *volume = response.results;
                return [volume.characters.rac_sequence map:^id(Character *character) {
                    return character.identifier;
                }].array;
            }];
}

- (RACSignal *)fetchCharactersWithIdentifiers:(NSArray *)identifiers {
    NSString *filter = [NSString stringWithFormat:@"id:%@", [identifiers componentsJoinedByString:@"|"]];
    
    NSDictionary *parameters = @{
         @"api_key": APIKey,
         @"format": format,
         @"filter": filter,
         @"field_list": @"name,image",
    };
    
    return [self GET:@"characters" parameters:parameters resultClass:[Character class]];
}

- (RACSignal *)GET:(NSString *)path parameters:(NSDictionary *)parameters resultClass:(Class)resultClass
{
    return [[self GET:path parameters:parameters] map:^id(NSDictionary * JSONDictionary) {
        return [Response responseWithJSONDictionary:JSONDictionary resultClass:resultClass];
    }];
}

- (RACSignal *)GET:(NSString *)path parameters:(NSDictionary *)parameters {
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *operation = [self.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }] deliverOn:[RACScheduler scheduler]];
}

@end
