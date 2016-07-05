//
//  AppDelegate.m
//  BaiduMusicDemo
//
//  Created by Life's a struggle on 16/7/4.
//  Copyright © 2016年 Karl. All rights reserved.
//

#import "AppDelegate.h"
#import "TingSDKManager.h"
#import "SongsListController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#define API_KEY    @"H7THeqTNzDcUOpNuvs0gXGIL"
#define SECRET_KEY @"KCzK1bvf7yAmzNbMsPTwcw7uNaqmGBox"
#define SCOPE      @"music_media_basic,music_musicdata_basic,music_search_basic"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    __block BOOL authorFinished = NO;

    [[TingSDKManager sharedInstance] configuration:API_KEY appSecret:SECRET_KEY scope:SCOPE];
    [[TingSDKManager sharedInstance] authorize:^(int status) {
        authorFinished = YES;
    }];
    
    while (!authorFinished) {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
    
    CTCallCenter *center = [[CTCallCenter alloc] init];
    center.callEventHandler = ^(CTCall *call){
    
        if (call.callState == CTCallStateDialing || call.callState == CTCallStateConnected) {
            NSLog(@"暂停播放");
        }
        
        if (call.callState == CTCallStateDisconnected) {
            NSLog(@"恢复播放");
        }
    
    
    };
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    SongsListController *list = [[SongsListController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:list];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
