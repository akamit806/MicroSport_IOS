//
//  SignUpViewController.m
//  MicroSport
//
//  Created by John on 30/04/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "SignUpViewController.h"
#import "TextFieldPadding.h"
#import "FRHyperLabel.h"
#import "SharedMS.h"

@interface SignUpViewController ()

@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldFirstName;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldLastName;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldEmail;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldBio;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldAge;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldFavSports;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldCountry;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldCode;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldPhone;
@property (weak, nonatomic) IBOutlet UIView *viewGender;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldPassword;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldConfirmPassword;
@property (weak, nonatomic) IBOutlet FRHyperLabel *labelTerms;
@property (weak, nonatomic) IBOutlet UIButton *buttonMale;
@property (weak, nonatomic) IBOutlet UIButton *buttonFemale;

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

-(void)setupView
{
    [_textFieldFirstName setAttributedPlaceholderText:@"First Name*"];
    [_textFieldLastName setAttributedPlaceholderText:@"Last Name*"];
    [_textFieldEmail setAttributedPlaceholderText:@"Email*"];
    [_textFieldBio setAttributedPlaceholderText:@"Biography"];
    [_textFieldAge setAttributedPlaceholderText:@"Age"];
    [_textFieldFavSports setAttributedPlaceholderText:@"Fav Sports"];
    [_textFieldCountry setAttributedPlaceholderText:@"Country*"];
    [_textFieldCode setAttributedPlaceholderText:@"Code"];
    [_textFieldPhone setAttributedPlaceholderText:@"Phone*"];
    [_textFieldPassword setAttributedPlaceholderText:@"Password*"];
    [_textFieldConfirmPassword setAttributedPlaceholderText:@"Confirm Password*"];
    
    _viewGender.layer.masksToBounds = YES;
    _viewGender.layer.cornerRadius = 5.0;
    _viewGender.layer.borderWidth = 2.0;
    _viewGender.layer.borderColor = [UIColor appYellowColor].CGColor;
    
    [_buttonMale setSelected:YES];
    [_buttonFemale setSelected:NO];
    
    NSString *string = @"By Signing up you agree to microsport terms & conditions";
    NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: [UIFont systemFontOfSize:17]};
    _labelTerms.attributedText = [[NSAttributedString alloc]initWithString:string attributes:attributes];
    _labelTerms.linkAttributeDefault = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
    void(^handler)(FRHyperLabel *label, NSString *substring) = ^(FRHyperLabel *label, NSString *substring){
        NSLog(@"Link clicked");
    };
    
    [_labelTerms setLinksForSubstrings:@[@"terms & conditions"] withLinkHandler:handler];
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

- (IBAction)backClicked:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)signUpClicked:(UIButton *)sender
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
        else if ([_textFieldPassword.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter password." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldPassword.text length] < 6)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Password must have at least 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if ([_textFieldConfirmPassword.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter confirm password." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldPassword.text isEqualToString:_textFieldConfirmPassword.text])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Password and confirm password do not match." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Signing Up..."];
            NSDictionary *parameters = @{@"user_id" : @0, @"first_name" : _textFieldFirstName.text, @"last_name" : _textFieldLastName.text, @"email" : _textFieldEmail.text, @"password" : _textFieldPassword.text, @"facebook_id" : @"", @"biography" : (_textFieldBio.text.length > 0 ? _textFieldBio.text : @""), @"age" : (_textFieldAge.text.length > 0 ? _textFieldAge.text : @""), @"fav_sport" : (_textFieldFavSports.text.length > 0 ? _textFieldFavSports.text : @""), @"country" : _textFieldCountry.text, @"phone_code" : (_textFieldCode.text.length > 0 ? _textFieldCode.text : @""), @"phone" : _textFieldPhone.text, @"gender" : (_buttonMale.isSelected ? @"male" : @"female")};
            [[WebApiHandler sharedHandler] signUpWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                NSLog(@"%@", response);
                if ([[response objectForKey:@"success"] boolValue])
                {
                    if ([response objectForKey:@"data"] != nil)
                    {
                        [[SharedMS instance] setUserInfo:[response objectForKey:@"data"]];
                    }
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

@end
