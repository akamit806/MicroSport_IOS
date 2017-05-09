//
//  SharedMS.h
//  MicroSport
//
//  Created by Piyush Jaiswal on 07/05/17.
//  Copyright © 2017 Hashim Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedMS : NSObject

+ (id)instance;

- (NSDictionary *)getUserInfo;
- (void)setUserInfo:(NSDictionary *)aUinfo;

@end
