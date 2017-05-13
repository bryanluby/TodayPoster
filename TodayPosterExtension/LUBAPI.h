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


/**
 Post to Micro.blog using the posting API.

 @param postText the text to post.
 @param appToken the app specific token to post with.
 @param completion a completion handler to be called on the main queue when the call completes. The postURL is to the "Location" URL of the post.
 */
+ (void)postToMicroDotBlogWithText:(NSString *)postText
                          appToken:(NSString *)appToken
                        completion:(void (^)(BOOL success, NSString * _Nullable postURL))completion;

@end

NS_ASSUME_NONNULL_END
