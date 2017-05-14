//
//  WindowControllerTests.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/14/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface WindowControllerTests : XCTestCase

@property (nonatomic, strong) NSWindowController *mainWindowController;

@end

@implementation WindowControllerTests

- (void)setUp
{
    [super setUp];

    NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    self.mainWindowController = [storyboard instantiateInitialController];
}

- (void)tearDown
{
    self.mainWindowController = nil;
    
    [super tearDown];
}

- (void)testWindowExists
{
    XCTAssertNotNil(self.mainWindowController);
}

- (void)testTitle
{
    XCTAssertEqualObjects(self.mainWindowController.window.title, @"TodayPoster");
}

- (void)testShouldNotAllowTabs
{
    XCTAssertEqual(self.mainWindowController.window.tabbingMode, NSWindowTabbingModeDisallowed);
}

- (void)testShouldNotAllowFullscreen
{
    XCTAssertEqual(self.mainWindowController.window.collectionBehavior, NSWindowCollectionBehaviorFullScreenNone);
}

@end
