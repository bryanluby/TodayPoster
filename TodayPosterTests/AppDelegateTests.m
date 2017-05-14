//
//  AppDelegateTests.m
//  TodayPoster
//
//  Created by Bryan Luby on 5/14/17.
//  Copyright © 2017 Bryan Luby. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "AppDelegate.h"

@interface AppDelegateTests : XCTestCase

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation AppDelegateTests

- (void)setUp
{
    [super setUp];
    
    self.appDelegate = [[AppDelegate alloc] init];
}

- (void)tearDown
{
    self.appDelegate = nil;
    
    [super tearDown];
}

- (void)testClosingWindowShouldCloseApp
{
    XCTAssertTrue([self.appDelegate applicationShouldTerminateAfterLastWindowClosed:NSApp]);
}

@end
