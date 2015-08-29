//
//  SWPhotoListFetcher.m
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWPhotoListFetcher.h"
#import "SWFlickrPhoto.h"
#import "SWPrivateConstants.h"
#import "SWPublicConstants.h"
#import "AFNetworking.h"

@interface SWPhotoListFetcher ()


@property (nonatomic, copy) NSString *currentLatitude;
@property (nonatomic, copy) NSString *currentLongitude;


@end

@implementation SWPhotoListFetcher

-(instancetype)initWithLatitude:(NSString*)latitude
                      longitude:(NSString*)longitude {
  if (self = [super init]) {
    self.currentLatitude = latitude;
    self.currentLongitude = longitude;
  }
  return self;
}

-(void) main {
  if (self.isCancelled) {
    return;
  }
  NSDictionary *parameters = @{@"method" : SEARCH_METHOD,
                               @"api_key" : kFlickrApiKey,
                               @"lat" : self.currentLatitude,
                               @"lon" : self.currentLongitude,
                               @"per_page" : [NSString stringWithFormat:@"%d",NUMBER_OF_PHOTOS],
                               @"format" : FORMAT_TYPE,
                               @"privacy_filter" : [NSString stringWithFormat:@"%d",PRIVACY_FILTER],
                               @"nojsoncallback" : [NSString stringWithFormat:@"%d",JSON_CALLBACK]};
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  [manager GET:FLICKR_URL
    parameters:parameters
       success:^(AFHTTPRequestOperation *operation, id responseObject)
   {
     self.flickrPhotos = [NSMutableArray array];
     for (NSDictionary *photoDictionary in [responseObject valueForKeyPath:@"photos.photo"]) {
       SWFlickrPhoto *flickrPhoto = [[SWFlickrPhoto alloc] init];
       flickrPhoto.smallImageUrl = [SWFlickrPhoto photoUrlForSize:SMALL_IMAGE_SIZE fromPhotoDictionary:photoDictionary];
       flickrPhoto.bigImageUrl = [SWFlickrPhoto photoUrlForSize:BIG_IMAGE_SIZE fromPhotoDictionary:photoDictionary];
       flickrPhoto.title = [photoDictionary valueForKey:@"title"];
       flickrPhoto.photoSetId = [photoDictionary valueForKey:@"id"];
       [self.flickrPhotos addObject:flickrPhoto];
     }
     [self.delegate photoListFetcherDidFinish:self];
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     NSLog(@"Error: %@", error.localizedDescription);
   }];
  
  
}

@end
