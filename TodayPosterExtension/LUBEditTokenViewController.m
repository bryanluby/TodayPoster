//
//  LUBEditTokenViewController.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/7/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

@import NotificationCenter;

#import "LUBEditTokenViewController.h"

@interface LUBEditTokenViewController ()

@property (nonatomic, strong) IBOutlet NSSecureTextField *secureTextField;

@end

@implementation LUBEditTokenViewController

- (IBAction)saveButtonPressed:(id)sender
{
    if (self.secureTextField.stringValue.length == 0) {
        // Enable/disable button instead
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:self.secureTextField.stringValue forKey:@"AppTokenKey"];
    
    // TODO: Save textfield to keychain
    [self.presentingViewController dismissViewController:self];
}

@end
