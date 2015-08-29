//
//  SWPhotoFullScreenViewController.m
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWPhotoFullScreenViewController.h"
#import "SWPhotoLoadViewController.h"
#import "SWPublicConstants.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SWScrollView.h"
#import "SWUtils.h"

@interface SWPhotoFullScreenViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (strong, nonatomic) UIImage *fullImage;
@property (nonatomic, assign) SWPhotoFetchState photoFetchState;

@end

@implementation SWPhotoFullScreenViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.photoFetchState = SWPhotosNotFetched;
  
  if (IPHONE) {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [self createViews];
  }
  
}

-(void)createViews {
  CGRect viewBounds = [self viewBounds];
  [self createScrollView:viewBounds];
  [self createImageView:viewBounds];
}

-(CGRect)viewBounds {
  CGRect viewFrame = CGRectZero;
  if (self.navigationController.navigationBarHidden == NO) {
    float navigationBarXOrigin = self.navigationController.navigationBar.frame.origin.x;
    float navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    viewFrame = CGRectMake(navigationBarXOrigin, navigationBarHeight, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarHeight);
  } else {
    viewFrame = self.view.bounds;
  }
  return viewFrame;
}

-(void)createScrollView:(CGRect)viewBounds {
  // Create the scroll view
  self.containerScrollView  = [[SWScrollView alloc] initWithFrame:viewBounds];
  self.containerScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.containerScrollView.showsHorizontalScrollIndicator = NO;
  self.containerScrollView.showsVerticalScrollIndicator = NO;
  self.containerScrollView.delegate = self;
  static const CGFloat MaxScale = 1.5;
  self.containerScrollView.maximumZoomScale = MaxScale;
  [self.view addSubview:self.containerScrollView];
}

-(void)createImageView:(CGRect)viewBounds {
  self.fullImageView = [[UIImageView alloc] initWithFrame:viewBounds];
  
  self.fullImageView.contentMode = UIViewContentModeScaleAspectFill;
  self.fullImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  self.fullImageView.clipsToBounds = YES;
  [self.containerScrollView addSubview:self.fullImageView];
}

-(void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
}

-(void)orientationChanged:(NSNotification *)object{
  // we have to remove the image and scroll views and re-add them because the
  // navigation bar size changes when the orientation changes
  [self.fullImageView removeFromSuperview];
  [self.containerScrollView removeFromSuperview];
  [self createViews];
  [self setupImageInScrollView];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (self.photoFetchState == SWPhotosNotFetched) {
    [self showPhotoAfterDownload];
  }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return self.fullImageView;
}

-(void)showPhotoAfterDownload {
  ShowNetworkActivityIndicator();
  SDWebImageManager *manager = [SDWebImageManager sharedManager];
  [manager downloadWithURL:[self.flickrPhoto bigImageUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    self.progressView.hidden = NO;
    float receivedSizeFloat = [[NSNumber numberWithInteger:receivedSize] floatValue];
    float expectedSizeFloat = [[NSNumber numberWithInteger:expectedSize] floatValue];
    float downloadProgress = receivedSizeFloat/expectedSizeFloat;
    if (downloadProgress > 0.00f) { // address weird case where progress is -0.00
      [self.progressView setProgress:downloadProgress animated:YES];
    }
  } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
    
    if(image){
      dispatch_async(dispatch_get_main_queue(), ^{
        HideNetworkActivityIndicator();
        if (IPAD) {
          self.fullImageView.image = image;
        } else if (IPHONE) {
          self.fullImage = [[UIImage alloc] init];
          self.fullImage = image;
          [self setupImageInScrollView];
        }
        self.progressView.hidden = YES;
        [self slideAnimateImage];
        self.photoFetchState = SWPhotosFetched;
        
      });
    }
    
  }];
 
  NSString *photoTitle = [self.flickrPhoto title];
  if ([photoTitle isEqualToString:@""]) {
    photoTitle = @"Title not available";
    self.commentTextView.textColor = [UIColor grayColor];
  }
  self.commentTextView.text = photoTitle;
  self.commentTextView.textAlignment = NSTextAlignmentCenter;
  self.commentTextView.font = [UIFont fontWithName:@"Helvetica Neue" size:19.0f];
  
}

-(void)setupImageInScrollView {
  self.containerScrollView.minimumZoomScale = 1;
  self.containerScrollView.zoomScale = 1;
  
  self.fullImageView.frame = CGRectMake(0, 0, self.fullImage.size.width, self.fullImage.size.height);
  self.fullImageView.image = self.fullImage;
  self.containerScrollView.contentSize = self.fullImage.size;
  
  // Calculate Min
  const CGSize viewSize = self.containerScrollView.bounds.size;
  const CGFloat xScale = viewSize.width / self.fullImage.size.width;
  const CGFloat yScale = viewSize.height / self.fullImage.size.height;
  const CGFloat minScale = MIN(xScale, yScale);
  
  self.containerScrollView.minimumZoomScale = MIN(minScale, 1);
  
  self.containerScrollView.zoomScale = self.containerScrollView.minimumZoomScale;
  
  self.containerScrollView.contentOffset = CGPointZero; // center the image
  
  
}

-(void)slideAnimateImage {
  CATransition *animation = [CATransition animation];
  [animation setDuration:1.0];
  [animation setType:kCATransitionPush];
  [animation setSubtype:kCATransitionFromRight]; 
  [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
  [[self.fullImageView layer] addAnimation:animation forKey:nil];
}


@end
