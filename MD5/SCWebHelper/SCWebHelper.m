//
//  SCWebHelper.m
//  ShanFen
//
//  Created by apple on 16/4/19.
//  Copyright © 2016年 Jusong. All rights reserved.
//

#import "SCWebHelper.h"
#import "Reachability.h"

@implementation SCWebHelper
//检查网络状态
+ (BOOL)NetWorkIsOK {
    if ([[self internetStatus]isEqualToString:@"notReachable"]) {
        return NO;
    }
    else{
        return YES;
    }
}
#pragma mark - 获取网络状态
+ (NSString *)internetStatus {
    Reachability *reachability   = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    NSString *net = @"wifi";
    switch (internetStatus) {
        case ReachableViaWiFi:
            net = @"wifi";
            break;
        case ReachableViaWWAN:
            net = @"wwan";
            break;
        case NotReachable:
            net = @"notReachable";
        default:
            break;
    }
    return net;
}
#pragma mark--post异步请求封装函数
+ (void)postAsyn:(NSString *)Url RequestParams:(NSDictionary *)params FinishBlock:(void (^)(NSData *, NSURLResponse *, NSError *)) block{
    NSURL *url=[NSURL URLWithString:Url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //转换dictionary为post的string
    NSString *parseParmsResult=[self parseParams:params];
    NSData *postData=[parseParmsResult dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask=[session dataTaskWithRequest:request completionHandler:block];
    [dataTask resume];
}
#pragma mark--post同步请求封装函数
+ (NSData *)postSyn:(NSString *)Url RequestParams:(NSDictionary *)params{
    NSError *error;
    NSURLResponse *theResponse;
    NSURL *url=[NSURL URLWithString:Url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //转换dictionary为pos的string
    NSString *parseParmsResult=[self parseParams:params];
    NSData *postData=[parseParmsResult dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&error];
    return data;
}
#pragma mark--get请求
+ (void)getRequestDataWithUrlPath:(NSString *)urlStr para:(NSDictionary *)paraDic success:(NsconectionBlock)sucess {
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json", @"text/javascript", @"text/xml", nil];
    [session GET:urlStr parameters:paraDic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:NULL];
        //NSLog(@"%@", dict);
        sucess(dict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    /*
    //    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", @"text/json", @"text/javascript", nil];
    //    [manager GET:urlStr parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        sucess(responseObject);
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"%@",error);
    //    }];
    */
}
#pragma mark--把NSDictionary转换成post格式的NSString
+ (NSString *)parseParams:(NSDictionary *)params{
    NSString *keyValueFormat;
    NSMutableString *result=[NSMutableString new];
    //实例化一个key枚举器来存放dictionary的key
    NSEnumerator *keyEnum=[params keyEnumerator];
    id key;
    while (key=[keyEnum nextObject]) {
        keyValueFormat=[NSString stringWithFormat:@"%@=%@&",key,[params valueForKey:key]];
        [result appendString:keyValueFormat];
        //NSLog(@"post()方法post参数:%@",result);
    }
    return result;
}

@end
