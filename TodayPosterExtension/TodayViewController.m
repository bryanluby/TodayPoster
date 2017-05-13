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

#define ReverseDNS @"com.bryanluby.TodayPoster"
static NSString *const PostDraftDefaultsKey = ReverseDNS @"PostDraftDefaultsKey";
static NSString *const PostDraftCursorLocationKey = ReverseDNS @"PostDraftCursorLocationKey";

@interface TodayViewController () <NCWidgetProviding, NSTextViewDelegate>

@property (nonatomic, strong) IBOutlet NSTextView *textView;
@property (nonatomic, strong) IBOutlet NSProgressIndicator *progressSpinner;
@property (nonatomic, strong) IBOutlet NSTextField *characterCounterLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self restorePost];
    [self updateCharacterCountLabel];
}

- (void)dealloc
{
    [self savePost];
}

- (void)showEditTokenViewController
{
    LUBEditTokenViewController *editTokenViewController = [[LUBEditTokenViewController alloc] initWithNibName:NSStringFromClass(LUBEditTokenViewController.class)
                                                                                                       bundle:nil];
    
    [self presentViewControllerInWidget:editTokenViewController];
}

- (void)updateCharacterCountLabel
{
    self.characterCounterLabel.stringValue = [NSString stringWithFormat:@"%@/280", @(self.textView.string.length)];
}

#pragma mark - NCWidgetProviding

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler
{
    completionHandler(NCUpdateResultNoData);
}

#pragma mark - NSTextViewDelegate

- (void)textDidChange:(NSNotification *)notification
{
    [self updateCharacterCountLabel];
}

#pragma mark - IBActions

- (IBAction)settingsButtonPressed:(NSButton *)sender
{
    [self showEditTokenViewController];
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

    [self.progressSpinner startAnimation:nil];
    typeof(self) __weak weakSelf = self;
    [LUBAPI postToMicroDotBlogWithText:self.textView.string
                              appToken:appToken
                            completion:^(BOOL success) {
                                [weakSelf.progressSpinner stopAnimation:nil];
                                
                                if (success) {
                                    weakSelf.textView.string = @"";
                                    // TODO: display label with location of post url
                                } else {
                                    // TODO: Display error message
                                }
                            }];
}

#pragma mark - Post Saving/Restoring

- (void)savePost
{
    if (self.textView.string) {
        [NSUserDefaults.standardUserDefaults setObject:self.textView.string forKey:PostDraftDefaultsKey];
    }
    
    NSUInteger cursorPosition = self.textView.selectedRanges.firstObject.rangeValue.location;
    if (cursorPosition != NSNotFound) {
        [NSUserDefaults.standardUserDefaults setObject:@(cursorPosition) forKey:PostDraftCursorLocationKey];
    }
}

- (void)restorePost
{
    NSString *savedPostDraft = [NSUserDefaults.standardUserDefaults objectForKey:PostDraftDefaultsKey];
    if (savedPostDraft) {
        self.textView.string = savedPostDraft;
    }
    
    NSNumber *savedCursorLocation = [NSUserDefaults.standardUserDefaults objectForKey:PostDraftCursorLocationKey];
    if (savedCursorLocation && savedCursorLocation.integerValue != NSNotFound) {
        self.textView.selectedRange = NSMakeRange(savedCursorLocation.integerValue, 0);
    }
}

@end
