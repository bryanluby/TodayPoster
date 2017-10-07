//
//  TodayViewController.m
//  TodayPosterExtension
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

@import NotificationCenter.NCWidgetProviding;
@import TodayPosterKit.LUBConstant;

#import "TodayViewController.h"

#import "LUBAPI.h"

#import "LUBCredentials.h"
#import "LUBSettingsViewController.h"

static NSString *const PostTitleDefaultsKey = ReverseDNS @"PostTitleDefaultsKey";
static NSString *const PostDraftDefaultsKey = ReverseDNS @"PostDraftDefaultsKey";
static NSString *const PostDraftCursorLocationKey = ReverseDNS @"PostDraftCursorLocationKey";
static NSUInteger const PostMaxLength = 280;

@interface TodayViewController () <NCWidgetProviding, NSTextViewDelegate>

@property (nonatomic, strong) IBOutlet NSTextView *textView;
@property (nonatomic, strong) IBOutlet NSProgressIndicator *progressSpinner;
@property (nonatomic, strong) IBOutlet NSTextField *characterCounterLabel;
@property (nonatomic, strong) IBOutlet NSStackView *stackView;
@property (nonatomic, strong) IBOutlet NSButton *postButton;
@property (nonatomic, strong) IBOutlet NSTextField *titleTextField;

// TODO: Refactor to add to the stack view, then show hide automatically with hidden property
@property (nonatomic, strong) NSTextField *messageLabel;

@end

@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self restorePost];
    [self updateCharacterCountLabel];
    [self configureMessageLabel];
    [self showOrHideTitleTextField];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    if ([NSUserDefaults.standardUserDefaults boolForKey:LUBDefaultKey.shouldUseCustomPostingURL]) {
        self.postButton.title = NSLocalizedString(@"Post", @"Generic title of the post button");
    } else {
        self.postButton.title = NSLocalizedString(@"Post to Micro.blog", @"Title of the post to Micro.blog button");
    }
}

- (void)dealloc
{
    [self savePost];
}

- (void)showSettingsViewController
{
    LUBSettingsViewController *settingsViewController = [[LUBSettingsViewController alloc] initWithNibName:NSStringFromClass(LUBSettingsViewController.class)
                                                                                                    bundle:nil];
    
    [self presentViewControllerInWidget:settingsViewController];
}

- (void)updateCharacterCountLabel
{
    self.characterCounterLabel.stringValue = [NSString stringWithFormat:@"%@/%@", @(self.textView.string.length), @(PostMaxLength)];
}

- (void)showOrHideTitleTextField
{
    if (self.textView.string.length <= PostMaxLength) {
        self.titleTextField.hidden = YES;
        self.titleTextField.stringValue = @"";
    } else {
        self.titleTextField.hidden = NO;
    }
}

- (nullable NSString *)titleTextOrNil
{
    if (self.titleTextField.isHidden
        || self.titleTextField.stringValue.length == 0) {
        return nil;
    }
    
    return self.titleTextField.stringValue;
}

#pragma mark - Messaging

- (void)configureMessageLabel
{
    self.messageLabel = [[NSTextField alloc] initWithFrame:NSZeroRect];
    self.messageLabel.editable = NO;
    self.messageLabel.selectable = YES;
    self.messageLabel.allowsEditingTextAttributes = YES;
    self.messageLabel.drawsBackground = NO;
    self.messageLabel.bezeled = NO;
}

- (void)showSuccessfulPostMessageWithURL:(NSString *)urlString
{
    [self.stackView addArrangedSubview:self.messageLabel];
    
    if (urlString) {
        NSFont *labelFont = self.messageLabel.font;
        NSString *html = [NSString stringWithFormat:@"Success! Link: <a href=\"%@\">%@</a>", urlString, urlString];
        html = [NSString stringWithFormat:@"<span style=\"font-family:'%@'; font-size:%dpx;\">%@</span>",
                labelFont.fontName, (int)labelFont.pointSize, html];
        NSData *htmlData = [html dataUsingEncoding:NSUTF8StringEncoding];
        
        self.messageLabel.attributedStringValue = [[NSAttributedString alloc] initWithHTML:htmlData documentAttributes:nil];
    } else {
        self.messageLabel.stringValue = NSLocalizedString(@"Success!", @"Confirmation message for a successful post");
    }
}

- (void)showPostErrorMessage
{
    [self.stackView addArrangedSubview:self.messageLabel];
    self.messageLabel.stringValue = NSLocalizedString(@"Something went wrong when trying to post. Please try again.",
                                                      @"Error message when posting fails");
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
    [self showOrHideTitleTextField];
    
    if ([self.stackView.arrangedSubviews containsObject:self.messageLabel]) {
        self.messageLabel.stringValue = @"";
        [self.stackView removeView:self.messageLabel];
    }
}

#pragma mark - IBActions

- (IBAction)settingsButtonPressed:(NSButton *)sender
{
    [self showSettingsViewController];
}

- (IBAction)postButtonPressed:(NSButton *)sender
{
    NSString *const appToken = LUBCredentials.appToken;
    
    if (!appToken) {
        [self showSettingsViewController];
        return;
    }
    
    if (self.textView.string.length == 0) {
        // Enable/disable button instead
        return;
    }
    
    NSString *customPostingURL = nil;
    if ([NSUserDefaults.standardUserDefaults boolForKey:LUBDefaultKey.shouldUseCustomPostingURL]) {
        customPostingURL = [NSUserDefaults.standardUserDefaults objectForKey:LUBDefaultKey.customPostingURL];
    }
    
    [self.progressSpinner startAnimation:nil];
    typeof(self) __weak weakSelf = self;
    [LUBAPI postToMicroBlogWithTitleText:self.titleTextOrNil
                                postText:self.textView.string
                        customPostingURL:customPostingURL
                                appToken:appToken
                              completion:^(BOOL success, NSString * _Nullable postURL) {
                                  [weakSelf.progressSpinner stopAnimation:nil];
                                  
                                  if (success) {
                                      weakSelf.textView.string = @"";
                                      weakSelf.titleTextField.stringValue = @"";
                                      [weakSelf updateCharacterCountLabel];
                                      [weakSelf showOrHideTitleTextField];
                                      
                                      [weakSelf showSuccessfulPostMessageWithURL:postURL];
                                  } else {
                                      [weakSelf showPostErrorMessage];
                                  }
                              }];
}

#pragma mark - Post Saving/Restoring

- (void)savePost
{
    if (self.titleTextField.stringValue.length > 0) {
        [NSUserDefaults.standardUserDefaults setObject:self.titleTextField.stringValue forKey:PostTitleDefaultsKey];
    }
    
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
    NSString *savedPostTitle = [NSUserDefaults.standardUserDefaults objectForKey:PostTitleDefaultsKey];
    if (savedPostTitle) {
        self.titleTextField.stringValue = savedPostTitle;
    }
    
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
