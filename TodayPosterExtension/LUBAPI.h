//
//  LUBAPI.h
//  TodayPoster
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LUBAPI : NSObject

+ (void)postToMicroDotBlogWithText:(NSString *)postText
                          appToken:(NSString *)appToken
                        completion:(void (^)(BOOL success))completion;

@end

NS_ASSUME_NONNULL_END
