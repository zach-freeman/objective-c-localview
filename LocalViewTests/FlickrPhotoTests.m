//
//  FlickrPhotoTests.m
//  LocalView
//
//  Created by Zach Freeman on 8/18/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "SWPublicConstants.h"
#import "SWFlickrPhoto.h"

@interface FlickrPhotoTests : XCTestCase

@end

@implementation FlickrPhotoTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPhotoUrlForSizeBig {
    // This is an example of a functional test case.
  NSString *expectedUrlString = @"https://farm1.static.flickr.com/2/1418878_1e9228336_b.jpg";
  NSURL *expectedUrl = [[NSURL alloc] initWithString:expectedUrlString];
  NSURL *actualUrl = [SWFlickrPhoto photoUrlForSize:BIG_IMAGE_SIZE photoId:@"1418878" server:@"2" secret:@"1e9228336" farm:@"1"];
  XCTAssertTrue([[expectedUrl absoluteString] isEqualToString:[actualUrl absoluteString]], @"pass");
}

- (void)testPhotoUrlForSizeSmall {
  // This is an example of a functional test case.
  NSString *expectedUrlString = @"https://farm1.static.flickr.com/2/1418878_1e9228336_s.jpg";
  NSURL *expectedUrl = [[NSURL alloc] initWithString:expectedUrlString];
  NSURL *actualUrl = [SWFlickrPhoto photoUrlForSize:SMALL_IMAGE_SIZE photoId:@"1418878" server:@"2" secret:@"1e9228336" farm:@"1"];
  XCTAssertTrue([[expectedUrl absoluteString] isEqualToString:[actualUrl absoluteString]], @"pass");
}


@end
