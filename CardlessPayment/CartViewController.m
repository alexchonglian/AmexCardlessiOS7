//
//  CartViewController.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()
@property (strong, nonatomic) NSMutableArray *table;
@property (strong ,nonatomic) NSMutableDictionary *cart;
@property (strong, nonatomic) NSMutableDictionary *splittedOrder;
@property (weak, nonatomic) IBOutlet UITextView *totalOrder;
@property (weak, nonatomic) IBOutlet UITextView *myOrder;

@end

@implementation CartViewController

#define TABLE @"Table"
#define CART @"Cart"

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    if (!self.splittedOrder) self.splittedOrder = [[NSMutableDictionary alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    self.table = [[[NSUserDefaults standardUserDefaults] arrayForKey:TABLE] mutableCopy];
    self.cart = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:CART] mutableCopy];
    NSLog(@"%@", self.table);
    
    if (self.table) {
        [self.splittedOrder setObject:self.cart forKey:@"Shared"];
        [self.splittedOrder setObject:@[] forKey:@"Alex Chong Lian"];
        for (NSString *splitter in self.table) {
            [self.splittedOrder setObject:@[] forKey:splitter];
        }
        NSLog(@"%@", self.splittedOrder);
        
    } else {//self.table is empty
        [self.splittedOrder setObject:self.cart forKey:@"Shared"];
        NSLog(@"%@", self.splittedOrder);
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
