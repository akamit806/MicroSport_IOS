//
//  AppConstants.h
//  AppWEAR
//
//  Created by John on 21/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^RequestCompletionHandler)(NSDictionary *response);
typedef void(^RequestFailureHandler)(NSError *error);

#pragma -mark APIs

FOUNDATION_EXPORT NSString *const kAPIBaseURL;

FOUNDATION_EXPORT NSString *const kSignUp;
FOUNDATION_EXPORT NSString *const kLogin;
FOUNDATION_EXPORT NSString *const kGetUserProfile;
FOUNDATION_EXPORT NSString *const kUpdateUserProfile;
FOUNDATION_EXPORT NSString *const kForgotPassword;


// Common Messages

FOUNDATION_EXPORT NSString *const kMessageNetworkNotAvailable;

#pragma -mark Other Constants

FOUNDATION_EXPORT NSString *const kLoggedInUser;
