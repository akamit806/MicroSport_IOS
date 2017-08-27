//
//  UserListTableViewCell.h
//  MicroSport
//
//  Created by Satya on 26/08/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface UserListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet AsyncImageView *userImageVw;
@property (weak, nonatomic) IBOutlet UILabel *userNameLbl;
@property (weak, nonatomic) IBOutlet UIButton *checkMarkBtn;

@end
