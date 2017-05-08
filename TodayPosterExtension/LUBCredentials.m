//
//  LUBCredentials.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/8/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "LUBCredentials.h"

@implementation LUBCredentials

+ (NSURLProtectionSpace *)protectionSpace
{
    return [[NSURLProtectionSpace alloc] initWithHost:@"www.micro.blog"
                                                 port:0
                                             protocol:@"https"
                                                realm:nil
                                 authenticationMethod:nil];
}

+ (NSString *)appToken
{
    NSURLCredential *credential = [NSURLCredentialStorage.sharedCredentialStorage defaultCredentialForProtectionSpace:self.protectionSpace];
    return credential.password;
}

+ (void)setAppToken:(NSString *)appToken
{
    NSURLCredential *credential = [NSURLCredential credentialWithUser:@"TodayPosterUser"
                                                             password:appToken
                                                          persistence:NSURLCredentialPersistencePermanent];
    [NSURLCredentialStorage.sharedCredentialStorage setDefaultCredential:credential forProtectionSpace:self.protectionSpace];
}

@end
