//
//  MADMainViewController.m
//  MADButtons
//
//  Created by Brad Zeis on 2/25/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

#import "MADMainViewController.h"
#import "MADImageDataSource.h"

@interface MADMainViewController ()

@property UIImage *currentImage;

@property UIImageView *imageView;
@property UISlider *opacitySlider;
@property UISwitch *grayScaleSwitch;

@end

@implementation MADMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Feline", @"Canine", @"Other"]];
    segmentedControl.center = CGPointMake(self.view.center.x, 40);
    segmentedControl.selectedSegmentIndex = 1;
    [segmentedControl addTarget:self action:@selector(segmentedControlTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    self.opacitySlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 330, 280, 20)];
    self.opacitySlider.minimumValue = 0;
    self.opacitySlider.maximumValue = 1;
    [self.opacitySlider setValue:1 animated:NO];
    [self.opacitySlider addTarget:self action:@selector(opacitySliderChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.opacitySlider];
    
    self.grayScaleSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    [self.grayScaleSwitch addTarget:self action:@selector(grayScaleSwitchToggled:) forControlEvents:UIControlEventValueChanged];
    self.grayScaleSwitch.center = CGPointMake(270, 400);
    
    [self.view addSubview:self.grayScaleSwitch];
    
    UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetButton.frame = CGRectMake(20, 440, 280, 20);
    [resetButton setTitle:@"Reset" forState:UIControlStateNormal];
    [resetButton setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [resetButton addTarget:self action:@selector(resetButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetButton];
    
    // 1
    self.currentImage = [MADImageDataSource imageWithImageType:MADImageTypeCanine];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, 320, 240)];
    self.imageView.image = self.currentImage;
    [self.view addSubview:self.imageView];
}

- (NSArray *)segments
{
    return @[@"Feline", @"Canine", @"Other"];
}

#pragma mark - Touches

- (void)segmentedControlTapped:(UISegmentedControl *)sender
{
    
    NSString *title = [self segments][sender.selectedSegmentIndex];
    MADImageType imageType = [MADImageDataSource imageTypeForTitle:title];
    
    // 2
    self.currentImage = [MADImageDataSource imageWithImageType:imageType];
    if (self.grayScaleSwitch.on) {
        self.imageView.image = [MADImageDataSource grayScaleImage:self.currentImage];
    } else {
        self.imageView.image = self.currentImage;
    }
}

- (void)opacitySliderChanged:(UISlider *)sender
{
    self.imageView.alpha = sender.value;
}

- (void)grayScaleSwitchToggled:(UISwitch *)sender
{
    // 3
    if (sender.on) {
        self.imageView.image = [MADImageDataSource grayScaleImage:self.currentImage];
    } else {
        self.imageView.image = self.currentImage;
    }
}

- (void)resetButtonTapped
{
    self.imageView.alpha = 1;
    [self.opacitySlider setValue:1 animated:YES];
    
    [self.grayScaleSwitch setOn:NO];
    self.imageView.image = self.currentImage;
}

@end
