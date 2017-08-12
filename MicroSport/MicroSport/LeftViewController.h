//
//  LeftViewController.h
//  MicroSport
//
//  Created by John on 01/05/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "BaseViewController.h"

#import "AMSlideMenuLeftTableViewController.h"
#import "AsyncImageView.h"

@interface LeftViewController : AMSlideMenuLeftTableViewController //BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;

@property (weak, nonatomic) IBOutlet AsyncImageView *profileImgView;

@end
