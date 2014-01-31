//
//  GCDSingleton.h
//  GrandCentralDispatchIntro
//
//  Created by Comyar Zaheri on 1/30/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Challenge
 =========
 Create a singleton using GCD
 - must use dispatch_once
 - must not be able to get an instance of the object by calling init
    * return the singleton or
    * raise an exception
 - singleton must be available by calling a class method
 */
@interface GCDSingleton : NSObject

+ (GCDSingleton *)sharedGCDSingleton;

@end
