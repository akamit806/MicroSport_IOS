//
//  WebApiHandler.m
//  MicroSport
//
//  Created by John on 20/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "WebApiHandler.h"
#import "AFNetworking.h"
#import "AppConstants.h"

@interface WebApiHandler ()
{
    AFHTTPSessionManager *sessionManager;
}

@end

@implementation WebApiHandler

+(instancetype)sharedHandler
{
    static WebApiHandler *handler = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        handler = [[WebApiHandler alloc] init];
    });
    return handler;
}

-(instancetype)init
{
    self = [super init];
    [self initialize];
    return self;
}

-(void)initialize
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    [configuration setTimeoutIntervalForRequest:60.0];
    [configuration setTimeoutIntervalForResource:300.0];
    sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kAPIBaseURL] sessionConfiguration:configuration];
    [sessionManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [sessionManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
}

#pragma -mark Internal Methods

-(NSURLSessionTask *)GET:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager GET:apiPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

-(NSURLSessionTask *)POST:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager POST:apiPath parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

-(NSURLSessionTask *)PUT:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager PUT:apiPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

-(NSURLSessionTask *)DELETE:(NSString *)apiPath parameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    return [sessionManager DELETE:apiPath parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject)
        {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

#pragma -mark Custom APIs

-(NSURLSessionTask *)loginWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *loginPath = [kAPIBaseURL stringByAppendingString:kLogin];
    return [self POST:loginPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)signUpWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *signUpPath = [kAPIBaseURL stringByAppendingString:kSignUp];
    return [self POST:signUpPath parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)getUserInfoWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *Path = [kAPIBaseURL stringByAppendingString:kGetUserProfile];
    return [self POST:Path parameters:parameters success:success failure:failure];
}


-(NSURLSessionTask *)updateUserInfoWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *Path = [kAPIBaseURL stringByAppendingString:kUpdateUserProfile];
    return [self POST:Path parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)forgotPasswordWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *Path = [kAPIBaseURL stringByAppendingString:kForgotPassword];
    return [self POST:Path parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)getGameUserListParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *Path = [kAPIBaseURL stringByAppendingString:kGetGameUserList];
    return [self POST:Path parameters:parameters success:success failure:failure];
}

-(NSURLSessionTask *)createTeamWithParameters:(NSDictionary *)parameters success:(RequestCompletionHandler)success failure:(RequestFailureHandler)failure
{
    NSString *createTeamPath = [kAPIBaseURL stringByAppendingString:kCreateTeam];
    return [self POST:createTeamPath parameters:parameters success:success failure:failure];
}


@end
