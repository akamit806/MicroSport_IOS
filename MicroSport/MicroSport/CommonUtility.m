//
//  CommonClass.m
//  UNEYE
//
//  Created by Satya Kumar on 29/07/15.
//  Copyright (c) 2015 Satya Kumar All rights reserved.
//

#import "CommonUtility.h"
#import "NSDictionary+IgnoreNull.h"

@implementation CommonUtility

+(CommonUtility *)sharedInstance
{
    static CommonUtility *instance;
    if(!instance){
        instance=[[CommonUtility alloc] init];
        instance.userDictionary = [[NSMutableDictionary alloc] init];
    }
    return instance;
}

-(void)storeSignUpGeneralInfo:(NSMutableDictionary *)dictionary{
    
    if (self.signUpInfoDict == nil) {
        self.signUpInfoDict = [[NSMutableDictionary alloc] init];
    }
    
    self.signUpInfoDict = [dictionary mutableCopy];
}

-(void)storeSearchUserInfoForBooking:(NSMutableDictionary *)dictionary {
    
    if (self.searchUserDict == nil) {
        self.searchUserDict = [[NSMutableDictionary alloc] init];
    }
    
    self.searchUserDict = [dictionary mutableCopy];
}

//--- Current screen data ---
-(void)addScreenDataInfo:(NSString *)text key:(NSString *)key
{
    if (self.screenDataDictionary == nil) {
        self.screenDataDictionary = [[NSMutableDictionary alloc] init];
    }
    
    [self.screenDataDictionary setValue:text forKey:key];
}

//--- Service Request List Data ---
-(void)addServiceRequestListInfo:(NSMutableDictionary *)dictionary {

    if (self.serviceRequestDataDict == nil) {
        self.serviceRequestDataDict = [[NSMutableDictionary alloc] init];
    }
    
    self.serviceRequestDataDict = [dictionary mutableCopy];
}

//--- Customer Booking List Data ---
-(void)addCustomerBookingListInfo:(NSMutableDictionary *)dictionary {
    
    if (self.cutomerBookingDict == nil) {
        self.cutomerBookingDict = [[NSMutableDictionary alloc] init];
    }
    
    self.cutomerBookingDict = [dictionary mutableCopy];
}

//--- Freelauncer Profile Data ---
-(void)addFreelauncerProfileInfo:(NSMutableDictionary *)dictionary {
    
    if (self.freelauncerProfileDict == nil) {
        self.freelauncerProfileDict = [[NSMutableDictionary alloc] init];
    }
    
    self.freelauncerProfileDict = [dictionary mutableCopy];
}

//--- Store Chat List ---
-(void)storeChatList:(NSMutableArray *)array {
    
    if (self.chatListArray == nil) {
        self.chatListArray = [[NSMutableArray alloc] init];
    }
    
    self.chatListArray = [array mutableCopy];
}


+(UIView*)makeRoundedView:(UIView*)view withBorderColor:(UIColor*)borderColor andBorderWidth:(float)borderWidth
{
   
    [view setClipsToBounds:YES];
    [[view layer] setCornerRadius:view.bounds.size.width/2];
    [view.layer setBorderColor:borderColor.CGColor];
    [view.layer setBorderWidth:borderWidth];
    
    return view;
}

#pragma mark - textFieldPedding

+(void)setLeftPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, textField.frame.size.height)];
    UIButton *leftImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, paddingView.frame.size.width/2, paddingView.frame.size.width/2)];
    leftImage.center=paddingView.center;
    [leftImage setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftImage setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [leftImage addTarget:self action:@selector(peddingAction:) forControlEvents:UIControlEventTouchUpInside];
    leftImage.contentMode=UIViewContentModeScaleAspectFit;
    [paddingView addSubview:leftImage];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

+(void)setRightPadding:(UITextField *)textField imageName:(NSString *)image width:(int)width
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, textField.frame.size.height)];
    UIButton *rightImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, paddingView.frame.size.width/2, paddingView.frame.size.width/2)];
    rightImage.center=paddingView.center;
    [rightImage setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [rightImage setImage:[UIImage imageNamed:image] forState:UIControlStateHighlighted];
    [rightImage addTarget:self action:@selector(peddingAction:) forControlEvents:UIControlEventTouchUpInside];
    rightImage.contentMode=UIViewContentModeScaleAspectFit;
    [paddingView addSubview:rightImage];
    textField.rightView = paddingView;
    textField.rightViewMode = UITextFieldViewModeAlways;
}

+(void)peddingAction:(UIButton *)btn
{
    UIView *vw = [btn superview];
    UITextField *fild = (UITextField*)[vw superview];
    [fild becomeFirstResponder];
}

-(BOOL)Emailvalidate:(NSString *)tempMail
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:tempMail];
}

