//
//  MADAppDelegate.h
//  GrandCentralDispatchIntro
//
//  Created by Comyar Zaheri on 1/30/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 NSFoundation Review
 ===================
 
 NSInteger i = 1;
 NSDictionary *aDictionary = @{@(i):@(i)};
 NSMutableDictionary *aMutableDictionary = [aDictionary mutableCopy];
 
 NSMutableArray *aMutableArray = [NSMutableArray new];
 
 UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 150, 200)];
 
 typedef struct {
    CGPoint origin;
    CGSize  size;
 } CGRect;
 
 typedef struct {
    CGFloat x;
    CGFloat y;
 } CGPoint;
 
 typedef struct {
    CGFloat width;
    CGFloat height;
 } CGSize;
 
 typedef float CGFloat;
 */

@interface MADAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
