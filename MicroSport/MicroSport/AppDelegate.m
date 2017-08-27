//
//  AppDelegate.m
//  MicroSport
//
//  Created by John on 28/04/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "UIColor+AppColor.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "RESideMenu.h"
#import "LeftViewController.h"
#import "EditProfileViewController.h"
#import "SharedMS.h"
#import "ETMenuViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setBarTintColor:[UIColor darkGrayColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [[Twitter sharedInstance] startWithConsumerKey:@"hLfC5fVrY6szuDCgTxA7BilFv" consumerSecret:@"6Rq3EdZnXSuUj613w1qmS5qDkCkzkDF4OEUXa7wfqpPk3MFTiU"];
    [Fabric with:@[[Twitter class]]];
    
    
    
    
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];

    
    //if ([[SharedMS instance] getUserInfo] != nil)
    if ([[SharedMS instance] getUserInfo] == nil)
    {
        
        //--- Navigate to home screen ---
        UIStoryboard *mStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ETMenuViewController *controller=[mStoryboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
        self.window.rootViewController = controller;
        
         return NO;
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            UINavigationController *homeController = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
//            LeftViewController *leftController = (LeftViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
//        
//            RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:homeController leftMenuViewController:leftController rightMenuViewController:nil];
//            sideMenu.contentViewShadowColor = [UIColor blackColor];
//            sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
//            sideMenu.contentViewShadowOpacity = 0.6;
//            sideMenu.contentViewInPortraitOffsetCenterX = 100;
//            sideMenu.contentViewShadowRadius = 12;
//            sideMenu.contentViewShadowEnabled = YES;
//            sideMenu.scaleContentView = NO;
//            sideMenu.scaleMenuView = NO;
//            self.window.rootViewController = sideMenu;
//            [self.window makeKeyAndVisible];
        
        }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
      [FBSDKAppEvents activateApp];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
    
    


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
                                                               annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
                    ];
    
    // Facebook
    if (handled)
    {
        return handled;
    }
    
    // Twitter
    if ([[Twitter sharedInstance] application:application openURL:url options:options]) {
        return YES;
    }
    
    return NO;
}

- (void) logout{
    
    //--- Remove User Data ---
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userdata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSString *user_id = [[[CommonUtility sharedInstance].userDictionary valueForKey:@"data"] valueForKey:@"user_id"];
//    
//    [self logoutAPI:user_id];
}

@end
