//
//  CreateTeamViewController.m
//  MicroSport
//
//  Created by Satya Kumar on 8/12/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "CreateTeamViewController.h"
#import "CommonUtility.h"
#import "SharedMS.h"

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
    
    [self backWithAction];
}

- (IBAction)createTeamBtnClicked:(id)sender {
    
    [self createTeamAPICall];
}

- (void)backWithAction{

    if ([[CommonUtility sharedInstance].selectedTeamMembersArray count] > 0) {
        
        [[CommonUtility sharedInstance].selectedTeamMembersArray removeAllObjects];
    }
    
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
    [CommonUtility setLeftPadding:_sportNameTxtFld imageName:@"soccer" width:50];
    _sportNameTxtFld.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Soccer" attributes:@{NSForegroundColorAttributeName: color}];
    _sportNameTxtFld.text = @"Soccer";
    _sportNameTxtFld.userInteractionEnabled = NO;
    
    _teamBioTxtFld.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _teamBioTxtFld.layer.borderWidth = 1.0;
    _teamBioTxtFld.layer.masksToBounds = YES;
    
    
    [self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(self.doneBtn.frame) + 1000)];
}

#pragma Mark create Team API
- (void)createTeamAPICall
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        if ([_teamNameTxtFld.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter Team name." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_sportNameTxtFld.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter sport type." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            
            if ([[CommonUtility sharedInstance].selectedTeamMembersArray count] == 0) {
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please select team members" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                
                return;
            }
            
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Processing..."];
            
            NSString *userId = [[[SharedMS instance] getUserInfo] objectForKey:@"user_id"];
            
            /*
             {
             "user_id":"123",
             "team_name":"My Team 1",
             "team_game_id":"1234",
             "team_game_type_image_url": multipart image,
             "team_bio":"This is my team and details",
             "team_members":"34,35,36"
             }
             */
            
            NSMutableArray *selectedIdArr = [[NSMutableArray alloc] init];
            for (NSDictionary *dict in [CommonUtility sharedInstance].selectedTeamMembersArray) {
                [selectedIdArr addObject:[dict valueForKey:@"user_id"]];
            }
            
            NSString *teamMemIdStr = [selectedIdArr componentsJoinedByString:@","];
            
            NSDictionary *parameters = @{@"user_id" : userId, @"team_name" : _teamNameTxtFld.text, @"team_game_id" : @"1", @"team_members": teamMemIdStr, @"team_bio" : (_teamBioTxtFld.text.length > 0 ? _teamBioTxtFld.text : @"")};
            
            [[WebApiHandler sharedHandler] createTeamWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                NSLog(@"%@", response);
                if ([[response objectForKey:@"success"] boolValue])
                {
                    if ([response objectForKey:@"data"] != nil)
                    {
                        [self backWithAction];
                        
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Your team created successfully." preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                        
                        id rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
                        if([rootViewController isKindOfClass:[UINavigationController class]])
                        {
                            rootViewController=[((UINavigationController *)rootViewController).viewControllers objectAtIndex:0];
                        }
                        [rootViewController presentViewController:alertController animated:YES completion:nil];
                    }
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
                
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }];
        }
    }
}

@end
