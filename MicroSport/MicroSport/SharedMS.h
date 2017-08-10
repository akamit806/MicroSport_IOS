

#import <Foundation/Foundation.h>

@interface SharedMS : NSObject

+ (id)instance;

- (NSDictionary *)getUserInfo;
- (void)setUserInfo:(NSDictionary *)aUinfo;

@end
