//
//  LUBConstant.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/12/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "LUBConstant.h"

@implementation LUBConstant

+ (NSString *)githubProjectURLString { return @"https://github.com/bryanluby/TodayPoster"; }

@end

@implementation LUBDefaultKey

+ (NSString *)shouldUseCustomPostingURL { return ReverseDNS @"shouldUseCustomPostingURL"; }
+ (NSString *)customPostingURL { return ReverseDNS @"customPostingURLDefaultsKey"; }

@end
