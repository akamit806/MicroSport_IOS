//
//  ETLeftMenuViewController.h
//  UNEYE
//
//  Created by Satya 2015 on 28/11/14.
//  Copyright (c) Satya 2015 All rights reserved.
//

#import "AMSlideMenuLeftTableViewController.h"
#import "AsyncImageView.h"

@interface ETLeftMenuViewController : AMSlideMenuLeftTableViewController

@property (weak, nonatomic) IBOutlet AsyncImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end
