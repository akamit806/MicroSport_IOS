//
//  UIColor+AppColor.m
//  MicroSport
//
//  Created by Satya on 05/03/17.
//  Copyright © 2017 John. All rights reserved.
//

#import "UIColor+AppColor.h"

@implementation UIColor (AppColor)

+(UIColor *)appYellowColor
{
    static UIColor *color = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        //color = [UIColor colorWithRed:249.0/255.0 green:244.0/255.0 blue:23.0/255.0 alpha:1.0];
        color = [UIColor colorWithRed:77.0/255.0 green:117.0/255.0 blue:166.0/255.0 alpha:1.0];
    });
    return color;
}

@end
