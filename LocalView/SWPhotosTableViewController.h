//
//  SWPhotosTableViewController.h
//  LocalView
//
//  Created by Zach Freeman on 8/6/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWPhotoListManager.h"


@interface SWPhotosTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,SWPhotoListManagerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

-(IBAction)refreshButtonTapped:(id)sender;

@end

