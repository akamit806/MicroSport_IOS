//
//  AppConstants.m
//  MicroSport
//
//  Created by John on 21/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "AppConstants.h"

#pragma -mark APIs

NSString *const kAPIBaseURL     =       @"http://www.wwc-testing.com/microsport/sport_api.php?";

NSString *const kSignUp         =       @"Method=SignUp";
NSString *const kLogin          =       @"Method=SignIn";
NSString *const kGetUserProfile          =       @"Method=GetProfile";
NSString *const kUpdateUserProfile          =       @"Method=GetProfile";
NSString *const kForgotPassword          =       @"Method=ForgotPassword";
NSString *const kGetGameUserList          =       @"Method=Get_game_user_list";
NSString *const kCreateTeam          =       @"Method=CreateTeam";

#pragma -mark Common Messages

NSString *const kMessageNetworkNotAvailable    =   @"Internet connection is not reachable, Please try later.";

#pragma -mark Other Constants

NSString *const kLoggedInUser   =       @"LoggedInUser";
