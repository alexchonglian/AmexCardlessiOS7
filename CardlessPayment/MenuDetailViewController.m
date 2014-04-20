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
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation MenuDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.imageURI) {
        [self updateImage];
    }
}

- (void)setImageURI:(NSString *)imageURI {
    _imageURI = imageURI;
    [self updateImage];
}

- (void)updateImage {
    self.imageView.image = [UIImage imageNamed:self.imageURI];
}


@end
