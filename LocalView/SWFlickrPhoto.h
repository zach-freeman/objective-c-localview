//
//  SWFlickrPhoto.h
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SWPublicConstants.h"

@interface SWFlickrPhoto : NSObject

@property (nonatomic, copy) NSString *photoSetId;
@property (nonatomic, copy) NSURL *smallImageUrl;
@property (nonatomic, copy) NSURL *bigImageUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *comment;

+(NSURL*)photoUrlForSize:(SWFlickrPhotoSize)size fromPhotoDictionary:(NSDictionary*)photoDictionary;
+(NSURL*)photoUrlForSize:(SWFlickrPhotoSize)size
                 photoId:(NSString*)photoId
                  server:(NSString*)server
                  secret:(NSString*)secret
                    farm:(NSString*)farm;

@end
