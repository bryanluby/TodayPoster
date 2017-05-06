//
//  TodayViewController.m
//  TodayPosterExtension
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#import "LUBAPI.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler
{
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you
    completionHandler(NCUpdateResultNoData);
}

- (IBAction)postButtonPressed:(NSButton *)sender
{
    [LUBAPI postToMicroDotBlogWithText:@"Testing out posting API"
                              appToken:@""
                            completion:^(BOOL success) {
                            }];
}

@end
