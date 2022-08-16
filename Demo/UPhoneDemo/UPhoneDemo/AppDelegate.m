//
//  AppDelegate.m
//  UPhoneDemo
//
//  Created by user on 2021/11/15.
//

#import "AppDelegate.h"
#import <UPhoneSDK/UPhoneSDK.h>
#import <AVKit/AVKit.h>
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate {
    UIBackgroundTaskIdentifier bgTask;

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    self.window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //解决该问题的代码
       NSArray *windows = [[UIApplication sharedApplication] windows];
       for(UIWindow *window in windows) {
           if(window.rootViewController == nil){
               ViewController *vc = [[ViewController alloc]initWithNibName:nil
                                                                    bundle:nil];
               window.rootViewController = vc;
           }
       }
    [self.window makeKeyAndVisible];
    
    
    return YES;
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    self->bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
                
        [application endBackgroundTask:self->bgTask];
        self->bgTask = UIBackgroundTaskInvalid;
     }];
     
     if (self->bgTask == UIBackgroundTaskInvalid) {
         NSLog(@"failed to start background task!");
     }
     
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    __block NSTimeInterval timeRemain = 0;
     do{
       [NSThread sleepForTimeInterval:5];
         if (self->bgTask!= UIBackgroundTaskInvalid) {
           dispatch_async(dispatch_get_main_queue(), ^{
               timeRemain = [application backgroundTimeRemaining];
           });
         NSLog(@"Time remaining: %f",timeRemain);
       }
     }while(self->bgTask!= UIBackgroundTaskInvalid && timeRemain > 0);
  
     dispatch_async(dispatch_get_main_queue(), ^{
       if (self->bgTask != UIBackgroundTaskInvalid)
       {
         [application endBackgroundTask:self->bgTask];
           self->bgTask = UIBackgroundTaskInvalid;
       }
     });
   });
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    if (bgTask != UIBackgroundTaskInvalid) {
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
 
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"--- %s ---",__func__);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"applicationWillResignActive" object:nil];

    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

@end
