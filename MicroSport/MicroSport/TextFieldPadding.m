//
//  TextFieldPadding.m
//  MicroSport
//
//  Created by John on 22/11/16.
//  Copyright © 2016 John. All rights reserved.
//

#import "TextFieldPadding.h"
#import "UIColor+AppColor.h"

static const CGFloat kPaddingViewWidth  =   20;

@interface TextFieldPadding ()
{
    
}

@end

@implementation TextFieldPadding

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x, bounds.origin.y, kPaddingViewWidth, bounds.size.height);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.size.width - kPaddingViewWidth, bounds.origin.y, kPaddingViewWidth, bounds.size.height);;
}

-(void)setup
{
    //Setup left and right view
    UIView *leftView = [UIView new];
    [leftView setBackgroundColor:[UIColor clearColor]];
    [self setLeftView:leftView];
    
    UIView *rightView = [UIView new];
    [rightView setBackgroundColor:[UIColor clearColor]];
    [self setRightView:rightView];
    
    [self setLeftViewMode:UITextFieldViewModeAlways];
    [self setRightViewMode:UITextFieldViewModeAlways];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor appYellowColor].CGColor;
}

-(void)setAttributedPlaceholderText:(NSString *)attributedPlaceholderText
{
    _attributedPlaceholderText = attributedPlaceholderText;
    NSAttributedString *attributedPlaceholder = [[NSAttributedString alloc] initWithString:_attributedPlaceholderText attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.attributedPlaceholder = attributedPlaceholder;
}

@end
