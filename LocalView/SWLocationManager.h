//
//  SWLocationManager.h
//  LocalView
//
//  Created by Zach Freeman on 8/19/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@protocol SWLocationManagerDelegate;

@interface SWLocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, weak) id <SWLocationManagerDelegate> delegate;
@property (nonatomic, copy) NSString *currentLatitude;
@property (nonatomic, copy) NSString *currentLongitude;
@property (nonatomic, assign) BOOL shouldUpdateLocation;

@end

@protocol SWLocationManagerDelegate <NSObject>

-(void)didUpdateLocaton:(SWLocationManager*)locationManager;

@end
