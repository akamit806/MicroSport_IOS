//
//  CommonClass.h
//  MicroSport
//
//  Created by Satya Kumar on 29/07/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CommonUtility : NSObject <MKMapViewDelegate,CLLocationManagerDelegate>

+(CommonUtility *)sharedInstance;
@property (nonatomic,strong) NSString *deviceToken;
@property (nonatomic,strong) NSString *numberTyped;
@property (nonatomic,strong) NSString *nameforuser;
@property  CGRect keyboardRect;
@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) NSMutableDictionary *userDictionary;
@property (nonatomic,strong) NSMutableArray *arrayPerentGroup;
@property (nonatomic,strong) NSString *mapShow;
@property (nonatomic,strong) CLLocation *userlocation;

//Multiple user login array ...
@property (nonatomic,strong) NSMutableArray *multipledataArray;

//--- Store Chat List ---
@property (nonatomic,strong) NSMutableArray *chatListArray;
-(void)storeChatList:(NSMutableArray *)array;

//--- Store Chat List ---
@property (nonatomic,strong) NSMutableArray *selectedTeamMembersArray;
-(void)storeSelectedTeamMemebers:(NSMutableArray *)array;

@property int count1;
@property  float  getLat;
@property  float  getLong;

+(UIView*)makeRoundedView:(UIView*)view withBorderColor:(UIColor*)borderColor andBorderWidth:(float)borderWidth;
#pragma mark - Textfield Padding
+(void)setLeftPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width;
+(void)setRightPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width;

#pragma mark - Session
-(void)initializeUser:(NSDictionary*)dictionary;
-(void)addFireBaseUserInfo:(NSMutableDictionary *)dictionary key:(NSString *)key;
-(void)addUserInfo:(NSDictionary *)dictionary;
-(void)logoutAndRemoveUserData;
- (NSMutableDictionary *)createMutableDict:(NSDictionary *)dict;

# pragma mark - validation
-(BOOL)Emailvalidate:(NSString *)tempMail;
-(void)updateCurrentLocation;
-(BOOL)isAlphabetical:(NSString *)text;
-(BOOL)isOnlySpace:(NSString *)text;
-(BOOL)isNumeric:(NSString*)inputString;
-(BOOL)isAlphaNumeric:(NSString *)input;
-(BOOL)validateMobileNumber:(NSString *)mobileNumber;

-(NSString *)removeSpacialChar:(NSString *)str;

-(void)setLatLong:(float )lat setLong:(float)longs;
-(void)FromMapToSetConury:(NSString*)cntryName;

-(void)showAlertWithMessage:(NSString*)message;

+ (BOOL) isEmptyTextField: (UITextField *)textField;

#pragma mark Encoding/Decoding base64
- (NSString *)encodeToBase64String:(UIImage *)image;
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;

@end
