//
//  ViewController.m
//  MD5
//
//  Created by apple on 16/4/20.
//  Copyright © 2016年 Jusong. All rights reserved.
//

#import "ViewController.h"
#import "MDFiveHelper.h"
#import "SCWebHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self postDataFromUrl];
    //[self getDataFromUrl];
    //[self clearCache];
}
#pragma mark--清除缓存
- (void)clearCache {
    //===============清除缓存==============
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    //NSLog(@"count:%ld,%@", [files count], files);
    for (NSString *string in files) {
        //NSError *error;
        NSString *path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"%@", string]];
        //NSLog(@"%@%@", path, [NSFileManager defaultManager]);
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            long long size=[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil].fileSize;
            NSLog(@"%lld", size);
            //[[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}
#pragma mark--get请求数据
- (void)getDataFromUrl {
    //http://192.168.0.125/index.php/api/site/index
    //http://c.m.163.com/nc/video/home/0-10.html
    [SCWebHelper getRequestDataWithUrlPath:@"http://192.168.0.125/index.php/api/site/news/" para:nil success:^(id respond) {

        NSLog(@"respond:%@", respond);
    }];
}
#pragma mark--post请求数据
- (void)postDataFromUrl {
    //http://api.tudou.com/v3/gw?method=album.channel.get&appKey=myKey&format=json&channel=t&pageNo=2&pageSize=10
    //NSString *url = @"http://api.tudou.com/v3/gw?";@"method",@"album.channel.get", @"appKey",@"myKey", @"format",@"json", @"channel",@"t", @"pageNo",@"2", @"pageSize",@"10",
    /*
     接口URL:  http://localhost/sahnfenqi/index.php/api/login/get
     接口参数:
     1. username(手机号) 2.password(密码)
     
     用户登录接口
     
     @return int code 操作码，1表示成功，0表示失败
     @return string msg 提示信息
     @return array data 登录结果信息
     @return array data[].id  用户ID
     */
    //http://192.168.0.128/sahnfenqi/index.php/api/login/get
    NSString *pawd = [MDFiveHelper MDinitWhit:@"123456"];
    //NSString *url = @"http://192.168.0.128/shanfenqi/index.php/api1/Login";
    NSString *url = @"http://192.168.0.125/index.php/api/login/index";
    NSDictionary *ParamDic = @{@"username":@"13253595923",@"password":pawd};
    [SCWebHelper postAsyn:url RequestParams:ParamDic FinishBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"data:%@", data);
        if (data==nil) {
            NSLog(@"请求超时");
            return;
        }
        if (error) {
            //网络连接错误
            NSLog(@"%@",[error description]);
        } else{
            //解析
            NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            //NSLog(@"%@", dic);
            NSInteger status=[[dic objectForKey:@"status"]intValue];
            if (status == 200) {//网络请求成功
                NSLog(@"%@", dic);
            } else{
                NSLog(@"网络请求失败：status--%ld",(long)status);
            }
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
