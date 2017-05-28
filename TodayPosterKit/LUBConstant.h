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

@end

@interface LUBDefaultKey : NSObject

@property (nonatomic, class, readonly) NSString *shouldUseCustomPostingURL;
@property (nonatomic, class, readonly) NSString *customPostingURL;

@end
