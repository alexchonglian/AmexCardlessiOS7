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
@property (weak, nonatomic) IBOutlet UILabel *quantity;
@property (weak, nonatomic) IBOutlet UILabel *price;
@end

@implementation MenuDetailViewController


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
    self.quantity.text = [NSString stringWithFormat:@"Qty: %d", val];
    double price = [self.entry[@"price"] doubleValue];
    self.price.text = [NSString stringWithFormat:@"Total: $%.02f", price*val];
}

- (IBAction)addToCart {
    NSLog(@"entry added to cart");
    [[[[[self tabBarController] tabBar] items]
      objectAtIndex:1] setBadgeValue:@"1"];
}

- (IBAction)cancelOrderEntry {
    self.quantity.text = @"Qty: 0";
    self.price.text = @"Total: $0.00";
    NSLog(@"the order of this entry is cancelled");
}

- (void)setEntry:(NSDictionary *)entry {
    _entry = entry;
    [self updateUI];
}

- (void)updateUI {
    self.imageView.image = [UIImage imageNamed:self.entry[@"image"]];
}


@end
