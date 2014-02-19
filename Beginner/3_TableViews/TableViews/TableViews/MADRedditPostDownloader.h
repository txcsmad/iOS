//
//  MADRedditPostDownloader.h
//  TableViews
//
//  Created by Comyar Zaheri on 2/18/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MADRedditPostDownloaderCompletion)(NSArray *posts, NSError *error);

@interface MADRedditPostDownloader : NSObject

+ (void)popularPostsFromSubreddit:(NSString *)subreddit completion:(MADRedditPostDownloaderCompletion)completion;

@end
