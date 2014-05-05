//
//  InviteViewController.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/20/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "InviteViewController.h"

#import "CardlessAppDelegate.h"

@interface InviteViewController ()
@property (strong, nonatomic) IBOutlet UITextView *selectedFriendsView;
@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@property (retain, nonatomic) NSMutableArray *friendsChosen;// of NSString
- (void)fillTextBoxAndDismiss:(NSString *)text;
@end


@implementation InviteViewController
#pragma mark View lifecycle

#define TABLE @"Table"

- (void)viewDidLoad {
    self.friendsChosen = [[NSMutableArray alloc] init];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    self.selectedFriendsView = nil;
    self.friendPickerController = nil;
    self.friendsChosen = nil;
    [super viewDidUnload];
}

#pragma mark UI handlers

- (IBAction)pickFriendsButtonClick:(id)sender {
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session,
                                                          FBSessionState state,
                                                          NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self pickFriendsButtonClick:sender];
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Pick Friends";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    [self presentViewController:self.friendPickerController animated:YES completion:nil];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    self.friendsChosen = [[NSMutableArray alloc] init];
    
    NSMutableString *text = [[NSMutableString alloc] init];
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
        [self.friendsChosen addObject:user.name];
        
    }
    [self addChosenFriendsToUserDefault];
    [self fillTextBoxAndDismiss:text.length > 0 ? text : nil];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self fillTextBoxAndDismiss:nil];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    self.selectedFriendsView.text = text;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return YES;
}


- (void)addChosenFriendsToUserDefault {
    
    //NSMutableArray *table = [[[NSUserDefaults standardUserDefaults] arrayForKey:TABLE] mutableCopy];
    //if (!table) table = [[NSMutableArray alloc] init];
    if (self.friendsChosen) {
        NSLog(@"%@", self.friendsChosen);
        [[NSUserDefaults standardUserDefaults] setObject:self.friendsChosen forKey:TABLE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        NSLog(@"No FB Friend is chosen");
    }
}

@end