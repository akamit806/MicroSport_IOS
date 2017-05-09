//
//  SignInViewController.m
//  MicroSport
//
//  Created by John on 30/04/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "SignInViewController.h"
#import "TextFieldPadding.h"
#import "LeftViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <TwitterKit/TwitterKit.h>
#import "SharedMS.h"

@interface SignInViewController ()<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldEmail;
@property (weak, nonatomic) IBOutlet TextFieldPadding *textFieldPassword;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *fbLoginButton;
@property (weak, nonatomic) IBOutlet UIImageView *fbImageView;

@end

@implementation SignInViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_textFieldEmail setAttributedPlaceholderText:@"Email"];
    
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
    _fbLoginButton.delegate = self;
    [_textFieldPassword setAttributedPlaceholderText:@"Password"];
    _fbLoginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends"];
    
    
    
    
    NSArray *layoutConstraintsArr = _fbLoginButton.constraints ;
    // Iterate over array and test constraints until we find the correct one:
//    for lc in layoutConstraintsArr { // or attribute is NSLayoutAttributeHeight etc.
//        if ( lc.constant == 28 ){
//            // Then disable it...
//            lc.active = false
//            break
//        }
//    }
    
    
    for (NSLayoutConstraint *cons in layoutConstraintsArr) {
        
        if (cons.constant == 28)
        {
            cons.active = false;
            break;
        }
        
    }
    
    [self.view layoutIfNeeded];
    [self.view layoutSubviews];
    
    [self.view bringSubviewToFront:self.fbImageView];
    
    
}


#pragma mark Action

