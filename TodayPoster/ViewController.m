//
//  ViewController.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/6/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

#pragma mark - Responder Chain

- (void)showHelp:(id)sender
{
    // TODO: Refactor url to a constant that lives in a shared framework between app/extension.
    [NSWorkspace.sharedWorkspace openURL:[NSURL URLWithString:@"https://github.com/bryanluby/TodayPoster"]];
}

@end
