//
//  SWNetworkStatus.h
//  LocalView
//
//  Created by Zach Freeman on 8/17/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SWNetworkStatusDelegate;

@interface SWNetworkStatus : NSOperation

@property (nonatomic, weak) id <SWNetworkStatusDelegate> delegate;
@property (nonatomic, assign) BOOL isReachable;

@end

@protocol SWNetworkStatusDelegate <NSObject>

-(void)networkStatusDidFinish:(SWNetworkStatus *)networkStatus;

@end

