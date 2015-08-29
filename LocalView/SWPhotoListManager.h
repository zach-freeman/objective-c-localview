//
//  SWPhotoListManager.h
//  LocalView
//
//  Created by Zach Freeman on 8/23/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWNetworkStatus.h"
#import "SWPhotoListFetcher.h"
#import "SWLocationManager.h"

@protocol SWPhotoListManagerDelegate;

@interface SWPhotoListManager : NSObject <SWLocationManagerDelegate,SWNetworkStatusDelegate,SWPhotoListFetcherDelegate>

@property (nonatomic, weak) id <SWPhotoListManagerDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *flickrPhotos;

@end

@protocol SWPhotoListManagerDelegate <NSObject>

-(void)photoListManagerDidFinish:(SWPhotoListManager *)photoListManager;

@end
