//
//  SWLocationManager.m
//  LocalView
//
//  Created by Zach Freeman on 8/19/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWLocationManager.h"


@interface SWLocationManager ()

@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation SWLocationManager

-(instancetype)init {
  if (self = [super init]) {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    self.shouldUpdateLocation = YES;

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
      [self.locationManager requestWhenInUseAuthorization];
    } else {
      [self.locationManager startUpdatingLocation]; //Will update location immediately
    }
  }
  return self;
}

#pragma mark - CLLocationManager
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  CLLocation *location = [locations lastObject];
  self.currentLatitude = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
  self.currentLongitude = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
  if (self.shouldUpdateLocation == YES) {
    self.shouldUpdateLocation = NO;
    [self.delegate didUpdateLocaton:self];
  }
  
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  switch (status) {
    case kCLAuthorizationStatusNotDetermined: {
      NSLog(@"Authorization Not Determined");
      [self.locationManager requestWhenInUseAuthorization];
    } break;
    case kCLAuthorizationStatusDenied: {
      NSLog(@"Authorization Denied");
    } break;
    case kCLAuthorizationStatusAuthorizedWhenInUse:
    case kCLAuthorizationStatusAuthorizedAlways: {
      [self.locationManager startUpdatingLocation]; //Will update location immediately
    } break;
    default:
      break;
  }
}

@end
