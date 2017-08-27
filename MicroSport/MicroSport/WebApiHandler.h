//
//  WebApiHandler.h
//  MicroSport
//
//  Created by John on 20/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

@interface WebApiHandler : NSObject

+(instancetype)sharedHandler;

-(NSURLSessionTask *)loginWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
-(NSURLSessionTask *)signUpWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
-(NSURLSessionTask *)getUserInfoWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
-(NSURLSessionTask *)updateUserInfoWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
-(NSURLSessionTask *)forgotPasswordWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
-(NSURLSessionTask *)getGameUserListParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;
-(NSURLSessionTask *)createTeamWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure;

@end
