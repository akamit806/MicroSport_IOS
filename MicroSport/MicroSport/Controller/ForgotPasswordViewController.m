

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UITextField *textFieldEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.viewContainer.layer.borderWidth = 1.0;
    self.viewContainer.layer.borderColor = [UIColor colorWithRed:97.0/255.0 green:194.0/255.0 blue:197.0/255.0 alpha:1.0].CGColor;
    self.viewContainer.layer.cornerRadius = 2.0;
    self.viewContainer.layer.masksToBounds = YES;
    
    self.btnSubmit.layer.borderWidth = 1.0;
    self.btnSubmit.layer.borderColor = [UIColor whiteColor].CGColor;
    self.btnSubmit.layer.cornerRadius  = 2.0;
    self.btnSubmit.layer.masksToBounds = YES;
    
    
    self.textFieldEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Enter Your Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Action
- (IBAction)btnCrossAction:(id)sender {
}
- (IBAction)btnSubmitAction:(id)sender {
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
