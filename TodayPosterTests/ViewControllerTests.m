//
//  ViewControllerTests.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/14/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ViewController_Private.h"

@interface ViewControllerTests : XCTestCase

@property (strong, nonatomic) ViewController *mainViewController;

@end

@implementation ViewControllerTests

- (void)setUp
{
    [super setUp];

    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    NSWindowController *mainWindowController = [storyboard instantiateInitialController];
    self.mainViewController = (ViewController *)mainWindowController.contentViewController;
}

- (void)tearDown
{
    self.mainViewController = nil;
    
    [super tearDown];
}

- (void)testViewControllerExists
{
    XCTAssertNotNil(self.mainViewController);
    XCTAssertTrue([self.mainViewController isKindOfClass:ViewController.class]);
}

- (void)testVersionNumberLabel
{
    XCTAssertNotNil(self.mainViewController.versionNumberLabel);
    
    NSString *versionNumber = [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *buildNumber = [NSBundle.mainBundle objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *fullVersionString = [NSString stringWithFormat:@"Version: %@ (%@)", versionNumber, buildNumber];
    XCTAssertEqualObjects(fullVersionString, self.mainViewController.versionNumberLabel.stringValue);
}

- (void)testGithubButton
{
    XCTAssertNotNil(self.mainViewController.githubButton);
    XCTAssertEqual(NSFocusRingTypeNone, self.mainViewController.githubButton.focusRingType,
                   @"Github button should not have a focus ring.");
}

@end
