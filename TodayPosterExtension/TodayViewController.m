//
//  TodayViewController.m
//  TodayPosterExtension
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

@import NotificationCenter.NCWidgetProviding;

#import "TodayViewController.h"

#import "LUBAPI.h"
#import "LUBEditTokenViewController.h"
#import "LUBCredentials.h"

@interface TodayViewController () <NCWidgetProviding>

@property (nonatomic, strong) IBOutlet NSTextView *textView;

@end

@implementation TodayViewController

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler
{
    completionHandler(NCUpdateResultNoData);
}

- (IBAction)postButtonPressed:(NSButton *)sender
{
    NSString *const appToken = LUBCredentials.appToken;

    if (!appToken) {
        [self showEditTokenViewController];
        return;
    }
    
    if (self.textView.string.length == 0) {
        // Enable/disable button instead
        return;
    }

    // TODO: Start progress spinner
    typeof(self) __weak weakSelf = self;
    [LUBAPI postToMicroDotBlogWithText:self.textView.string
                              appToken:appToken
                            completion:^(BOOL success) {
                                // TODO: Stop progress spinner
                                if (success) {
                                    weakSelf.textView.string = @"";
                                    // TODO: display label with location of post url
                                } else {
                                    // TODO: Display error message
                                }
                            }];
}

- (void)showEditTokenViewController
{
    LUBEditTokenViewController *editTokenViewController = [[LUBEditTokenViewController alloc] initWithNibName:NSStringFromClass(LUBEditTokenViewController.class)
                                                                                                       bundle:nil];
    
    [self presentViewControllerInWidget:editTokenViewController];
}

@end
