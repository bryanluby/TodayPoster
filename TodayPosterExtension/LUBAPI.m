//
//  LUBAPI.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "LUBAPI.h"

@implementation LUBAPI

+ (void)postToMicroDotBlogWithText:(NSString *)postText appToken:(NSString *)appToken completion:(void (^)(BOOL))completion
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://micro.blog/micropub"]];
    request.HTTPMethod = @"POST";
    
    [request addValue:[NSString stringWithFormat:@"Bearer %@", appToken]
   forHTTPHeaderField:@"Authorization"];
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    NSDictionary *bodyParameters = @{
                                     @"h": @"entry",
                                     @"content": postText ?: @"",
                                     };
    request.HTTPBody = [[self queryStringFromParameters:bodyParameters] dataUsingEncoding:NSUTF8StringEncoding];
    
    [[NSURLSession.sharedSession dataTaskWithRequest:request
                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                       DLog(@"%@", response);
                                       
                                       NSInteger statusCode = ((NSHTTPURLResponse *)response).statusCode;
                                       BOOL requestWasSuccessful = (statusCode == 201 || statusCode == 202);
                                       completion(requestWasSuccessful);
                                   }] resume];
}

+ (nullable NSString *)queryStringFromParameters:(NSDictionary *)parameters
{
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray arrayWithCapacity:parameters.count];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id _Nonnull key, id _Nonnull value, BOOL *_Nonnull stop) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:value]];
    }];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
    urlComponents.queryItems = queryItems;
    
    return urlComponents.percentEncodedQuery;
}

@end
