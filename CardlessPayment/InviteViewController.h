//
//  InviteViewController.h
//  CardlessPayment
//
//  Created by Chong Lian on 4/20/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface InviteViewController : UIViewController<FBFriendPickerDelegate>

- (IBAction)pickFriendsButtonClick:(id)sender;

@end

