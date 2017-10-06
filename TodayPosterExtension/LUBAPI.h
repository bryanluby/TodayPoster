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
 Post to Micro.blog (or custom posting URL) using the posting API.

 @param postText the text to post.
 @param customPostingURLOrNil the custom posting URL to use. If nil, it will use the default Micro.blog posting endpoint.
 @param appToken the app specific token to post with.
 @param completion a completion handler to be called on the main queue when the call completes. The postURL is the "Location" URL of the post.
 */
+ (void)postToMicroBlogWithText:(NSString *)postText // TODO: Add nullable param for title here?
               customPostingURL:(nullable NSString *)customPostingURLOrNil
                       appToken:(NSString *)appToken
                     completion:(void (^)(BOOL success, NSString * _Nullable postURL))completion;

@end

NS_ASSUME_NONNULL_END
