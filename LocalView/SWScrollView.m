//
//  SWScrollView.m
//  LocalView
//
//  Created by Zach Freeman on 8/27/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWScrollView.h"

@implementation SWScrollView

- (void)setContentOffset:(CGPoint)contentOffset
{
  CGSize contentSize = self.contentSize;
  CGSize scrollViewSize = self.bounds.size;
  
  if (contentSize.width < scrollViewSize.width)
  {
    contentOffset.x = -(scrollViewSize.width - contentSize.width) / 2.0;
  }
  
  if (contentSize.height < scrollViewSize.height)
  {
    contentOffset.y = -(scrollViewSize.height - contentSize.height) / 2.0;
  }
  
  [super setContentOffset:contentOffset];
}

@end
