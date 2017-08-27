//
//  UserListViewController.m
//  MicroSport
//
//  Created by Satya on 26/08/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "UserListViewController.h"
#import "UserListTableViewCell.h"
#import "Reachability.h"
#import "WebApiHandler.h"
#import "SVProgressHUD.h"
#import "SharedMS.h"
#import "CommonUtility.h"

@interface UserListViewController (){

    NSMutableArray *arrAllUserList;
    NSMutableArray *selectedUsersArray;
}

@end

@implementation UserListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectedUsersArray = [[NSMutableArray alloc] init];
    
    if ([[CommonUtility sharedInstance].selectedTeamMembersArray count] > 0) {
         [selectedUsersArray addObjectsFromArray:[CommonUtility sharedInstance].selectedTeamMembersArray];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self callwebserviceForGetAllUsers];
    });
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

- (IBAction)backBtnClicked:(id)sender {
    
    [[CommonUtility sharedInstance] storeSelectedTeamMemebers:selectedUsersArray];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)checkMarkBtnClicked:(id)sender {

    UIButton *button = (UIButton *)sender;
    
    if ([[[arrAllUserList objectAtIndex:button.tag] valueForKey:@"isSelected"] isEqualToString:@"yes"]) {
        return;
    }
    
    [[arrAllUserList objectAtIndex:button.tag] setValue:@"yes" forKey:@"isSelected"];
    [[arrAllUserList objectAtIndex:button.tag] setValue:[NSString stringWithFormat:@"%ld", (long)button.tag] forKey:@"selectedIndex"];
    [selectedUsersArray addObject:[arrAllUserList objectAtIndex:button.tag]];
    
    NSArray *indexPathArray = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:button.tag inSection:0]];
    [_userlistTableView reloadRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];

}

#pragma MARK : UITableView Delegetes

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrAllUserList count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"UserListTableViewCell";
    
    UserListTableViewCell *cell = (UserListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UserListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.checkMarkBtn.tag = indexPath.row;
    
    if ([[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"first_name"] length] > 0 && [[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"last_name"] length] > 0) {
        [cell.userNameLbl setText:[NSString stringWithFormat:@"%@ %@", [[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"first_name"], [[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"last_name"]]];
    }else if ([[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"first_name"] length] > 0 && [[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"last_name"] length] == 0) {
        [cell.userNameLbl setText:[NSString stringWithFormat:@"%@", [[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"first_name"]]];
    }else if ([[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"first_name"] length] == 0 && [[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"last_name"] length] == 0) {
        [cell.userNameLbl setText:[NSString stringWithFormat:@"%@", [[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"last_name"]]];
    }

    if ([[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"image_url"] length] > 0) {
         [cell.userImageVw loadImage:[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"image_url"]];
    }
    
    [cell.checkMarkBtn setImage:[UIImage imageNamed:@"box"] forState:UIControlStateNormal];
    [cell.checkMarkBtn addTarget:self action:@selector(checkMarkBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[[arrAllUserList objectAtIndex:indexPath.row] valueForKey:@"isSelected"] isEqualToString:@"yes"]) {
        
        [cell.checkMarkBtn setImage:[UIImage imageNamed:@"check2"] forState:UIControlStateNormal];
    }
    
    return cell;
}

#pragma mark Webservice Calling
-(void)callwebserviceForGetAllUsers
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
        __weak typeof (self) weakSelf = self;
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"Processing..."];
        
        NSString *userId = [[[SharedMS instance] getUserInfo] objectForKey:@"user_id"];
        NSDictionary *parameters = @{@"user_id" : userId, @"game_type_id" : @"1"};
        
        [[WebApiHandler sharedHandler] getGameUserListParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            NSLog(@"%@", response);
            if ([[response objectForKey:@"success"] boolValue])
            {
                [self storeMutableObjects:[response objectForKey:@"data"]];
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"User Doesn't Exist! Please try again" preferredStyle:UIAlertControllerStyleAlert];
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

- (void)storeMutableObjects:(NSArray *)array{
    
    if (arrAllUserList == nil) {
        arrAllUserList = [[NSMutableArray alloc] init];
    }else  if (arrAllUserList.count > 0){
    
        [arrAllUserList removeAllObjects];
    }

    if (array.count > 0) {
        for (id object in array) {
            NSMutableDictionary *mutableObject =  [[CommonUtility sharedInstance] createMutableDict:object];
            [mutableObject setValue:@"no" forKey:@"isSelected"];
            [arrAllUserList addObject:[[CommonUtility sharedInstance] createMutableDict:mutableObject]];
        }
    }
    
    for (NSMutableDictionary *dict in selectedUsersArray) {
        [arrAllUserList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
         {
             if ([[dict valueForKey:@"isSelected"] isEqualToString:@"yes"] && [[dict valueForKey:@"selectedIndex"] integerValue] == idx)
             {
                 NSMutableDictionary *mutableObject =  [[CommonUtility sharedInstance] createMutableDict:obj];
                 [mutableObject setValue:@"yes" forKey:@"isSelected"];
                 [arrAllUserList replaceObjectAtIndex:idx withObject:mutableObject];
             }
         }];
    }
    
    [_userlistTableView reloadData];
}

@end
