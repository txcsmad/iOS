//
//  MADMainViewController.m
//  MADBalloons
//
//  Created by Brad Zeis on 3/4/14.
//  Copyright (c) 2014 MAD. All rights reserved.
//

#import "MADMainViewController.h"

@interface MADMainViewController ()

@property UIButton *button;
@property UIImageView *balloonImageView;

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
    
    // Initialize freedom button
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(0, 0, 320, 320);
    [self.button setTitle:@"Set balloon free" forState:UIControlStateNormal];
    [self.button setTitle:@"Balloon found freedom" forState:UIControlStateHighlighted];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    
    // Target-Action is a pretty important concept that will keep coming back.
    // UIControl (subclass of UIView) defines the target-action methods. You can read about it here:
    // https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIControl_Class/Reference/Reference.html
    //
    // UIButtons, UISliders, UISwitches, etc. are all subclasses of UIControl.
    [self.button addTarget:self action:@selector(freedomButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
    
    // Initialize balloonImageView
    UIImage *balloonImage = [UIImage imageNamed:@"balloon"];
    self.balloonImageView = [[UIImageView alloc] initWithImage:balloonImage];
    self.balloonImageView.center = self.view.center;
    self.balloonImageView.hidden = YES;
    [self.view addSubview:self.balloonImageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)freedomButtonTapped
{
    // We have to reset the balloon's position at the start of the animation
    self.balloonImageView.hidden = NO;
    self.balloonImageView.center = self.view.center;
    
    // Block based UIView animations are the standard way to run animations on iOS.
    // There are several different versions of this method that take slightly different
    // arguments. Relevant documentation (scroll down a bit):
    // https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIView_Class/UIView/UIView.html
    
    // If you're confused about blocks, this might help (it might also confuse you more):
    // https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/WorkingwithBlocks/WorkingwithBlocks.html#//apple_ref/doc/uid/TP40011210-CH8-SW1
    
    [UIView animateWithDuration:2.0 animations:^{
        // Set the properties you want to animate here
        // You can animate:
        //      - center/frame
        //      - backgroundColor
        //      - alpha
        //      - etc
        
        self.balloonImageView.center = CGPointMake(160, -500);
        
    } completion:^(BOOL finished) {
        
        // The completion block is called when the animation finishes or is stopped early.
        // finished will be true if the animation finished animating and false otherwise.
        
        // The animation is stopped early when you start another animation on UIViews that are
        // already animating.
        
        // When the animation finishes, we call freedomButtonTapped again so the animation
        // runs indefinitely.
        if (finished) {
            [self freedomButtonTapped];
        }
    }];
}

@end
