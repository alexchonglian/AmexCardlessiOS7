//
//  MenuDetailViewController.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "MenuDetailViewController.h"

@interface MenuDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIStepper *qtyStepper;
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end



@implementation MenuDetailViewController

#define CART @"Cart"

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.entry) {
        [self updateUI];
    }
}

- (IBAction)quantityChangedByStepper:(UIStepper *)sender {
    int val = (int)sender.value;
    self.qtyLabel.text = [NSString stringWithFormat:@"Qty: %d", val];
    double price = [self.entry[@"price"] doubleValue];
    self.priceLabel.text = [NSString stringWithFormat:@"Total: $%.02f", price*val];
}

- (IBAction)addToCart {
    if(self.qtyStepper.value != 0) {
        NSLog(@"entry added to cart");
        NSString *badgeString = [[[[[self tabBarController] tabBar] items]
                                  objectAtIndex:1] badgeValue];
        int badgeValue = [badgeString intValue];
        badgeValue += 1;
        badgeString = [NSString stringWithFormat:@"%d", badgeValue];
        [[[[[self tabBarController] tabBar] items]
          objectAtIndex:1] setBadgeValue:badgeString];
    }
    [self addCurrentEntryToUserDefault];
    self.qtyLabel.text = @"Qty: 0";
    self.priceLabel.text = @"Total: $0.00";
    self.qtyStepper.value = 0;
}

- (IBAction)cancelOrderEntry {
    self.qtyLabel.text = @"Qty: 0";
    self.priceLabel.text = @"Total: $0.00";
    self.qtyStepper.value = 0;
    NSLog(@"the order of this entry is cancelled");
}

- (void)setEntry:(NSDictionary *)entry {
    _entry = entry;
    [self updateUI];
}

- (void)updateUI {
    self.imageView.image = [UIImage imageNamed:self.entry[@"image"]];
}

- (void)addCurrentEntryToUserDefault {
    
    NSMutableDictionary *cart = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:CART] mutableCopy];
    if (!cart) {
        cart = [[NSMutableDictionary alloc] init];
    }
    // put entry into dictionay
    [cart setObject:@[self.entry[@"price"], @(self.qtyStepper.value)] forKey:self.entry[@"name"]];
    NSLog(@"%@", cart);
    [[NSUserDefaults standardUserDefaults] setObject:cart forKey:CART];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
