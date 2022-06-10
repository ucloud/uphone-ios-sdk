//
//  AppDelegate.m
//  UPhoneDemo
//
//  Created by user on 2021/11/15.
//

#import "AppDelegate.h"
#import <UPhoneSDK/UPhoneSDK.h>
#import <AVKit/AVKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate {
    UIBackgroundTaskIdentifier bgTask;

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
 
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
 
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

@end
