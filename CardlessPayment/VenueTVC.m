//
//  VenueTVC.m
//  CardlessPayment
//
//  Created by Chong Lian on 4/19/14.
//  Copyright (c) 2014 Chong Lian. All rights reserved.
//

#import "VenueTVC.h"
#import "MenuTVC.h"

@interface VenueTVC () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchVenue;

@end

@implementation VenueTVC

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.venues count];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Venue";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = self.venues[indexPath.row][@"name"];
    cell.detailTextLabel.text = self.venues[indexPath.row][@"detail"];
    cell.imageView.image = [UIImage imageNamed: self.venues[indexPath.row][@"icon"]];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Choose Venue"]) {
                if ([segue.destinationViewController respondsToSelector:@selector(setEntries:)]) {
                    NSArray *chosenMenu = self.venues[indexPath.row][@"menu"];
                    [segue.destinationViewController performSelector:@selector(setEntries:) withObject:chosenMenu];
                    [segue.destinationViewController setTitle:self.venues[indexPath.row][@"name"]];
                }
            }
        }
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touches");
    [self.searchVenue resignFirstResponder];
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchVenue.delegate = self;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.venues = @[
                    @{
                        @"name":@"Original",
                        @"icon":@"original.jpg",
                        @"detail":@"just a sample",
                        @"menu":[self createMenuForOriginal]
                        },
                    @{
                        @"name":@"Chipotle",
                        @"icon":@"chipotle.jpg",
                        @"detail":@"favorite mexican stuff",
                        @"menu":[self createMenuForChipotle]
                        },
                    @{
                        @"name":@"Subway",
                        @"icon":@"subway.jpg",
                        @"detail":@"sandwich and salad stuff",
                        @"menu":[self createMenuForSubway]
                        }
                    ];
}




- (NSArray *)createMenuForOriginal {
    return @[
             
             @{
                 
                 @"name": @"Mushroom Risotto",
                 
                 @"image": @"mushroom_risotto.jpg",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Full Breakfast",
                 
                 @"image": @"full_breakfast.jpg",
                 
                 @"price": @"$9.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Hamburger",
                 
                 @"image": @"hamburger.jpg",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Egg Benedict",
                 
                 @"image": @"egg_benedict.jpg",
                 
                 @"price": @"$4.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Ham and Egg Sandwich",
                 
                 @"image": @"ham_and_egg_sandwich.jpg",
                 
                 @"price": @"$6.15",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Creme Brelee",
                 
                 @"image": @"creme_brelee.jpg",
                 
                 @"price": @"$6.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"White Chocolate Donut",
                 
                 @"image": @"white_chocolate_donut.jpg",
                 
                 @"price": @"$3.20",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Vegetable Curry",
                 
                 @"image": @"vegetable_curry.jpg",
                 
                 @"price": @"$7.75",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Instant Noodle with Egg",
                 
                 @"image": @"instant_noodle_with_egg.jpg",
                 
                 @"price": @"$9.60",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Noodle with BBQ Pork",
                 
                 @"image": @"noodle_with_bbq_pork.jpg",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Green Tea",
                 
                 @"image": @"green_tea.jpg",
                 
                 @"price": @"$2.80",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Thai Shrimp Cake",
                 
                 @"image": @"thai_shrimp_cake.jpg",
                 
                 @"price": @"$13.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Angry Birds Cake",
                 
                 @"image": @"angry_birds_cake.jpg",
                 
                 @"price": @"$16.00",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Ham and Cheese Panini",
                 
                 @"image": @"ham_and_cheese_panini.jpg",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 }
             
             ];
}


- (NSArray *)createMenuForChipotle {
    return @[
             @{
                 
                 @"name": @"Burrito",
                 
                 @"image": @"burrito.png",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 },
             @{
                 
                 @"name": @"Vege Burrito",
                 
                 @"image": @"vege_burrito.png",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 },
             @{
                 
                 @"name": @"Taco",
                 
                 @"image": @"taco.png",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 },
             @{
                 
                 @"name": @"Grills",
                 
                 @"image": @"grills.png",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 },
             @{
                 
                 @"name": @"Chips",
                 
                 @"image": @"chips2.png",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 }
             ];
}

- (NSArray *)createMenuForSubway {
    return @[
             
             @{
                 
                 @"name": @"Big Philly Cheesesteak",
                 
                 @"image": @"big_philly_cheesesteak.png",
                 
                 @"price": @"$7.85",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Black Forest Ham",
                 
                 @"image": @"black_forest_ham.png",
                 
                 @"price": @"$9.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Buffalo Chicken",
                 
                 @"image": @"buffalo_chicken.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Chicken Bacon Ranch Melt",
                 
                 @"image": @"chicken_bacon_ranch_melt.png",
                 
                 @"price": @"$4.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Chips",
                 
                 @"image": @"chips.png",
                 
                 @"price": @"$6.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Coca Cola",
                 
                 @"image": @"coca_cola.png",
                 
                 @"price": @"$3.20",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Coffee",
                 
                 @"image": @"coffee.png",
                 
                 @"price": @"$7.75",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Cold Cut Cumbo",
                 
                 @"image": @"cold_cut_cumbo.png",
                 
                 @"price": @"$9.60",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Cookies",
                 
                 @"image": @"cookies.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Egg Cheese",
                 
                 @"image": @"egg_cheese.png",
                 
                 @"price": @"$2.80",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Iced Tea",
                 
                 @"image": @"iced_tea.png",
                 
                 @"price": @"$13.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Italian BMT",
                 
                 @"image": @"italian_bmt.png",
                 
                 @"price": @"$16.00",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Meatball Marinara",
                 
                 @"image": @"meatball_marinara.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Roast Beef",
                 
                 @"image": @"roast_beef.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Spicy Italian",
                 
                 @"image": @"spicy_italian.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Steak Cheese",
                 
                 @"image": @"steak_cheese.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Subway Club",
                 
                 @"image": @"subway_club.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Subway Melt",
                 
                 @"image": @"subway_melt.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Sweet Onion Chicken Teriyaki",
                 
                 @"image": @"sweet_onion_chicken_teriyaki.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Tuna",
                 
                 @"image": @"tuna",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Turkey Breast",
                 
                 @"image": @"turkey_breast.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 },
             
             @{
                 
                 @"name": @"Veggie Delite",
                 
                 @"image": @"veggie_delite.png",
                 
                 @"price": @"$12.25",
                 
                 @"rating": @"4.7"
                 
                 }
             
             ];
}



@end