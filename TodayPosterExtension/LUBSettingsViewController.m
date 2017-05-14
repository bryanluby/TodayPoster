//
//  LUBSettingsViewController.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/7/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

@import NotificationCenter;

#import "LUBSettingsViewController.h"

#import "LUBConstant.h"
#import "LUBCredentials.h"

@interface LUBSettingsViewController ()

@property (nonatomic, strong) IBOutlet NSSecureTextField *secureTextField;
@property (nonatomic, strong) IBOutlet NSButton *customPostingURLCheckbox;
@property (nonatomic, strong) IBOutlet NSTextField *customPostingURLTextField;

@end

@implementation LUBSettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BOOL shouldUseCustomPostingURL = [NSUserDefaults.standardUserDefaults boolForKey:LUBDefaultKey.shouldUseCustomPostingURL];
    self.customPostingURLCheckbox.state = (shouldUseCustomPostingURL) ? NSOnState : NSOffState;
    
    NSString *customPostingURL = [NSUserDefaults.standardUserDefaults objectForKey:LUBDefaultKey.customPostingURL];
    if (customPostingURL) {
        self.customPostingURLTextField.stringValue = customPostingURL;
    }
    
    if (LUBCredentials.appToken) {
        self.secureTextField.stringValue = LUBCredentials.appToken;
    }
}

- (void)dealloc
{
    if (self.customPostingURLTextField.stringValue > 0) {
        [NSUserDefaults.standardUserDefaults setObject:self.customPostingURLTextField.stringValue forKey:LUBDefaultKey.customPostingURL];
    }
}

#pragma mark - IBActions

- (IBAction)saveButtonPressed:(NSButton *)sender
{
    if (self.secureTextField.stringValue.length == 0) {
        // Enable/disable button instead
        return;
    }
    
    LUBCredentials.appToken = self.secureTextField.stringValue;
    
    [self.presentingViewController dismissViewController:self];
}

- (IBAction)customPostingURLCheckboxPressed:(NSButton *)sender
{
    BOOL shouldUseCustomPostingURL = (sender.state == NSOnState);
    [NSUserDefaults.standardUserDefaults setBool:shouldUseCustomPostingURL forKey:LUBDefaultKey.shouldUseCustomPostingURL];
}

@end
