//
//  ViewController.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)openProjectOnGithub
{
    // TODO: Refactor url to a constant that lives in a shared framework between app/extension.
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"https://github.com/bryanluby/TodayPoster"]];
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
