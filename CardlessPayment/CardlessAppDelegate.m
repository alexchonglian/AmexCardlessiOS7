//
//  CardlessAppDelegate.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "CardlessAppDelegate.h"
#import "InviteViewController.h"

@implementation CardlessAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}



- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

@end
