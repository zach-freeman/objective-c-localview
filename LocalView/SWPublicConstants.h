//
//  SWPublicConstants.h
//  LocalView
//
//  Created by Zach Freeman on 8/8/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//
#import <Foundation/Foundation.h>

#define MAX_TITLE_STRING @"UmjLyNul3eFoj5zVivYVfR18coNUSInD3rRO2ABzwSDzigNATEJTam0HlMVwcoY0LBeK4m4Zhwu0ZC7S24GrONKymeEXVUMDst97IN96caaZw44c94ClHK1X6sIpSvoSqVejiTu6Fscq12zIi2zwHjROVYwhH4mcvUgGLz3Q06ZCq8fuxwUGBcK3n9h6SXqj3EnRjHF182yXoNN9eM4PW3ZUHgh0y449WnAHpTIex46ys8q3itu9GTTSPXGeVLG"

typedef NS_ENUM(NSInteger, SWPhotoFetchState) {
  SWPhotoListNotFetched,
  SWPhotoListFetched,
  SWPhotosNotFetched,
  SWPhotosFetched
};

typedef NS_ENUM(NSInteger, SWFlickrPhotoSize) {
  SWPhotoSizeUnknown,
  SWPhotoSizeCollectionIconLarge,
  SWPhotoSizeBuddyIcon,
  SWPhotoSizeSmallSquare75,
  SWPhotoSizeLargeSquare150,
  SWPhotoSizeThumbnail100,
  SWPhotoSizeSmall240,
  SWPhotoSizeSmall320,
  SWPhotoSizeMedium500,
  SWPhotoSizeMedium640,
  SWPhotoSizeMedium800,
  SWPhotoSizeLarge1024,
  SWPhotoSizeLarge1600,
  SWPhotoSizeLarge2048,
  SWPhotoSizeOriginal,
  SWPhotoSizeVideoOriginal,
  SWPhotoSizeVideoHDMP4,
  SWPhotoSizeVideoSiteMP4,
  SWPhotoSizeVideoMobileMP4,
  SWPhotoSizeVideoPlayer
};

extern NSString* const FLICKR_URL;
extern NSString* const  SEARCH_METHOD;
extern NSString* const FORMAT_TYPE;
extern NSString* const FLICKR_PHOTO_SOURCE_HOST;
extern int const JSON_CALLBACK;
extern int const PRIVACY_FILTER;
extern int const NUMBER_OF_PHOTOS;
extern SWFlickrPhotoSize const SMALL_IMAGE_SIZE;
extern SWFlickrPhotoSize const BIG_IMAGE_SIZE;

