//
//  OrderTVC.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/20/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "OrderTVC.h"

@interface OrderTVC () <UITableViewDataSource>

@end

@implementation OrderTVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.orders = @[
                    @[@"Shared", @[
                          @{@"name": @"Mushroom Risotto",@"price": @"$7.85"},
                          @{@"name": @"Full Breakfast",@"price": @"$9.25"},
                          @{@"name": @"Hamburger",@"price": @"$12.25"}
                          ]],
                    @[@"Alex", @[
                          @{@"name": @"Mushroom Risotto",@"price": @"$7.85"},
                          @{@"name": @"Full Breakfast",@"price": @"$9.25"},
                          @{@"name": @"Hamburger",@"price": @"$12.25"}
                          ]],
                    @[@"Bob", @[
                          @{@"name": @"Egg Benedict",@"price": @"$4.25"},
                          @{@"name": @"Ham and Egg Sandwich",@"price": @"$6.15"},
                          @{@"name": @"Creme Brelee",@"price": @"$6.25"}
                          ]],
                    @[@"Chris", @[
                          @{@"name": @"White Chocolate Donut",@"price": @"$3.20"},
                          @{@"name": @"Vegetable Curry",@"price": @"$7.75"},
                          @{@"name": @"Instant Noodle with Egg",@"price": @"$9.60"},
                          @{@"name": @"Noodle with BBQ Pork",@"price": @"$12.25"}
                          ]],
                    @[@"David", @[
                          @{@"name": @"Green Tea",@"price": @"$2.80"},
                          @{@"name": @"Thai Shrimp Cake",@"price": @"$13.25"},
                          @{@"name": @"Angry Birds Cake",@"price": @"$16.00"},
                          @{@"name": @"Ham and Cheese Panini",@"price": @"$12.25"}
                          ]]
                    ];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.orders count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.orders[section][1] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.orders[section][0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderedEntry";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSInteger sectionIdx = indexPath.section;
    NSInteger rowIdx = indexPath.row;
    
    cell.textLabel.text = self.orders[sectionIdx][1][rowIdx][@"name"];
    cell.detailTextLabel.text = self.orders[sectionIdx][1][rowIdx][@"price"];
    return cell;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


@end