//
//  SWPhotoListManager.m
//  LocalView
//
//  Created by Zach Freeman on 8/23/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWPhotoListManager.h"
#import "SWUtils.h"

@interface SWPhotoListManager ()


@property (nonatomic, strong) NSOperationQueue *networkAccessQueue;
@property (nonatomic, strong) SWLocationManager *locationManager;


@end

@implementation SWPhotoListManager

-(instancetype)init {
  if (self = [super init]) {
    self.networkAccessQueue = [[NSOperationQueue alloc] init];
    self.networkAccessQueue.name = @"NetworkAccessQueue";
    self.networkAccessQueue.maxConcurrentOperationCount = 1;
    [self startNetworkStatus];
  }
  return self;
}

#pragma mark - SWNetworkStatus

-(void)startNetworkStatus {
  SWNetworkStatus *networkStatusOperation = [[SWNetworkStatus alloc] init];
  networkStatusOperation.delegate = self;
  [self.networkAccessQueue addOperation:networkStatusOperation];
}

-(void)networkStatusDidFinish:(SWNetworkStatus *)networkStatus {
  [self.networkAccessQueue cancelAllOperations];
  if (networkStatus.isReachable) {
    [self startLocationManager];
  } else if (!networkStatus.isReachable) {
    [SWUtils showReachabilityAlert];
    [self.delegate photoListManagerDidFinish:self];
  }
}

#pragma mark - SWLocationManager
-(void)startLocationManager {
  self.locationManager = [[SWLocationManager alloc] init];
  self.locationManager.delegate = self;
}

-(void)didUpdateLocaton:(SWLocationManager *)locationManager {
  [self startPhotoListFetcherWithLatitude:locationManager.currentLatitude andLongitude:locationManager.currentLongitude];
}

#pragma mark - SWPhotoListFetcher
-(void)startPhotoListFetcherWithLatitude:(NSString*)latitude andLongitude:(NSString*)longitude {
  SWPhotoListFetcher *photoListFetcherOperation = [[SWPhotoListFetcher alloc] initWithLatitude:latitude longitude:longitude];
  photoListFetcherOperation.delegate = self;
  [self.networkAccessQueue addOperation:photoListFetcherOperation];
}

-(void)photoListFetcherDidFinish:(SWPhotoListFetcher *)photoListFetcher {
  [self.networkAccessQueue cancelAllOperations];
  self.flickrPhotos = nil;
  self.flickrPhotos = [[NSMutableArray alloc] initWithArray:photoListFetcher.flickrPhotos];
  [self.delegate photoListManagerDidFinish:self];
}




@end
