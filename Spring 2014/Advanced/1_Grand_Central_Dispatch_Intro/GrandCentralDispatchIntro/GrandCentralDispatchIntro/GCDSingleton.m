//
//  GCDSingleton.m
//  GrandCentralDispatchIntro
//
//  Created by Comyar Zaheri on 1/30/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "GCDSingleton.h"

@implementation GCDSingleton

- (instancetype)init
{
    [NSException raise:@"SingletonError" format:@"Cannot initialize singleton class"];
    return nil;
}

- (instancetype)_init
{
    if(self = [super init]) {
        // initialize object
    }
    return self;
}

+ (GCDSingleton *)sharedGCDSingleton
{
    static GCDSingleton *sharedGCDSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGCDSingleton = [[GCDSingleton alloc]_init];
    });
    return sharedGCDSingleton;
}

@end