- (IBAction)loginClicked:(UIButton *)sender
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
        if ([_textFieldEmail.text isBlank])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter email address." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else if (![_textFieldEmail.text isValidEmail])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Please enter valid email address." preferredStyle:UIAlertControllerStyleAlert];
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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Message" message:@"Password should be atleast 6 characters long." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            __weak typeof (self) weakSelf = self;
            [self.view endEditing:YES];
            [SVProgressHUD showWithStatus:@"Signing In..."];
            NSDictionary *parameters = @{@"email" : _textFieldEmail.text, @"password" : _textFieldPassword.text, @"facebook_id" : @""};
            [[WebApiHandler sharedHandler] loginWithParameters:parameters success:^(NSDictionary *response) {
                [SVProgressHUD dismiss];
                NSLog(@"%@", response);
                if ([[response objectForKey:@"success"] boolValue])
                {
                    if ([response objectForKey:@"data"] != nil)
                    {
                        [[SharedMS instance] setUserInfo:[response objectForKey:@"data"]];
                    }

                    [weakSelf navigateToHomeScreen];
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
}

-(void)navigateToHomeScreen
{
    UINavigationController *homeController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    LeftViewController *leftController = (LeftViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    RESideMenu *sideMenu = [[RESideMenu alloc] initWithContentViewController:homeController leftMenuViewController:leftController rightMenuViewController:nil];
    sideMenu.contentViewShadowColor = [UIColor blackColor];
    sideMenu.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenu.contentViewShadowOpacity = 0.6;
    sideMenu.contentViewInPortraitOffsetCenterX = 100;
    sideMenu.contentViewShadowRadius = 12;
    sideMenu.contentViewShadowEnabled = YES;
    sideMenu.scaleContentView = NO;
    sideMenu.scaleMenuView = NO;
    
    [self presentViewController:sideMenu animated:YES completion:nil];
}

- (IBAction)forgotButtonAction:(id)sender {
    
    
    
    
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"MicroSport"
                               message:@"Please enter your email address."
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                                   UITextField *textField = alert.textFields[0];
                                                   
                                                   if (textField.text.length > 0)
                                                   {
                                                       [self callWebserviceForForgotPasswordWithText:textField.text];
                                                   }
                                                   NSLog(@"text was %@", textField.text);
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       
                                                       NSLog(@"cancel btn");
                                                       
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                   }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Email Address";
        textField.keyboardType = UIKeyboardTypeDefault;
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark FacebookLogin

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error
{
    [SVProgressHUD dismiss];
    //    [self navigateToHomeScreen];
    
    //    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
    //     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
    //
    //         if (!error) {
    //             NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
    //         }
    //     }];
    
    //    @{@"fields": @"picture, email,first_name,gender,last_name,location,picture,sports"}
    
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me"
                                       parameters:@{@"fields": @"picture, email,first_name,gender,last_name,location{location}"}]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             
             NSString *emailId = [result objectForKey:@"email"];
             NSString *userId = [result objectForKey:@"id"];
             NSString *profile = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
             NSString *firstName = [result objectForKey:@"first_name"];
             NSString *lastName = [result objectForKey:@"last_name"];
             NSString *gender = [result objectForKey:@"gender"];
             
             
             
             NSMutableDictionary *dict = [NSMutableDictionary dictionary];
             [dict setValue:emailId forKey:@"email"];
             [dict setValue:userId forKey:@"user_id"];
             [dict setValue:profile forKey:@"image_url"];
             
             //             [dict setValue:profile forKey:@"country"];
             //             [dict setValue:profile forKey:@"age"];
             //             [dict setValue:profile forKey:@"fav_sport"];
             [dict setValue:firstName forKey:@"first_name"];
             [dict setValue:lastName forKey:@"last_name"];
             [dict setValue:gender forKey:@"gender"];
             //             [dict setValue:profile forKey:@"phone"];
             //             [dict setValue:profile forKey:@"phone_code"];
             //             [dict setValue:profile forKey:@"biography"];
             
             
             
             
             
             
             [[SharedMS instance] setUserInfo:dict];
             [self navigateToHomeScreen];
             
             
         }
         else{
             NSLog(@"%@", [error localizedDescription]);
         }
     }];
    
    //    if (FBSession.activeSession.isOpen) {
    //
    //        [[FBRequest requestForMe] startWithCompletionHandler:
    //         ^(FBRequestConnection *connection,
    //           NSDictionary<FBGraphUser> *user,
    //           NSError *error) {
    //             if (!error) {
    //                 NSString *firstName = user.first_name;
    //                 NSString *lastName = user.last_name;
    //                 NSString *facebookId = user.id;
    //                 NSString *email = [user objectForKey:@"email"];
    //                 NSString *imageUrl = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
    //             }
    //         }];
    //    }
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    
}

- (BOOL) loginButtonWillLogin:(FBSDKLoginButton *)loginButton;
{
//    [SVProgressHUD showWithStatus:@"Signing In..."];

    return YES;
}
#pragma mark TwitterLogin
- (IBAction)twitterButtonLoginAction:(id)sender {
    
    [SVProgressHUD showWithStatus:@"Signing In..."];

    
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            NSLog(@"signed in as %@", [session userName]);
            [self navigateToHomeScreen];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
        }
        [SVProgressHUD dismiss];
    }];
}
#pragma mark Webservice Call


-(void)callWebserviceForForgotPasswordWithText:(NSString *)email
{
        __weak typeof (self) weakSelf = self;
        [self.view endEditing:YES];
        [SVProgressHUD showWithStatus:@"Updating..."];
        NSDictionary *parameters = @{@"email" :email};
        [[WebApiHandler sharedHandler] forgotPasswordWithParameters:parameters success:^(NSDictionary *response) {
            [SVProgressHUD dismiss];
            NSLog(@"%@", response);
            if ([[response objectForKey:@"success"] boolValue])
            {
                if ([response objectForKey:@"data"] != nil)
                {

                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"MicroSport" message:@"Please check your email." preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
                [weakSelf presentViewController:alertController animated:YES completion:nil];
                }
                
            }
            else
            {
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"User Doesn't Exist! Please try with valid Email and Password" preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//                [weakSelf presentViewController:alertController animated:YES completion:nil];
//
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        }];
}

@end
