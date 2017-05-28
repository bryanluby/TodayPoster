//
//  ViewController.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "ViewController_Private.h"

@import TodayPosterKit.LUBConstant;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureVersionNumberLabel];
}

- (void)configureVersionNumberLabel
{
    NSString *versionNumber = [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *buildNumber = [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *fullVersionString = [NSString stringWithFormat:@"Version: %@ (%@)", versionNumber, buildNumber];
    
    self.versionNumberLabel.stringValue = fullVersionString;
}

- (void)openProjectOnGithub
{
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:LUBConstant.githubProjectURLString]];
}

#pragma mark - Responder Chain

- (void)showHelp:(id)sender
{
    [self openProjectOnGithub];
}

#pragma mark - IBActions

- (IBAction)githubButtonPressed:(id)sender
{
    [self openProjectOnGithub];
}

@end
