//
//  SWUtils.h
//  LocalView
//
//  Created by Zach Freeman on 8/19/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/CALayer.h>
#import <UIKit/UIKit.h>

#define ShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

#define IPAD UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
#define IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone

@interface SWUtils : NSObject

+(void)showReachabilityAlert;
+(void)setupRoundedCornersForLayer:(CALayer*)layer;

@end
