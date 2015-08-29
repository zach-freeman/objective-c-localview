//
//  SWPhotoListFetcher.h
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SWPhotoListFetcherDelegate;


@interface SWPhotoListFetcher : NSOperation

@property (nonatomic, weak) id <SWPhotoListFetcherDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *flickrPhotos;

-(instancetype)initWithLatitude:(NSString*)latitude
                       longitude:(NSString*)longitude;

@end

@protocol SWPhotoListFetcherDelegate <NSObject>

-(void)photoListFetcherDidFinish:(SWPhotoListFetcher *)photoListFetcher;

@end
