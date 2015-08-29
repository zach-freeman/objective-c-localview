//
//  SWViewController.m
//  LocalView
//
//  Created by Zach Freeman on 8/6/15.
//  Copyright (c) 2015 sparkwing. All rights reserved.
//

#import "SWPhotosTableViewController.h"
#import "SWPhotoTableCell.h"
#import "SWFlickrPhoto.h"
#import "SWPhotoLoadViewController.h"
#import "SWPhotoFullScreenViewController.h"
#import "SWPublicConstants.h"
#import <QuartzCore/CALayer.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "SWUtils.h"

@interface SWPhotosTableViewController ()


@property (nonatomic, assign) SWPhotoFetchState photoFetchState;
@property (nonatomic, strong) NSMutableArray *flickrPhotos;
@property (nonatomic, strong) SWPhotoListManager *photoListManager;
@property (nonatomic, strong) SWPhotoLoadViewController *photoLoadViewController;

@end

@implementation SWPhotosTableViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.photoLoadViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SWPhotoLoadViewController"];
  self.photoFetchState = SWPhotoListNotFetched;
}

-(void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  if (self.photoFetchState == SWPhotoListNotFetched) {
    [self startPhotoListManager];
  }
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(IBAction)refreshButtonTapped:(id)sender {
  self.photoFetchState = SWPhotoListNotFetched;
  self.tableView.hidden = NO;
  [self startPhotoListManager];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [self.flickrPhotos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  SWPhotoTableCell *cell = (SWPhotoTableCell *)[tableView dequeueReusableCellWithIdentifier:@"SWPhotoTableCell"];
  CALayer *cellImageLayer = cell.photoPreview.layer;
  [SWUtils setupRoundedCornersForLayer:cellImageLayer];
  
  NSURL *cellSmallImageUrl = [[self.flickrPhotos objectAtIndex:[indexPath row]] smallImageUrl];
  UIImage *placeholderImage = [UIImage imageNamed:@"placeholder.png"];
  [cell.photoPreview setImageWithURL:cellSmallImageUrl placeholderImage:placeholderImage];
  
  NSString *photoTitle = [(SWFlickrPhoto*)[self.flickrPhotos objectAtIndex:[indexPath row]] title];
  if ([photoTitle isEqualToString:@""]) {
    photoTitle = @"Title not available";
    cell.photoTitleLabel.textColor = [UIColor grayColor];
  } else {    
    cell.photoTitleLabel.textColor = [UIColor blackColor];
  }
  cell.photoTitleLabel.text = photoTitle;
  
  return cell;
  
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  NSIndexPath *senderPath = [self.tableView indexPathForCell:sender];
  NSUInteger selectedRow = senderPath.row;
  SWFlickrPhoto *flickrPhoto = (SWFlickrPhoto*)[self.flickrPhotos objectAtIndex:selectedRow];
  
  SWPhotoFullScreenViewController *photoFullScreenViewController = (SWPhotoFullScreenViewController* )[segue destinationViewController];
  photoFullScreenViewController.flickrPhoto = flickrPhoto;
}

#pragma mark - Photo List Manager
-(void)startPhotoListManager {
  [self.navigationController presentViewController:self.photoLoadViewController animated:NO completion:nil];
  self.photoListManager = [[SWPhotoListManager alloc] init];
  self.photoListManager.delegate = self;
}

-(void)photoListManagerDidFinish:(SWPhotoListManager *)photoListManager {
  self.photoFetchState = SWPhotoListFetched;
  if (photoListManager.flickrPhotos.count > 0) {
    self.flickrPhotos = photoListManager.flickrPhotos;
  }
  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  [self.tableView reloadData];
}



@end
