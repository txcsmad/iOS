//
//  MADRedditPostDownloader.m
//  TableViews
//
//  Created by Comyar Zaheri on 2/18/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MADRedditPostDownloader.h"
#import "MADRedditPost.h"

@implementation MADRedditPostDownloader

+ (void)popularPostsFromSubreddit:(NSString *)subreddit completion:(MADRedditPostDownloaderCompletion)completion
{
    NSString *urlString = [NSString stringWithFormat:@"http://www.reddit.com/r/%@/.json", subreddit];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler: ^ (NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data) {
            NSMutableArray *posts = [NSMutableArray new];
            NSDictionary *redditAllData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSDictionary *children = redditAllData[@"data"][@"children"];
            __block int currentImageCount = 0;
            __block int totalImageCount = [children count];
            for(NSDictionary *postData in children) {
                NSDictionary *postInfo = postData[@"data"];
                __block MADRedditPost *post = [MADRedditPost new];
                post.title = postInfo[@"title"];
                post.subreddit = [NSString stringWithFormat:@"r/%@", postInfo[@"subreddit"]];
                NSString *thumbnailUrlString = postInfo[@"thumbnail"];
                
                NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:thumbnailUrlString]];
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    if(data) {
                        post.thumbnail = [UIImage imageWithData:data];
                    } else {
                        post.thumbnail = nil;
                    }
                    currentImageCount++;
                    if(currentImageCount >= totalImageCount) {
                        completion(posts, nil);
                    }
                }];
                [posts addObject:post];
            }
            
        }
    }];
}

@end
