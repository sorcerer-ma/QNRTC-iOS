//
//  QRDNetworkUtil.m
//  QNRTCTestDemo
//
//  Created by hxiongan on 2018/8/16.
//  Copyright © 2018年 hxiongan. All rights reserved.
//

#import "QRDNetworkUtil.h"

@implementation QRDNetworkUtil



+ (void)requestUserAuth2:(NSString *)title
                
        completeHandler:(void (^)(NSError *, NSString *))completionHandler {
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://139.224.17.35:5080/v1/meeting"]];
            
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl];

    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;

    NSDictionary *params = @{
        @"title": title
    };
    NSData *paramsData= [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
    [request setHTTPBody:paramsData];
    
    NSURLSessionDataTask *retData = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error, nil);
            });
            return;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, dic[@"rtc"][@"roomToken"]);
        });
    }];
    [retData resume];
}



+ (void)requestUserAuth:(NSString *)userId
                  phone:(NSString *)phone
                smsCode:(NSString *)smsCode
        completeHandler:(void (^)(NSError *, NSString *))completionHandler {
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://10.200.20.28:5080/v1/signUpOrIn"]];
            
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl];

    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    request.timeoutInterval = 10;

    NSDictionary *params = @{
        @"phone": phone,
        @"smsCode": smsCode
    };
    NSData *paramsData= [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    
    [request setHTTPBody:paramsData];
    
    NSURLSessionDataTask *retData = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error, nil);
            });
            return;
        }
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, dic[@"loginToken"]);
        });
    }];
    [retData resume];
}

+ (void)requestTokenWithRoomName:(NSString *)roomName
                           appId:(NSString *)appId
                          userId:(NSString *)userId
               completionHandler:(void (^)(NSError *, NSString *))completionHandler {
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api-demo.qnsdk.com/v1/rtc/token/admin/app/%@/room/%@/user/%@?bundleId=%@", appId, roomName, userId, [[NSBundle mainBundle] bundleIdentifier]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error, nil);
            });
            return;
        }
        
        NSString *token = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, token);
        });
    }];
    [task resume];
}

+ (void)requestRoomUserListWithRoomName:(NSString *)roomName appId:(NSString *)appId completionHandler:(void (^)(NSError *, NSDictionary *))completionHandler {
    
    NSURL *requestUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api-demo.qnsdk.com/v1/rtc/users/app/%@/room/%@", appId, roomName]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:requestUrl];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    request.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(error, nil);
            });
            return;
        }
        
        NSDictionary * userListDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(nil, userListDic);
        });
    }];
    [task resume];
}

@end
