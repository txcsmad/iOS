//
//  MADAppDelegate.m
//  Data_Persistence
//
//  Created by Comyar Zaheri on 2/13/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MADAppDelegate.h"

@interface MADAppDelegate ()

@property (assign, nonatomic) BOOL                  aBool;
@property (assign, nonatomic) CGFloat               aFloat;
@property (assign, nonatomic) NSInteger             anInt;

@property (strong, nonatomic) NSArray               *anArray;
@property (strong, nonatomic) NSMutableArray        *aMutableArray;

@property (strong, nonatomic) NSDictionary          *aDictionary;
@property (strong, nonatomic) NSMutableDictionary   *aMutableDictionary;

@end

@implementation MADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    self.aBool  = [[NSUserDefaults standardUserDefaults]boolForKey:@"aBool"];
    self.aFloat = [[NSUserDefaults standardUserDefaults]floatForKey:@"aFloat"];
    self.anInt  = [[NSUserDefaults standardUserDefaults]integerForKey:@"anInt"];
    
    NSData *archivedArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"anArray"];
    self.anArray = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArray];
    
    NSData *archivedMutableArray = [[NSUserDefaults standardUserDefaults]objectForKey:@"aMutableArray"];
    self.aMutableArray = [[NSKeyedUnarchiver unarchiveObjectWithData:archivedMutableArray]mutableCopy];
    
    NSData *archivedDictionary = [[NSUserDefaults standardUserDefaults]objectForKey:@"aDictionary"];
    self.aDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:archivedDictionary];
    
    NSData *archivedMutableDictionary = [[NSUserDefaults standardUserDefaults]objectForKey:@"aMutableDictionary"];
    self.aMutableDictionary = [[NSKeyedUnarchiver unarchiveObjectWithData:archivedMutableDictionary]mutableCopy];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"aBool"];
    [[NSUserDefaults standardUserDefaults]setFloat:3.14 forKey:@"aFloat"];
    [[NSUserDefaults standardUserDefaults]setInteger:4 forKey:@"anInt"];
    
    NSData *archivedArray = [NSKeyedArchiver archivedDataWithRootObject:self.anArray];
    [[NSUserDefaults standardUserDefaults]setObject:archivedArray forKey:@"anArray"];
    
    NSData *archivedMutableArray = [NSKeyedArchiver archivedDataWithRootObject:self.aMutableArray];
    [[NSUserDefaults standardUserDefaults]setObject:archivedMutableArray forKey:@"aMutableArray"];
    
    NSData *archivedDictionary = [NSKeyedArchiver archivedDataWithRootObject:self.aDictionary];
    [[NSUserDefaults standardUserDefaults]setObject:archivedDictionary forKey:@"aDictionary"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
