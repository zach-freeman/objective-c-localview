//
//  SWPhotoLoadViewController.h
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPhotoLoadViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *loadingLabel;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *spinner;

-(void)updateLoadingLabel:(NSString*)theLoadingText;

@end
