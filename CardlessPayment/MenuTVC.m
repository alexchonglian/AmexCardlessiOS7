//
//  MenuTVC.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "MenuTVC.h"
#import "MenuDetailViewController.h"

@interface MenuTVC ()

@end

@implementation MenuTVC

#define ALL_ORDERS @"AllOrderes"
#define ORDERED_ENTRIES @"OrderedEntries"
#define NEW_ORDER @"NewOrder"

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
    return [self.entries[row][@"price"] description];
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
    /*
     UIStepper* stepper = [[UIStepper alloc] init];
     stepper.frame = CGRectMake(210, 40, 40, 5);
     */
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.frame = CGRectMake(270, 30, 40, 25);
    [addButton setTitle:@"+1" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(printOut:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = indexPath.row;
    [cell addSubview:addButton];
    //[cell.contentView addSubview: stepper];
    
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
                if ([segue.destinationViewController respondsToSelector:@selector(setImageURI:)]) {
                    NSString *uri = [self.entries[indexPath.row][@"image"] description];
                    [segue.destinationViewController performSelector:@selector(setImageURI:) withObject:uri];
                    [segue.destinationViewController setTitle:[self titleForRow:indexPath.row]];
                }
            }
        }
    }
}


- (void)viewDidLoad

{
    [super viewDidLoad];

}


@end