//
//  LeftViewController.m
//  MicroSport
//
//  Created by John on 01/05/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "SharedMS.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <TwitterKit/TwitterKit.h>
#import "EditProfileViewController.h"
#import "UIImageView+AFNetworking.h"
#import "HomeViewController.h"



@interface LeftViewController ()
{
    NSMutableArray *arrMenuTitle;
    NSMutableArray *arrMenuImages;

}
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrMenuTitle = [[NSMutableArray alloc] initWithObjects:@"Home",@"Organize game",@"Organize Team",@"Message",@"Profile",@"Notification",@"Faq",@"Terms", nil];
    arrMenuImages = [[NSMutableArray alloc] initWithObjects:@"home",@"game",@"team",@"messages",@"profile",@"notifications",@"faq",@"terms", nil];

    
    NSDictionary *userInfo = [[SharedMS instance] getUserInfo];
    
    
    if(userInfo != nil && userInfo.count>0)
    {
        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",kAPIBaseURL,[userInfo objectForKey:@"image_url"]];
        [self.imgViewProfile setImageWithURL:[NSURL URLWithString:imageUrl]];
        
        self.lblUserName.text = [NSString stringWithFormat:@"%@ %@",[userInfo objectForKey:@"first_name"],[userInfo objectForKey:@"last_name"]];
        
        if ([self.lblUserName.text containsString:@"null"])
        {
            self.lblUserName.text = [userInfo objectForKey:@"email"];
        }
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrMenuTitle.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftTableViewCell *cell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"LeftTableViewCell"];
    if (cell == nil) {
        cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LeftTableViewCell"];
    }
    
    NSString  *menuTitle = [arrMenuTitle objectAtIndex:indexPath.row];
    cell.lblMenuTitle.text = menuTitle;
    
    NSString *imageName = [arrMenuImages objectAtIndex:indexPath.row];
    UIImage *menuImages = [UIImage imageNamed:imageName];
    cell.imgIcons.image = menuImages;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self.view endEditing:YES];
    
    
    if (indexPath.row == 4)
    {
        
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"]];
        controller.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:controller
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        [self.navigationController setNavigationBarHidden:YES];
    }
    else
        
    {
        
        HomeViewController *homeController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        homeController.title = [arrMenuTitle objectAtIndex:indexPath.row];
        UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:homeController];
        controller.navigationBar.hidden = YES;
        [self.sideMenuViewController setContentViewController:controller
                                                     animated:YES];
        [self.sideMenuViewController hideMenuViewController];
        
        

    }

}


#pragma mark Action
- (IBAction)logoutButtonAction:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *signInVc = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [[SharedMS instance] setUserInfo:nil];

    keyWindow.rootViewController = signInVc;
    [keyWindow makeKeyAndVisible];
    
    
    
    // logout from facebook
    [FBSDKAccessToken setCurrentAccessToken:nil];
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    // logout from twitter
    
    
    NSDictionary *userInfo = [[SharedMS instance] getUserInfo];
    [[[Twitter sharedInstance] sessionStore] logOutUserID:[userInfo objectForKey:@"user_id"]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
