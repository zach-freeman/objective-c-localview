//
//  SWUtils.m
//  LocalView
//
//  Created by Zach Freeman on 8/19/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWUtils.h"

@implementation SWUtils

+(void)showReachabilityAlert {
  UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                   message:@"Unable to load photos. Please connect to a network"
                                                  delegate:self
                                         cancelButtonTitle:@"Ok"
                                         otherButtonTitles:nil];
  [alert show];
}

+(void)setupRoundedCornersForLayer:(CALayer*)layer {
  [layer setCornerRadius:9];
  [layer setMasksToBounds:YES];
}

@end
