//
//  ViewController.m
//  MicroSport
//
//  Created by John on 28/04/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self performSelector:@selector(navigateToSignInControler) withObject:nil afterDelay:5.0];
}

-(void)navigateToSignInControler
{
    [self performSegueWithIdentifier:@"SignInViewControllerSegue" sender:nil];
}

@end
