//
//  MDFiveHelper.m
//  MD5
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 Jusong. All rights reserved.
//

#import "MDFiveHelper.h"

@implementation MDFiveHelper
//MD5加密
- (NSString *)MD:(NSString *)string {
    const char *cstr = [string UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}
+ (NSString *)MDinitWhit:(NSString *)string {
    MDFiveHelper *mdHelper = [MDFiveHelper new];
    return [mdHelper MD:string];
}
//SHA1加密
- (NSString *)Sha:(NSString *)string {
    const char *cstr = [string UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for (int i = 0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}
+ (NSString *)ShainitWhit:(NSString *)string {
    MDFiveHelper* shaHelper = [[MDFiveHelper alloc]init];
    
    return [shaHelper Sha:string];
}
@end
