//
//  AppDelegate.m
//  Beauty
//
//  Created by Yingyi Yang on 7/20/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Theme colors
    UIColor *themePurpleColor = [UIColor colorWithRed:160/255.0 green:21/255.0 blue:86/255.0 alpha:1];
    [[UINavigationBar appearance] setBarTintColor:themePurpleColor]; // Navigation bar color.
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]]; // Navigation bar tint color aka buttons' color.
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}]; // Navigation bar title color.
//    [[UITabBar appearance] setBarTintColor:themePurpleColor]; // Tab bar bar color.
    [[UITabBar appearance] setTintColor:themePurpleColor]; // Tab bar tint color.
    
    // the following is added by weifeng cui
    [Parse enableLocalDatastore];
    
    // Initialize Parse.
    [Parse setApplicationId:@"t10nPGsrtnmDADJKQGPVbR2JXOziyIDJHvm353RQ"
                  clientKey:@"WevqYuVqRAAClG6QQHB5typELaWoaUeCuhKFA2rr"];
    
    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    //the following return is for facebook
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    //return YES;
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



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark for facebook

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}




@end
