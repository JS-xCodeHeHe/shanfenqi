//
//  MDFiveHelper.h
//  MD5
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 Jusong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface MDFiveHelper : NSObject
+ (NSString *)MDinitWhit:(NSString *)string;
- (NSString *)MD:(NSString *)string;
@end
