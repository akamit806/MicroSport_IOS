//
//  ETMenuViewController.m
//  MicroSport
//
//  Created by Satya 2015 on 28/11/14.
//  Copyright (c) Satya 2015 All rights reserved.
//

#import "ETMenuViewController.h"
#import "AppDelegate.h"
#import "CommonUtility.h"


@interface ETMenuViewController () {
    NSString *user_type;
    
    NSString *user_ID;
}

//--- Defined AppDelegate Object ---
#define kAppDelegete (AppDelegate*)[[UIApplication sharedApplication]delegate]

@end

@implementation ETMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
//    user_type = [[[CommonUtility sharedInstance].userDictionary valueForKey:@"data"] valueForKey:@"user_type"];
    
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSString *)segueIdentifierForIndexPathInLeftMenu:(NSIndexPath *)indexPath
{
    
    NSString *identifier = @"";
    switch (indexPath.row)
    {
        case 0 :
             //identifier = @"profilesegue";
            //break;
        case 1 :
            identifier = @"home";
            break;
//        case 2 :
//            identifier = @"home";
//            break;
//        case 3 :
//            identifier = @"home";
//            break;
//        case 4 :
//            identifier = @"home";
//            break;
//        case 5 :
//            identifier = @"home";
//            break;
//        case 6 :
//            identifier = @"home";
//            break;
    }
    
    return identifier;
}

- (CGFloat)leftMenuWidth
{
    return 250;
}

- (void)configureLeftMenuButton:(UIButton *)button
{
    CGRect frame = button.frame;
    frame = CGRectMake(10,0, 30, 20);
    button.frame = frame;
    button.backgroundColor = [UIColor clearColor];
    [button setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
}

- (void) configureSlideLayer:(CALayer *)layer
{
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 2;
    layer.masksToBounds = NO;
    layer.shadowPath =[UIBezierPath bezierPathWithRect:self.view.layer.bounds].CGPath;
}

- (AMPrimaryMenu)primaryMenu
{

    return AMPrimaryMenuLeft;
}

- (BOOL)deepnessForLeftMenu
{
    return YES;
}

- (CGFloat)maxDarknessWhileLeftMenu
{
    return 0.5;
}
 
@end
