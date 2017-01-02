//
//  ViewController.m
//  VankeNetDemo
//
//  Created by Evan on 2016/12/13.
//  Copyright © 2016年 Evan. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Util.h"



#define kHttpTask_Server        @"http://anchang-api-test.herokuapp.com"
#define kLoginMethod            @"/plat2/app/sales/salesLogin?"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}
- (IBAction)PostRequestAction:(id)sender {

    NSMutableDictionary *dicParams = nil;
    
    if (dicParams == nil) {
        dicParams = [NSMutableDictionary dictionary];
        [dicParams setObject:@"" forKey:@"pro_code"];
    }
    
    NSNumber *timestamp = [NSNumber numberWithInt:[[NSDate date] timeIntervalSince1970]];
    NSString *phone = @"13810003005";
    NSString *pass = @"123";
    NSDictionary *userDic = @{@"login_phone": phone,
                              @"timestamp"  : timestamp,
                              @"version"    : @"5.0.2",
                              @"encoding"   : @"utf-8",
                              @"client_type": @"1",
                              @"app_code"   : @"vanke_test",
                              @"push_id"    : @""};
    NSMutableDictionary *headDic = [NSMutableDictionary dictionaryWithDictionary:userDic];
    NSString *digest = [[NSString stringWithFormat:@"%@%@%@", timestamp, phone, [pass md5String]] md5String];
    [headDic setObject:digest forKey:@"digest"];
    
    NSMutableDictionary *postJSON = [NSMutableDictionary dictionary];
    [postJSON setObject:headDic forKey:@"head"];
    [postJSON setObject:dicParams forKey:@"body"];
    
    NSString *strJSON = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:postJSON options:0 error:nil] encoding:NSUTF8StringEncoding];
    NSString *strParams = [NSString stringWithFormat:@"info=%@", strJSON];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", kHttpTask_Server, kLoginMethod];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    if (strParams.length > 0) {
        const char *utf8Params = [strParams UTF8String];
        if (utf8Params) {
            
            unsigned long  bodyLength = strlen(utf8Params);
            NSData *body = [NSData dataWithBytes:utf8Params length:bodyLength];
            
            //构造URL
            NSURL *url = [NSURL URLWithString:urlStr];
            //构造request
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            
            //(1)设置为POST请求
            [request setHTTPMethod:@"POST"];

            //超时
            [request setTimeoutInterval:10];
            
            //
            NSDictionary *httpHeader = @{@"Content-Length":[NSString stringWithFormat:@"%lu", bodyLength]};
            [request setAllHTTPHeaderFields:httpHeader];
            
            [request setHTTPBody:body];
            
            NSURLSession *session = [NSURLSession sharedSession];
            
            //4.task
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"jsonString:%@", jsonString);

                
            }];
            
            //5.
            [task resume];

            
        }
    }
    
    
    
    
    
}


@end
