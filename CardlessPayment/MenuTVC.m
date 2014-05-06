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
@property (nonatomic, strong) NSMutableArray *quantities;
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

    UIButton *expandButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    expandButton.layer.cornerRadius = 15;
    expandButton.layer.masksToBounds = YES;
    expandButton.frame = CGRectMake(280, 20, 30, 30);
    [expandButton setTitle:@"+" forState:UIControlStateNormal];
    [expandButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [expandButton setBackgroundColor:[UIColor colorWithRed:(CGFloat)0.8f green:(CGFloat)0.8f blue:(CGFloat)0.8f alpha:(CGFloat)1.0f]];
    [expandButton addTarget:self action:@selector(expandManipulator:) forControlEvents:UIControlEventTouchUpInside];
    expandButton.tag = indexPath.row;
    
    
    
    UILabel *qtyLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 6, 27, 33)];
    qtyLabel.layer.cornerRadius = 5;
    qtyLabel.layer.masksToBounds = YES;
    //[qtyLabel setBackgroundColor:[UIColor whiteColor]];
    qtyLabel.text = @"0";
    
    UIButton *delButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    delButton.layer.cornerRadius = 5;
    delButton.layer.masksToBounds = YES;
    delButton.frame = CGRectMake(6, 6, 33, 33);
    [delButton setTitle:@"-" forState:UIControlStateNormal];
    [delButton setBackgroundColor:[UIColor whiteColor]];
    [delButton addTarget:self action:@selector(decrementQty:) forControlEvents:UIControlEventTouchUpInside];
    delButton.tag = indexPath.row;
    
    
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addButton.layer.cornerRadius = 5;
    addButton.layer.masksToBounds = YES;
    addButton.frame = CGRectMake(70, 6, 33, 33);
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setBackgroundColor:[UIColor whiteColor]];
    [addButton addTarget:self action:@selector(incrementQty:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tag = indexPath.row;
    
    
    UIButton *collapseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //addButton.frame = CGRectMake(X_ADDBUTTON, Y_BUTTON, WIDTH_BUTTON, HEIGHT_BUTTON);
    collapseButton.frame = CGRectMake(109, 6, 45, 33);
    //[collapseButton setBackgroundColor:[UIColor whiteColor]];
    [collapseButton setTitle:@"    √" forState:UIControlStateNormal];
    [collapseButton addTarget:self action:@selector(collapseManipulatorAndAddItemToCart:) forControlEvents:UIControlEventTouchUpInside];
    collapseButton.tag = indexPath.row;
    
    
    
    UIView *manipulator = [[UIView alloc] initWithFrame:CGRectMake(153, 10, 160, 45)];
    //[manipulator setUserInteractionEnabled:YES];
    manipulator.opaque = YES;
    [manipulator setBackgroundColor:[UIColor colorWithRed:(CGFloat)0.8f green:(CGFloat)0.8f blue:(CGFloat)0.8f alpha:(CGFloat)1.0f]];
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
    

    
    
    [cell.contentView addSubview:expandButton];
    
    [cell.contentView addSubview:manipulator];
    
    [manipulator addSubview:addButton];
    [manipulator addSubview:delButton];
    [manipulator addSubview:qtyLabel];
    [manipulator addSubview:collapseButton];
    manipulator.hidden = YES;
    
    return cell;
}

- (IBAction)expandManipulator: (UIButton *)sender {
    UIButton *expand = (UIButton *)sender;
    UIView *cellContentView = expand.superview;
    for (UIView *manipulator in cellContentView.subviews) {
        //NSLog(@"%@", view);
        if([manipulator isMemberOfClass:[UIView class]]) {
            
            for (UIView *manipulatorComponent in manipulator.subviews) {
                if([manipulatorComponent isMemberOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel *)manipulatorComponent;
                    int qty = [label.text intValue];
                    if (qty == 0) {
                        label.text = @"1";
                    }
                }
            }
            manipulator.hidden = NO;
        }
    }
    expand.hidden = YES;
}



- (IBAction)collapseManipulatorAndAddItemToCart: (UIButton *)sender {
    UIButton *collapse = (UIButton *)sender;
    
    int qty = 0;
    
    for (UIView *manipulatorComponent in collapse.superview.subviews) {
        if ([manipulatorComponent isMemberOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)manipulatorComponent;
            qty = [label.text intValue];
        }
    }
    
    UIView *cellContentView = collapse.superview.superview;
    for (UIView *cellComponent in cellContentView.subviews) {
        //NSLog(@"%@", view);
        if([cellComponent isMemberOfClass:[UIButton class]]) {
            UIButton *expandBtn = (UIButton *) cellComponent;
            if (qty > 0) {
                [expandBtn setTitle:[NSString stringWithFormat:@"%d", qty] forState:UIControlStateNormal];
                [expandBtn setBackgroundColor:[UIColor redColor]];
                NSString *badgeString = [[[[[self tabBarController] tabBar] items]
                                          objectAtIndex:1] badgeValue];
                int badgeValue = [badgeString intValue];
                badgeValue += 1;
                badgeString = [NSString stringWithFormat:@"%d", badgeValue];
                [[[[[self tabBarController] tabBar] items]
                  objectAtIndex:1] setBadgeValue:badgeString];
            } else {
                [expandBtn setTitle:@"+" forState:UIControlStateNormal];
                [expandBtn setBackgroundColor:[UIColor colorWithRed:(CGFloat)0.8f green:(CGFloat)0.8f blue:(CGFloat)0.8f alpha:(CGFloat)1.0f]];
            }
            expandBtn.hidden = NO;
        }
    }
    collapse.superview.hidden = YES;
}


- (IBAction)decrementQty:(UIButton *)sender {
    [self changeQty: sender by:-1];
}

- (IBAction)incrementQty: (UIButton *)sender {
    [self changeQty: sender by:1];
}


- (IBAction)changeQty: (UIButton *)sender by:(int)num{
    UIButton *addOrSubButton = (UIButton *)sender;
    UIView *cellContentView = addOrSubButton.superview.superview;
    for (UIView *view in cellContentView.subviews) {
        //NSLog(@"%@", view);
        if([view isMemberOfClass:[UIView class]]) {
            for (UIView *subview in view.subviews) {
                if([subview isMemberOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel*)subview;
                    int qty = [label.text intValue];
                    if(qty > 0 || num == 1) {
                        qty += num;
                    }
                    label.text = [NSString stringWithFormat:@"%d", qty];
                }
            }

        }
    }
}

- (IBAction)printOut: (UIButton *)sender {
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
    self.quantities = [NSMutableArray arrayWithCapacity:[self.entries count]];
}


@end