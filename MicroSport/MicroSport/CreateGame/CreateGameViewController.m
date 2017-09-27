//
//  CreateGameViewController.m
//  MicroSport
//
//  Created by Satya on 28/08/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "CreateGameViewController.h"
#import "CommonUtility.h"

@interface CreateGameViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation CreateGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    if ([[CommonUtility sharedInstance].selectedTeamMembersArray count] > 0) {
        [[CommonUtility sharedInstance].selectedTeamMembersArray removeAllObjects];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)configureUI{
    
    UIColor *color = [UIColor whiteColor];
    
    _gameTitleLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameTitleLbl.layer.borderWidth = 1.0;
    _gameTitleLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameTitleLbl imageName:nil width:16];
    _gameTitleLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Game Title" attributes:@{NSForegroundColorAttributeName: color}];
    
    _gameDateLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameDateLbl.layer.borderWidth = 1.0;
    _gameDateLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameDateLbl imageName:nil width:16];
    _gameDateLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date" attributes:@{NSForegroundColorAttributeName: color}];
    //_gameDateLbl.userInteractionEnabled = NO;
    _gameDateLbl.dropDownMode = IQDropDownModeDatePicker;
    
    _gameDiscriptionLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameDiscriptionLbl.layer.borderWidth = 1.0;
    _gameDiscriptionLbl.layer.masksToBounds = YES;
    
    _gameStartTimeLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameStartTimeLbl.layer.borderWidth = 1.0;
    _gameStartTimeLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameStartTimeLbl imageName:nil width:16];
    _gameStartTimeLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0.00 AM" attributes:@{NSForegroundColorAttributeName: color}];
    _gameStartTimeLbl.dropDownMode = IQDropDownModeTimePicker;
    
    _gameEndTimeLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameEndTimeLbl.layer.borderWidth = 1.0;
    _gameTitleLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameEndTimeLbl imageName:nil width:16];
    _gameEndTimeLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0.00 PM" attributes:@{NSForegroundColorAttributeName: color}];
    _gameEndTimeLbl.dropDownMode = IQDropDownModeTimePicker;
    
    _gameCategoryLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameCategoryLbl.layer.borderWidth = 1.0;
    _gameCategoryLbl.layer.masksToBounds = YES;
    
    [CommonUtility setLeftPadding:_gameCategoryLbl imageName:@"soccer" width:40];
    _gameCategoryLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Soccer" attributes:@{NSForegroundColorAttributeName: color}];
    _gameCategoryLbl.text = @"Soccer";
    _gameCategoryLbl.textColor = color;
    _gameCategoryLbl.userInteractionEnabled = NO;
    
    _gameTypeLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameTypeLbl.layer.borderWidth = 1.0;
    _gameTypeLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameTypeLbl imageName:nil width:16];
    _gameTypeLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Type" attributes:@{NSForegroundColorAttributeName: color}];
    _gameTypeLbl.isOptionalDropDown = NO;
    [_gameTypeLbl setItemList:[NSArray arrayWithObjects:@"Type", @"League", @"Pickup", nil]];
    
    _gameFeeLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameFeeLbl.layer.borderWidth = 1.0;
    _gameFeeLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameFeeLbl imageName:nil width:16];
    _gameFeeLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"$0" attributes:@{NSForegroundColorAttributeName: color}];
    
    _gamePlayersLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gamePlayersLbl.layer.borderWidth = 1.0;
    _gamePlayersLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gamePlayersLbl imageName:nil width:16];
    [CommonUtility setRightPadding:_gamePlayersLbl imageName:@"player" width:43];
    _gamePlayersLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"0 to 20 Player Found" attributes:@{NSForegroundColorAttributeName: color}];
    
    _gameLocationLbl.layer.borderColor = [UIColor colorWithRed:214.0/255 green:219.0/255 blue:218.0/255 alpha:1].CGColor;
    _gameLocationLbl.layer.borderWidth = 1.0;
    _gameLocationLbl.layer.masksToBounds = YES;
    [CommonUtility setLeftPadding:_gameLocationLbl imageName:nil width:16];
    [CommonUtility setRightPadding:_gameLocationLbl imageName:@"location" width:43];
    _gameLocationLbl.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Location/Venue" attributes:@{NSForegroundColorAttributeName: color}];
    
    //[self.scrollView setContentSize:CGSizeMake(self.scrollView.bounds.size.width, CGRectGetMaxY(self.doneBtn.frame) + 50)];
}


#pragma mark IBActions
- (IBAction)backBtnClicked:(id)sender {
    
    [self backWithAction];
}

- (void)backWithAction{
    
    //    if ([[CommonUtility sharedInstance].selectedTeamMembersArray count] > 0) {
    //
    //        [[CommonUtility sharedInstance].selectedTeamMembersArray removeAllObjects];
    //    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doneBtnAction:(id)sender {
}

- (IBAction)addGamePhoto:(id)sender {
    
    [self gotoTakePhoto];
}

-(void)gotoTakePhoto
{
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Options" message:@"Please choose one resource" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self accessCameraPhotos:@"camera"];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Photos" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self accessCameraPhotos:@""];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        //Cancel button tappped.
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    //show action sheet
    actionSheet.popoverPresentationController.sourceView = self.view;
    
    // Present action sheet.
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

-(void)accessCameraPhotos:(NSString *)sourceType{
    
    UIImagePickerController *imagePickerController;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] && [sourceType isEqualToString:@"camera" ])
    {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        imagePickerController =[[UIImagePickerController alloc] init];
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //imagePickerController.mediaTypes = @[(NSString*)kUTTypeImage, (NSString*)kUTTypeMovie, (NSString*)kUTTypeAVIMovie, (NSString*)kUTTypeVideo, (NSString*)kUTTypeMPEG4];
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
        
    }
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark UIImagePickerController Delegates
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *image = [originalImage copy];
    
    //Have the image draw itself in the correct orientation if necessary
    if(!(image.imageOrientation == UIImageOrientationUp ||
         image.imageOrientation == UIImageOrientationUpMirrored))
    {
        CGSize imgsize = image.size;
        UIGraphicsBeginImageContext(imgsize);
        [image drawInRect:CGRectMake(0.0, 0.0, imgsize.width, imgsize.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    //--- Set image on preview ---
    [self.addGamePhotoBtn setImage:image forState:UIControlStateNormal];
    
}

@end
