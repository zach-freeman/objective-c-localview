//
//  SWFlickrPhoto.m
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWFlickrPhoto.h"

@implementation SWFlickrPhoto

+(NSURL*)photoUrlForSize:(SWFlickrPhotoSize)size fromPhotoDictionary:(NSDictionary*)photoDictionary {
  NSString *photoId = [photoDictionary valueForKey:@"id"];
  NSString *server = [photoDictionary valueForKey:@"server"];
  
   NSString *farm = [photoDictionary valueForKey:@"farm"];
   NSString *secret = [photoDictionary valueForKey:@"secret"];
  
  NSURL* photoUrl = [self photoUrlForSize:size photoId:photoId server:server secret:secret farm:farm];
  return photoUrl;
}

+(NSURL*)photoUrlForSize:(SWFlickrPhotoSize)size
                 photoId:(NSString*)photoId
                  server:(NSString*)server
                  secret:(NSString*)secret
                    farm:(NSString*)farm {
  // https://farm{farm-id}.static.flickr.com/{server-id}/{id}_{secret}_[mstb].jpg
  // https://farm{farm-id}.static.flickr.com/{server-id}/{id}_{secret}.jpg
  NSMutableString *photoUrlString = [[NSMutableString alloc] init];
  [photoUrlString appendString:@"https://"];
  if (farm != nil) {
    [photoUrlString appendString:[NSString stringWithFormat:@"farm%@.", farm]];
  }
  NSString *sizeSuffix = [self suffixForSize:size];
  NSString *tmpString = [NSString stringWithFormat:@"%@/%@/%@_%@_%@.jpg",
                         FLICKR_PHOTO_SOURCE_HOST,
                         server,
                         photoId,
                         secret,
                         sizeSuffix];
  [photoUrlString appendString:tmpString];
  return [[NSURL alloc] initWithString:photoUrlString];
}

+(NSString*) suffixForSize:(SWFlickrPhotoSize)size {
  NSArray *suffixArray = @[@"",
                                @"collectionIconLarge",
                                @"buddyIcon",
                                @"s",
                                @"q",
                                @"t",
                                @"m",
                                @"n",
                                @"",
                                @"z",
                                @"c",
                                @"b",
                                @"h",
                                @"k",
                                @"o",
                                @"",
                                @"",
                                @"",
                                @"",
                           @""];
  return [suffixArray objectAtIndex:size];
}



@end
