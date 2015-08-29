//
//  SWPhotoTableCell.h
//  LocalView
//
//  Created by Zach Freeman on 8/7/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWPhotoTableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *photoPreview;
@property (nonatomic, weak) IBOutlet UILabel *photoTitleLabel;

@end
