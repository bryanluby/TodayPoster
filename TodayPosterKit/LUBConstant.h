//
//  LUBConstant.h
//  TodayPoster
//
//  Created by Bryan Luby on 5/12/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ReverseDNS @"com.bryanluby.TodayPoster"

@interface LUBConstant : NSObject

@property (nonatomic, class, copy, readonly) NSString *githubProjectURLString;

@end

@interface LUBDefaultKey : NSObject

@property (nonatomic, class, copy, readonly) NSString *shouldUseCustomPostingURL;
@property (nonatomic, class, copy, readonly) NSString *customPostingURL;

@end
