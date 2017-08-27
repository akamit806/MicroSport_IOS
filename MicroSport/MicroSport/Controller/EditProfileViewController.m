//
//  CreateTeamViewController.h
//  MicroSport
//
//  Created by Satya Kumar on 8/12/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "EditProfileViewController.h"
#import "TextFieldPadding.h"
#import "FRHyperLabel.h"
#import "UIColor+AppColor.h"
#import "UIColor+AppColor.h"
#import "Reachability.h"
#import "WebApiHandler.h"
#import "NSString+PJR.h"
#import "SVProgressHUD.h"
#import "SharedMS.h"
#import "UIButton+AFNetworking.h"
#import "UIViewController+AMSlideMenu.h"
#import "MyTextField.h"
#import "CommonUtility.h"


@interface EditProfileViewController ()

@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldFirstName;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldLastName;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldEmail;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldBio;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldAge;
@property (weak, nonatomic) IBOutlet MyTextField *textFieldFavSports;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldCountry;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldCode;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIView *viewGender;
@property (weak, nonatomic) IBOutlet UIButton *buttonMale;
@property (weak, nonatomic) IBOutlet UIButton *buttonFemale;
@property (weak, nonatomic) IBOutlet UIButton *btnProfileImage;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;

@end

@implementation EditProfileViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self callwebserviceForGetUserProfile];
    });
    [self setupView];
    [self editButtonAction:self.btnEdit];
    [self populateData:[[SharedMS instance] getUserInfo]];
}

-(void)setupView
{
    [_textFieldFirstName setAttributedPlaceholderText:@"First Name*"];
    [_textFieldLastName setAttributedPlaceholderText:@"Last Name*"];
    [_textFieldEmail setAttributedPlaceholderText:@"Email*"];
    [_textFieldBio setAttributedPlaceholderText:@"Biography"];
    [_textFieldAge setAttributedPlaceholderText:@"Age"];
    [_textFieldCountry setAttributedPlaceholderText:@"Country*"];
    [_textFieldCode setAttributedPlaceholderText:@"Code"];
    [_textFieldPhone setAttributedPlaceholderText:@"Phone*"];
    
    _textFieldFavSports.layer.masksToBounds = YES;
    _textFieldFavSports.layer.cornerRadius = 1.0;
    _textFieldFavSports.layer.borderWidth = 2.0;
    _textFieldFavSports.layer.borderColor = [UIColor appYellowColor].CGColor;
    UIColor *color = [UIColor whiteColor];
    [CommonUtility setLeftPadding:_textFieldFavSports imageName:@"soccer" width:40];
    _textFieldFavSports.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Soccer" attributes:@{NSForegroundColorAttributeName: color}];
    _textFieldFavSports.text = @"Soccer";
    _textFieldFavSports.textColor = color;
    _textFieldFavSports.userInteractionEnabled = NO;
    
    _viewGender.layer.masksToBounds = YES;
    _viewGender.layer.cornerRadius = 1.0;
    _viewGender.layer.borderWidth = 2.0;
    _viewGender.layer.borderColor = [UIColor appYellowColor].CGColor;
    
    [_buttonMale setSelected:YES];
    [_buttonFemale setSelected:NO];
    
//    [self.btnProfileImage.layer setCornerRadius:self.btnProfileImage.frame.size.width/2];
//    self.btnProfileImage.clipsToBounds = YES;
    
}

#pragma mark Action

-(void)populateData:(NSDictionary *)userData
{
    self.textFieldFirstName.text = [userData objectForKey:@"first_name"];
    self.textFieldLastName.text = [userData objectForKey:@"last_name"];
    self.textFieldEmail.text = [userData objectForKey:@"email"];
    self.textFieldBio.text = [userData objectForKey:@"biography"];
    self.textFieldAge.text = [userData objectForKey:@"age"];
    self.textFieldFavSports.text = @"Soccer";   //[userData objectForKey:@"fav_sport"];
    self.textFieldCountry.text = [userData objectForKey:@"country"];
    self.textFieldCode.text = [userData objectForKey:@"phone_code"];
    self.textFieldPhone.text = [userData objectForKey:@"phone"];
    
    NSString *gender = [userData objectForKey:@"gender"];
    
    if([gender isEqualToString:@"male"])
    {
        self.buttonMale.selected = true;
        self.buttonFemale.selected = false;
    }
    else{
        
        self.buttonMale.selected = false;
        self.buttonFemale.selected = true;
    }
    
    NSString *profile = [userData objectForKey:@"image_url"];
//    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",kAPIBaseURL,profile];

    if (profile != nil && profile.length>0)
    [self.btnProfileImage setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:profile]];
    
}

- (IBAction)sideMenuClicked:(id)sender {
    
     [self.mainSlideMenu openLeftMenu];
}

