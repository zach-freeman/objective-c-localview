//
//  SWPublicConstants.c
//  LocalView
//
//  Created by Zach Freeman on 8/8/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#include "SWPublicConstants.h"

NSString* const FLICKR_URL = @"https://api.flickr.com/services/rest/";
NSString* const  SEARCH_METHOD = @"flickr.photos.search";
NSString* const FORMAT_TYPE = @"json";
NSString* const FLICKR_PHOTO_SOURCE_HOST = @"static.flickr.com";
int const JSON_CALLBACK = 1;
int const PRIVACY_FILTER = 1;
int const NUMBER_OF_PHOTOS = 100;
SWFlickrPhotoSize const SMALL_IMAGE_SIZE = SWPhotoSizeSmallSquare75;
SWFlickrPhotoSize const BIG_IMAGE_SIZE = SWPhotoSizeLarge1024;