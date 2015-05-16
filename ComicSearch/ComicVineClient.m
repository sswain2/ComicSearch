//
//  ComicVineClient.m
//  ComicSearch
//
//  Created by Guillermo Gonzalez on 16/05/15.
//  Copyright (c) 2015 Agbo. All rights reserved.
//

#import "ComicVineClient.h"

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
    
    return [self GET:@"search" parameters:parameters];
}

#pragma mark - Private

- (RACSignal *)GET:(NSString *)path parameters:(NSDictionary *)parameters {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        AFHTTPRequestOperation *operation = [self.requestManager GET:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [subscriber sendError:error];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            [operation cancel];
        }];
    }];
}

@end
