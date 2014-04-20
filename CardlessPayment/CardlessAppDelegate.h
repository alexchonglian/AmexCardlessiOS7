//
//  CardlessAppDelegate.h
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class InviteViewController;

@interface CardlessAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) InviteViewController *inviteViewController;
@property (strong, nonatomic) UIWindow *window;

@end