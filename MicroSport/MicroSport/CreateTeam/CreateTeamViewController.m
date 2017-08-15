//
//  CreateTeamViewController.m
//  MicroSport
//
//  Created by Satya Kumar on 8/12/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "CreateTeamViewController.h"
#import "CommonUtility.h"

@interface CreateTeamViewController ()

@end

@implementation CreateTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark IBActions
- (IBAction)backBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureUI{

    UIColor *color = [UIColor whiteColor];
    
    _teamNameTxtFld.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _teamNameTxtFld.layer.borderWidth = 1.0;
    _teamNameTxtFld.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_teamNameTxtFld imageName:nil width:16];
    _teamNameTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Team Name" attributes:@{NSForegroundColorAttributeName: color}];
    
    _sportNameTxtFld.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _sportNameTxtFld.layer.borderWidth = 1.0;
    _sportNameTxtFld.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_sportNameTxtFld imageName:nil width:16];
    _sportNameTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Sport" attributes:@{NSForegroundColorAttributeName: color}];
    
    _teamBioTxtFld.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _teamBioTxtFld.layer.borderWidth = 1.0;
    _teamBioTxtFld.layer.masksToBounds = YES;
    
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(self.doneBtn.frame) + 1000)];
}

@end
