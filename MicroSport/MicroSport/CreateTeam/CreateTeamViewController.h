//
//  CreateTeamViewController.h
//  MicroSport
//
//  Created by Satya Kumar on 8/12/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyTextField.h"

@interface CreateTeamViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MyTextField *teamNameTxtFld;
@property (weak, nonatomic) IBOutlet MyTextField *sportNameTxtFld;
@property (weak, nonatomic) IBOutlet UITextView *teamBioTxtFld;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end
