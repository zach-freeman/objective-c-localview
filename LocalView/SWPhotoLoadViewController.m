//
//  SWPhotoLoadViewController.m
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWPhotoLoadViewController.h"
#import "SWUtils.h"

@interface SWPhotoLoadViewController ()

@end

@implementation SWPhotoLoadViewController

- (void)viewDidLoad {
  [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  ShowNetworkActivityIndicator();
  [self.spinner startAnimating];
}

-(void)viewDidDisappear:(BOOL)animated {
  [super viewDidDisappear:animated];
  HideNetworkActivityIndicator();
  [self.spinner stopAnimating];
}

-(void)updateLoadingLabel:(NSString*)theLoadingText {
  dispatch_async(dispatch_get_main_queue(), ^{
    self.loadingLabel.text = theLoadingText;
    [self.loadingLabel setNeedsDisplay];
  });
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
