//
//  MADMainViewController.m
//  iOS_Intro_Detailed
//
//  Created by Comyar Zaheri on 2/11/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MADMainViewController.h"

@interface MADMainViewController ()

// Class Extensions
// Properties
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation MADMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"balloon"]];
        self.imageView.center = self.view.center;
        [self.view addSubview:self.imageView];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // UIView animations
    // Objective-C blocks
    [UIView animateWithDuration:5.0 animations: ^ {
        self.imageView.frame = CGRectMake(0, -500, CGRectGetWidth(self.imageView.bounds), CGRectGetHeight(self.imageView.bounds));
    }];
}

@end