- (IBAction)maleClicked:(UIButton *)sender
{
    [_buttonMale setSelected:YES];
    [_buttonFemale setSelected:NO];
}

- (IBAction)femaleClicked:(UIButton *)sender
{
    [_buttonMale setSelected:NO];
    [_buttonFemale setSelected:YES];
}
- (IBAction)editButtonAction:(id)sender {
    
    UIButton *editButton = (UIButton *)sender;
    
    if (editButton.selected == YES)
    {
        editButton.selected = NO;
        
        self.textFieldFirstName.enabled = YES;
        self.textFieldLastName.enabled = YES;
        self.textFieldEmail.enabled = YES;
        self.textFieldBio.enabled = YES;
        self.textFieldAge.enabled = YES;
        self.textFieldFavSports.enabled = YES;
        self.textFieldCountry.enabled = YES;
        self.textFieldCode.enabled = YES;
        self.textFieldPhone.enabled = YES;
        self.viewGender.userInteractionEnabled = YES;
        self.btnProfileImage.enabled = YES;
    }else
    {
        
        editButton.selected = YES;
        
        self.textFieldFirstName.enabled = NO;
        self.textFieldLastName.enabled = NO;
        self.textFieldEmail.enabled = NO;
        self.textFieldBio.enabled = NO;
        self.textFieldAge.enabled = NO;
        self.textFieldFavSports.enabled = NO;
        self.textFieldCountry.enabled = NO;
        self.textFieldCode.enabled = NO;
        self.textFieldPhone.enabled = NO;
        self.viewGender.userInteractionEnabled = NO;
        self.btnProfileImage.enabled =NO;
        
    }
        
    
}

- (IBAction)backClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveButtonClicked:(UIButton *)sender
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        if ([_textFieldFirstName.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter first name." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldLastName.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter last name." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldEmail.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter email." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldAge.text isBlank] && ![_textFieldAge.text containsOnlyNumbers])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter valid age." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldEmail.text isValidEmail])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter valid email address." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldCountry.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter country." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldPhone.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter phone number." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldPhone.text isVAlidPhoneNumber])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter valid phone number." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            NSString *userId = [[[SharedMS instance] getUserInfo] objectForKey:@"user_id"];
            
            [SVProgressHUD showWithStatus:@"Updating..."];
            NSDictionary *parameters = @{@"user_id" : userId, @"first_name" : _textFieldFirstName.text, @"last_name" : _textFieldLastName.text, @"email" : _textFieldEmail.text,  @"facebook_id" : @"", @"biography" : (_textFieldBio.text.length > 0 ? _textFieldBio.text : @""), @"age" : (_textFieldAge.text.length > 0 ? _textFieldAge.text : @""), @"fav_sport" : (_textFieldFavSports.text.length > 0 ? _textFieldFavSports.text : @""), @"country" : _textFieldCountry.text, @"phone_code" : (_textFieldCode.text.length > 0 ? _textFieldCode.text : @""), @"phone" : _textFieldPhone.text, @"gender" : (_buttonMale.isSelected ? @"male" : @"female")};
            [[WebApiHandler sharedHandler] updateUserInfoWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                NSLog(@"%@", response);
                if ([[response objectForKey:@"success"] boolValue])
                {
                    NSDictionary *dict = [response objectForKey:@"data"];
                    [[SharedMS instance] setUserInfo:dict];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"MicroSport" message:@"Profile Updated" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];

                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:[response valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                    [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
                
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }];
        }
    }
}

#pragma mark WebserviceCalling

-(void)callwebserviceForGetUserProfile
{
    if ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:kMessageNetworkNotAvailable preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        return;
    }
    else
    {
        __weak typeof (self) weakSelf = self;
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"Processing..."];
        
        NSString *userId = [[[SharedMS instance] getUserInfo] objectForKey:@"user_id"];
        NSDictionary *parameters = @{@"user_id" : userId};
        
        [[WebApiHandler sharedHandler] getUserInfoWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            NSLog(@"%@", response);
            if ([[response objectForKey:@"success"] boolValue])
            {
                if ([response objectForKey:@"data"] != nil && [[response objectForKey:@"data"] isKindOfClass:[NSDictionary class]] )
                {
                    [[SharedMS instance] setUserInfo:[response objectForKey:@"data"]];
                    [self populateData:[response objectForKey:@"data"]];
                }else
                {
                    NSDictionary *userInfo = [[SharedMS instance] getUserInfo];
                    
                    if(userInfo != nil)
                    {
                        self.textFieldEmail.text = [userInfo objectForKey:@"email"];
                    }
                        
                }
                
            }
            else
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"User Doesn't Exist! Please try with valid Email and Password" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }];
        
        
    }

}

-(void)callwebserviceForUpdateUserProfile
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
