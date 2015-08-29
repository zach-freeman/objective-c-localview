//
//  SWNetworkReachable.m
//  LocalView
//
//  Created by Zach Freeman on 8/17/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWNetworkStatus.h"

@implementation SWNetworkStatus

-(void) main {
  NSURL *reachableUrl = [NSURL URLWithString:@"http://www.google.com"];
  NSMutableURLRequest *reachableRequest = [[NSMutableURLRequest alloc] initWithURL:reachableUrl];
  reachableRequest.HTTPMethod = @"HEAD";
  reachableRequest.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
  reachableRequest.timeoutInterval = 10.0;
  [NSURLConnection sendAsynchronousRequest:reachableRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
    if (!error) {
      self.isReachable = YES;
    } else {
      self.isReachable = NO;
    }
    [self.delegate networkStatusDidFinish:self];
  }];
}
  


@end
