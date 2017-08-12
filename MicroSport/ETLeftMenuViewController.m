//
//  ETLeftMenuViewController.m
//
//  Created by Satya 2015 on 28/11/14.
//  Copyright (c) Satya 2015 All rights reserved.
//

#import "ETLeftMenuViewController.h"
#import "CommonUtility.h"
#import "LeftTableViewCell.h"

@interface ETLeftMenuViewController ()

@property (strong, nonatomic) UITableView *myTableView;

@end

@implementation ETLeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSDictionary *userInfo = [[SharedMS instance] getUserInfo];
//    
//    
//    if(userInfo != nil && userInfo.count>0)
//    {
//        NSString *imageUrl = [NSString stringWithFormat:@"%@%@",kAPIBaseURL,[userInfo objectForKey:@"image_url"]];
//        [self.imgViewProfile setImageWithURL:[NSURL URLWithString:imageUrl]];
//        
//        self.lblUserName.text = [NSString stringWithFormat:@"%@ %@",[userInfo objectForKey:@"first_name"],[userInfo objectForKey:@"last_name"]];
//        
//        if ([self.lblUserName.text containsString:@"null"])
//        {
//            self.lblUserName.text = [self.lblUserName.text stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
//        }
//    }

    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
    
//    [self.view setBackgroundColor:[UIColor colorWithRed:(23/255.0) green:(46/255.0) blue:(111/255.0) alpha:0]];
    
    [self setNeedsStatusBarAppearanceUpdate];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && ![UIApplication sharedApplication].isStatusBarHidden)
    {
        self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    }
    
    //--- Register noification for update UI ---
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveNotification:)
                                                 name:@"Updateprofiledata"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

//--- Register noification for update UI ---
- (void) receiveNotification:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    
    if ([[notification name] isEqualToString:@"Updateprofiledata"])
    {
        if ([[[userInfo valueForKey:@"data"] valueForKey:@"user_type"] isEqualToString:@"3"]) {
            NSString *prfileImageUrl = [[userInfo valueForKey:@"data"] valueForKey:@"user_image"];
            
            if(![prfileImageUrl hasPrefix:@"http://"] && [prfileImageUrl length] > 0)
            {
                prfileImageUrl = [NSString stringWithFormat:@"http://%@", [userInfo valueForKey:@"profile_image"]];
            }
            
            [_profileImgView loadBackgroundImage:prfileImageUrl];
            
            _lblName.text = [[[CommonUtility sharedInstance].userDictionary valueForKey:@"data"] valueForKey:@"company_name"];
        }
        else {
            NSString *prfileImageUrl = [[userInfo valueForKey:@"data"] valueForKey:@"user_image"];
            
            if(![prfileImageUrl hasPrefix:@"http://"] && [prfileImageUrl length] > 0)
            {
                prfileImageUrl = [NSString stringWithFormat:@"http://%@", [userInfo valueForKey:@"profile_image"]];
            }
            
            [_profileImgView loadBackgroundImage:prfileImageUrl];
            
            _lblName.text = [NSString stringWithFormat: @"%@ %@",
                             [[[CommonUtility sharedInstance].userDictionary valueForKey:@"data"] valueForKey:@"first_name"], [[[CommonUtility sharedInstance].userDictionary valueForKey:@"data"] valueForKey:@"last_name"]];
        }
    }
}


#pragma mark Action
- (IBAction)logoutButtonAction:(id)sender {
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *signInVc = [storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
//    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
//    
//    keyWindow.rootViewController = signInVc;
//    [keyWindow makeKeyAndVisible];
//    
//    
//    
//    // logout from facebook
//    [FBSDKAccessToken setCurrentAccessToken:nil];
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    [loginManager logOut];
//    
//    // logout from twitter
//    
//    
//    NSDictionary *userInfo = [[SharedMS instance] getUserInfo];
//    [[[Twitter sharedInstance] sessionStore] logOutUserID:[userInfo objectForKey:@"user_id"]];
//    
//    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *each in cookieStorage.cookies) {
//        // put a check here to clear cookie url which starts with twitter and then delete it
//        [cookieStorage deleteCookie:each];
//    }
//    
//    [[SharedMS instance] setUserInfo:nil];
    
}

- (IBAction)profileImageClicked:(id)sender{
    
//    UINavigationController *controller = [[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileViewController"]];
//    controller.navigationBar.hidden = YES;
//    [self.sideMenuViewController setContentViewController:controller
//                                                 animated:YES];
//    [self.sideMenuViewController hideMenuViewController];
//    [self.navigationController setNavigationBarHidden:YES];
}


@end
