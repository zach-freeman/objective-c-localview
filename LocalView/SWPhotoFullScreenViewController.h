//
//  SWPhotoFullScreenViewController.h
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWFlickrPhoto.h"

@interface SWPhotoFullScreenViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *fullImageView;
@property (strong, nonatomic) IBOutlet UIScrollView *containerScrollView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@property (strong, nonatomic) SWFlickrPhoto *flickrPhoto;

@end
