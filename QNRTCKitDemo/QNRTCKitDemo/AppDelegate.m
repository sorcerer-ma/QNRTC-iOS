//
//  AppDelegate.m
//  QNRTCKitDemo
//
//  Created by lawder on 2017/10/16.
//  Copyright © 2017年 Pili Engineering, Qiniu Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "QRDLoginViewController.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <QNRTCKit/QNRTCKit.h>

#import "QRDNetworkUtil.h" // 测试用，先不删

#import <Bugsnag.h>

@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [Bugsnag startBugsnagWithApiKey:@"5c557cf459b88bd2726b2055530eac91"];
    
    // 测试 http 请求，先不删，搞懂了再删
//    [QRDNetworkUtil requestUserAuth:(NSString *)@"111"
//                              phone:(NSString *)@"12345"
//                            smsCode:(NSString *)@"4321"
//                    completeHandler:^(NSError *error, NSString *token){
//        if (error) {
//            NSLog(@"=========== error: %@", error);
//        }
//        NSLog(@"========= user auth token: %@", token);
//    }];

    
    QRDLoginViewController *loginVC = [[QRDLoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    [Fabric with:@[[Crashlytics class]]];
    [QNRTC enableFileLogging];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 测试唤醒
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSLog(@"%s",__func__);
    NSLog(@"options: %@", options);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    
    return YES;
}

@end
