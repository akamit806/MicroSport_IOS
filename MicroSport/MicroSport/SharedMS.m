//
//  SharedMS.m
//  MicroSport
//
//  Created by Piyush Jaiswal on 07/05/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import "SharedMS.h"

NSString const *kPolygonNumberOfSides = @"polygonNumberOfSides";

@interface SharedMS()

@end

@implementation SharedMS

static SharedMS * objAppSharedMS;

-(id)init{
    if (objAppSharedMS) {
        return objAppSharedMS;
    }
    else{
        self=[super init];
        objAppSharedMS=self;
        return self;
    }
}

+(SharedMS *)instance{
    if(objAppSharedMS){
        return objAppSharedMS;
    }
    
    else{
        objAppSharedMS=[[SharedMS alloc]init];
        return objAppSharedMS;
    }
}

- (NSDictionary *)getUserInfo{
    NSData *infoData = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.company.MicroSport"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:infoData];
}

- (void)setUserInfo:(NSDictionary *)aUinfo{
    NSData *infoData = [NSKeyedArchiver archivedDataWithRootObject:aUinfo];
    [[NSUserDefaults standardUserDefaults] setObject:infoData forKey:@"com.company.MicroSport"];
    
    NSUserDefaults *userDefaluts = [[NSUserDefaults alloc] initWithSuiteName:@"com.company.MicroSport"];
    [userDefaluts setObject:infoData forKey:@"com.company.MicroSport"];
    [userDefaluts  synchronize];
}


@end
