//
//  MADAppDelegate.m
//  GrandCentralDispatchIntro
//
//  Created by Comyar Zaheri on 1/30/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MADAppDelegate.h"

@implementation MADAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     Grand Central Dispatch (GCD) is a C-level API that supports asynchronous execution of operations at the kernel level
     
     GDC provides and manages FIFO queues to which your application can submit tasks in the form of block objects. Blocks submitted
     to dispatch queues are executed on a pool of threads fully managed by the system. No guarantee is made as the to the thread
     on which a task executes (usually). Three types of queues:
        
        Main : tasks execute serially on your application's main thread
        Concurrent : tasks are dequeued in FIFO order, but run concurrently and can finish in any order
        Serial : tasks execute one at a time in FIFO order
     */
    
    /**
     Submits a block to the main queue for execution
     dispatch_async will return immediately once the block has been submitted, and will not wait for the block to execute
     */
    dispatch_async(dispatch_get_main_queue(), ^ {
        printf("%s", "* This block is being queued onto the main queue, then dequeued and executed on the main thread\n");
    });
    
    /** 
     Submits a block to a dispatch queue for execution
     dispatch_sync will return only after the block has been submitted and executed
     */
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        printf("%s", "* Starting dispatch_sync block on dispatch_queue_priority_default queue\n");
        for(long i = 0; i < LONG_MAX; ++i) {}
        printf("%s", "* Finished dispatch_sync block on dispatch_queue_priority_default queue\n");
    });
    
    /**
     Execute the once block
     Despite being called 10 times, the method will only ever print once
     */
    for (int i = 0; i < 10; ++i) {
        [self executeOnceBlock];
    }
    
    return YES;
}

- (void)executeOnceBlock
{
    // This token is used by GCD to store whether the block has been executed or not
    static dispatch_once_t onceToken;
    
    // Executes the submitted block only once
    dispatch_once(&onceToken, ^{
        printf("%s", "* This block will only ever get executed once, no matter how many times this method is called\n");
    });
}

@end
