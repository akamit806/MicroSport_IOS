//
//  CommonClass.h
//  UNEYE
//
//  Created by Satya Kumar on 29/07/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "MHCustomTabBarController.h"
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

@property (nonatomic,strong) NSMutableArray *tempSelectedServicesArr;
@property (nonatomic,strong) NSMutableArray *selectedServicesArr;
@property (nonatomic,strong) NSMutableArray *otherSelectedServicesArr;
@property (nonatomic,strong) NSMutableArray *pictureImgArr;
@property (nonatomic,strong) NSMutableArray *instaImgArr;
@property (nonatomic,strong) NSMutableArray *selectedInstagramImgArr;
@property (nonatomic,strong) NSString *geocoderAddress;
@property (nonatomic,strong) NSMutableArray *selectedAreaArr;
@property (nonatomic,strong) NSMutableArray *selectedDayArr;
@property (nonatomic,strong) NSMutableArray *selectedDayIndex;
@property (nonatomic,strong) NSMutableArray *datesSelected;

@property (nonatomic,strong) NSMutableDictionary *signUpInfoDict;
@property (nonatomic,strong) NSMutableDictionary *backgroundInfoDict;
@property (nonatomic,strong) NSMutableArray *cardDataArr;
@property (nonatomic,strong) NSMutableArray *bankDataArr;
@property (nonatomic,strong) NSMutableArray *cardType;
@property (nonatomic,strong) NSString *securityNumber;
@property (nonatomic,strong) NSString *category;
@property (nonatomic,strong) NSString *temp_UserId;
@property (nonatomic,strong) NSString *booking_Date;
@property (nonatomic,strong) NSString *booking_Time;
@property (nonatomic,strong) NSString *address_Type;
@property (nonatomic,strong) NSString *service_order_id;
@property (nonatomic,strong) NSString *Provider_Id_For_Review;
@property (nonatomic,strong) NSString *Customer_Id_For_Review;
@property (nonatomic,strong) NSString *Order_Id_For_Review;
@property (nonatomic,strong) NSMutableArray *orderBookPriceTypeArr;
@property (nonatomic,strong) NSMutableArray *orderPriceArrayPerHour;

//flage for detail's screen ...
@property (nonatomic,strong) NSString *CustomerHistoryListFlag;
@property (nonatomic,strong) NSString *CustomerBookingListFlag;
@property (nonatomic,strong) NSString *FreelancerBookingListFlag;
@property (nonatomic,strong) NSString *FreelancerBelowToolViewFlag;
@property (nonatomic,strong) NSString *FreelancerAcceptBtnCELLFlag;
@property (nonatomic,strong) NSString *FreelancerHistoryListFlag;
@property (nonatomic,strong) NSString *FreelancerEditProfileFlag;
@property (nonatomic,strong) NSString *CompanyAddStaffFlag;

//flage for setting screen ...
@property (nonatomic,strong) NSString *FreelancerSettingFlag;//user_type = 1
@property (nonatomic,strong) NSString *CustomerSettingFlag;//user_type = 2
@property (nonatomic,strong) NSString *CompanySettingFlag;//user_type = 3
@property (nonatomic,strong) NSString *MemberSettingFlag;//user_type = 4

//Switch C2F and F2C flag....
@property (nonatomic,strong) NSString *Freelancer2CustomderRegistrationSwitchFlag;
@property (nonatomic,strong) NSString *Customder2FreelancerRegistrationSwitchFlag;

//Slide menu flag....
//@property (nonatomic,strong) NSString *slidemenuChatBTNFlag;

//Multiple user login array ...
@property (nonatomic,strong) NSMutableArray *multipledataArray;

//--- Store Chat List ---
@property (nonatomic,strong) NSMutableArray *chatListArray;
-(void)storeChatList:(NSMutableArray *)array;

@property (nonatomic,strong) NSMutableDictionary *searchUserDict;
@property NSInteger cellSelectedIndex;

@property float providerAddressLatitude;
@property float providerAddressLongitude;

@property (nonatomic,strong) NSString *start_Time;
@property (nonatomic,strong) NSString *end_Time;

//Customer Home Property ...
@property (nonatomic,strong) NSString *lacationCellIconFlag;

-(void)storeSignUpGeneralInfo:(NSMutableDictionary *)dictionary;
-(void)storeSearchUserInfoForBooking:(NSMutableDictionary *)dictionary;

//--- Current screen data ---
-(void)addScreenDataInfo:(NSString *)text key:(NSString *)key;

//--- Current screen data ---
@property (nonatomic,strong) NSMutableDictionary *screenDataDictionary;

//--- Service Request List Data ---
-(void)addServiceRequestListInfo:(NSMutableDictionary *)dictionary;
@property (nonatomic,strong) NSMutableDictionary *serviceRequestDataDict;

//--- Customer Booking List Data ---
-(void)addCustomerBookingListInfo:(NSMutableDictionary *)dictionary;
@property (nonatomic,strong) NSMutableDictionary *cutomerBookingDict;

//--- Freelauncer Profile Data ---
-(void)addFreelauncerProfileInfo:(NSMutableDictionary *)dictionary;
@property (nonatomic,strong) NSMutableDictionary *freelauncerProfileDict;

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