//-(BOOL)a:(NSString *)b
//{
//    //Create character set
//    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
//    
//    //Invert the set
//    validChars = [validChars invertedSet];
//    
//    //Check against that
//    NSRange  range = [b rangeOfCharacterFromSet:validChars];
//    
////    if (NSNotFound != range.location) {
////        kCustomAlertWithParamAndTarget(@"Message", @"invalid chars found", nil);
////    }
//     return ([b rangeOfCharacterFromSet:unwantedCharacters].location == NSNotFound);
//}

-(BOOL)isOnlySpace:(NSString *)text {
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@" "];
    s = [s invertedSet];
    NSRange r = [text rangeOfCharacterFromSet:s];
    
    return (r.location == NSNotFound);
}

-(BOOL)isAlphabetical:(NSString *)text {
    NSCharacterSet *s = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];
    s = [s invertedSet];
    NSRange r = [text rangeOfCharacterFromSet:s];
    
    return (r.location == NSNotFound);
}

-(BOOL)isNumeric:(NSString*)inputString {
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:inputString];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}

-(BOOL)isAlphaNumeric:(NSString *)input {
    NSString *alphaNum = @"[a-zA-Z0-9]+";
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphaNum];
    
    return [regexTest evaluateWithObject:input];
}

- (BOOL)validateMobileNumber:(NSString *)mobileNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:mobileNumber];
}

#pragma mark -session
// Initialize user on sign-in or registration
-(void)initializeUser:(NSDictionary *)dictionary
{
    self.userDictionary = [dictionary mutableCopy];
    
    NSData *saveUserData = [NSKeyedArchiver archivedDataWithRootObject:self.userDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:saveUserData forKey:@"userdata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)addFireBaseUserInfo:(NSMutableDictionary *)dictionary key:(NSString *)key
{
    if (self.userDictionary != nil) {
        [self.userDictionary setValue:dictionary forKey:key];
    }
    
    NSData *saveUserData = [NSKeyedArchiver archivedDataWithRootObject:self.userDictionary];
    [[NSUserDefaults standardUserDefaults] setObject:saveUserData forKey:@"userdata"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// set user info
-(void)addUserInfo:(NSMutableDictionary *)dictionary
{
    NSArray *keys = [dictionary allKeys];
    
    for (NSString *key in keys) {
        [self.userDictionary setValue:[dictionary valueForKey:key] forKey:key];
    }
}

-(void)logoutAndRemoveUserData
{
    [self.userDictionary removeAllObjects];
}


-(void)updateCurrentLocation
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [_locationManager requestAlwaysAuthorization];
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"didUpdateLocations: %@", [locations lastObject]);
    _userlocation = [locations lastObject];
    
    _locationManager = manager;
    [_locationManager stopUpdatingLocation];
    
}
/*
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if ([error domain] == kCLErrorDomain) {
        
        // We handle CoreLocation-related errors here
        switch ([error code]) {
                // "Don't Allow" on two successive app launches is the same as saying "never allow". The user
                // can reset this for all apps by going to Settings > General > Reset > Reset Location Warnings.
            case kCLErrorDenied:
                ShowAlert(@"Message", kLocationMassage, nil);
            case kCLErrorLocationUnknown:
            default:
                break;
        }
    }
    else
    {
        // We handle all non-CoreLocation errors here
    }
}
*/

-(NSString *)removeSpacialChar:(NSString *)str
{
    NSArray *data = [str componentsSeparatedByString:@"@"];
    
    if([data count]==2)
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]*$'" options:0 error:NULL];
        NSString *string = [data firstObject];
        NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
        modifiedString=[modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        modifiedString = [modifiedString stringByReplacingOccurrencesOfString:@"'" withString:@""];
        return [NSString stringWithFormat:@"%@@%@",modifiedString,[data lastObject]];
    }
    else
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^a-zA-Z0-9]*$" options:0 error:NULL];
        NSString *string = str;
        NSString *modifiedString = [regex stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@""];
        modifiedString=[modifiedString stringByReplacingOccurrencesOfString:@" " withString:@""];
        return modifiedString;
    }
}

-(void)setLatLong:(float )lat setLong:(float)longs
{
    _getLat = lat;
    _getLong = longs;
}

-(void)showAlertWithMessage:(NSString*)message
{
//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
//    [alert show];
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:NSLocalizedString(@"messageAlertKeyAllMessage", @"") message:message preferredStyle:UIAlertControllerStyleAlert];
   
    //...
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"okAlertKeyAllMessage", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertController addAction:okAction];
    
    id rootViewController=[UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController=[((UINavigationController *)rootViewController).viewControllers objectAtIndex:0];
    }
    [rootViewController presentViewController:alertController animated:YES completion:nil];
}


+ (BOOL) isEmptyTextField: (UITextField *)textField
{
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0)
        return YES;
    
    return NO;
}

#pragma mark Encoding base64
- (NSString *)encodeToBase64String:(UIImage *)image {
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark Decoding base64
- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:data];
}

@end
