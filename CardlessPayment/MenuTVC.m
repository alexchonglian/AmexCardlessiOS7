//
//  MenuTVC.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "MenuTVC.h"
#import "MenuDetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MenuTVC ()

@end

@implementation MenuTVC

#define ALL_ORDERS @"AllOrderes"
#define ORDERED_ENTRIES @"OrderedEntries"
#define NEW_ORDER @"NewOrder"

#define X_ADDBUTTON 270
#define X_DELBUTTON 250
#define Y_BUTTON 20
#define WIDTH_BUTTON 20
#define HEIGHT_BUTTON 20




- (void) setEntries: (NSArray *) entries {
    _entries = entries;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.entries count];
}

- (NSString *) titleForRow: (NSUInteger) row {
    return [self.entries[row][@"name"] description];
}

- (NSString *) subtitleForRow: (NSUInteger) row {
    // NSLog(@"%@", self.entries[row][@"price"]);
    return [NSString stringWithFormat:@"$%@", [self.entries[row][@"price"] description]];
    
}

- (UIImage *) imageForRow: (NSUInteger) row {
    return [UIImage imageNamed: [self.entries[row][@"image"] description]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Entry";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = [self titleForRow:indexPath.row];
    cell.detailTextLabel.text = [self subtitleForRow: indexPath.row];
    cell.imageView.image = [self imageForRow: indexPath.row];

    //UIStepper* stepper = [[UIStepper alloc] init];
    //stepper.frame = CGRectMake(210, 20, 20, 20);

    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.layer.cornerRadius = 5;
    addButton.layer.masksToBounds = YES;
    addButton.frame = CGRectMake(100, 5, 20, 20);

    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor whiteColor]];
    [addButton addTarget:self action:@selector(printOut:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = indexPath.row;
    
    
    
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delButton.layer.cornerRadius = 5;
    delButton.layer.masksToBounds = YES;
    delButton.frame = CGRectMake(50, 5, 20, 20);
    [delButton setTitle:@"-" forState:UIControlStateNormal];
    [delButton setBackgroundColor:[UIColor whiteColor]];
    [delButton addTarget:self action:@selector(printOut:) forControlEvents:UIControlEventTouchUpInside];
    delButton.tag = indexPath.row;
    
    
    UILabel *qty = [[UILabel alloc] initWithFrame:CGRectMake(75, 5, 20, 20)];
    qty.layer.cornerRadius = 5;
    qty.layer.masksToBounds = YES;
    //[qty setBackgroundColor:[UIColor whiteColor]];
    qty.text = @" 0";
    
    UIButton *collapseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //addButton.frame = CGRectMake(X_ADDBUTTON, Y_BUTTON, WIDTH_BUTTON, HEIGHT_BUTTON);
    collapseButton.frame = CGRectMake(5, 5, 40, 20);
    
    [collapseButton setTitle:@">" forState:UIControlStateNormal];
    [collapseButton setBackgroundColor:[UIColor whiteColor]];
    [collapseButton addTarget:self action:@selector(printOut:) forControlEvents:UIControlEventTouchUpInside];
    collapseButton.tag = indexPath.row;
    
    UIView *manipulator = [[UIView alloc] initWithFrame:CGRectMake(180, 34, 128, 30)];
    //[manipulator setUserInteractionEnabled:YES];
    manipulator.opaque = YES;
    [manipulator setBackgroundColor:[UIColor grayColor]];
    //[manipulator addTarget:self action:@selector(printOut:) forControlEvents:UIControlEventTouchUpInside];
    manipulator.tag = indexPath.row;
    manipulator.layer.cornerRadius = 8;
    manipulator.layer.masksToBounds = YES;
    
    // get the scrolling position of the tableview
    // tableView.contentOffset.y;
    
    // get the relative location of tableviewcell in tableview
    
    /*
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 180, 20)];
    label.text = [NSString stringWithFormat:@"%.02f", rectInTableView.origin.y];
    [cell.contentView addSubview:label];
     */
    
    
    //[cell.contentView addSubview:addButton];
    //[cell.contentView addSubview:delButton];
    //[cell.contentView addSubview: stepper];
    [cell.contentView addSubview:manipulator];
    
    [manipulator addSubview:addButton];
    [manipulator addSubview:delButton];
    [manipulator addSubview:qty];
    [manipulator addSubview:collapseButton];
    //manipulator.hidden = YES;
    
    return cell;
}


- (void)printOut: (UIButton *)sender {
    UIButton *button = (UIButton *)sender;
    NSLog(@"%@ %@", [self titleForRow:button.tag],[self subtitleForRow:button.tag]);
    NSString *newEntry = [NSString stringWithFormat:@"%@ %@", [self titleForRow:button.tag],[self subtitleForRow:button.tag]];
    [self addNewEntryToOrderedEntries: newEntry];
}


- (void)addNewEntryToOrderedEntries:(NSString *)newEntry {
    
    NSMutableArray *allOrdersUD = [[[NSUserDefaults standardUserDefaults] arrayForKey:ALL_ORDERS] mutableCopy];
    if (!allOrdersUD) {
        allOrdersUD = [[NSMutableArray alloc] init];
    }
    // put entry into dictionay
    [allOrdersUD addObject:newEntry];
    NSLog(@"%@", allOrdersUD);
    [[NSUserDefaults standardUserDefaults] setObject:allOrdersUD forKey:ALL_ORDERS];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show Entry Detail"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setEntry:)]) {
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                    NSArray *chosenEntry = self.entries[indexPath.row];
                    [segue.destinationViewController performSelector:@selector(setEntry:) withObject:chosenEntry];
                }
            }
        }
    }
}





- (void)viewDidLoad

{
    [super viewDidLoad];
    self.tableView.contentOffset = CGPointMake(0.0, 44.0);

}


@end