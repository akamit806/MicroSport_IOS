//
//  CreateGameViewController.h
//  MicroSport
//
//  Created by Satya on 28/08/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextField.h"
#import "IQDropDownTextField.h"

@interface CreateGameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addGamePhotoBtn;
@property (weak, nonatomic) IBOutlet MyTextField *gameTitleLbl;
//@property (weak, nonatomic) IBOutlet MyTextField *gameDateLbl;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *gameDateLbl;
//@property (weak, nonatomic) IBOutlet MyTextField *gameStartTimeLbl;
//@property (weak, nonatomic) IBOutlet MyTextField *gameEndTimeLbl;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *gameStartTimeLbl;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *gameEndTimeLbl;
@property (weak, nonatomic) IBOutlet MyTextField *gameCategoryLbl;
//@property (weak, nonatomic) IBOutlet MyTextField *gameTypeLbl;
@property (weak, nonatomic) IBOutlet IQDropDownTextField *gameTypeLbl;
@property (weak, nonatomic) IBOutlet MyTextField *gameFeeLbl;
@property (weak, nonatomic) IBOutlet MyTextField *gamePlayersLbl;
@property (weak, nonatomic) IBOutlet MyTextField *gameLocationLbl;
@property (weak, nonatomic) IBOutlet UITextView *gameDiscriptionLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end
