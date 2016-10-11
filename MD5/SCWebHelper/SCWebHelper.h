//
//  SCWebHelper.h
//  ShanFen
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 Jusong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "AFNetworking.h"

typedef void(^NsconectionBlock)(id respond);

@interface SCWebHelper : NSObject
/***
 ** 判断网络是否可用
 **/
+ (BOOL)NetWorkIsOK;
/***
 ** post异步请求
 **/
+ (void)postAsyn:(NSString *)Url RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSData *data, NSURLResponse *response, NSError *error)) block;
/***
 ** post同步请求
 **/
+ (NSData *)postSyn:(NSString *)Url RequestParams:(NSDictionary *)params;

+ (void)getRequestDataWithUrlPath:(NSString *)urlStr para:(NSDictionary *)paraDic success:(NsconectionBlock)sucess;


@end
