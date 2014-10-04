//
//  MADRedditPost.h
//  TableViews
//
//  Created by Comyar Zaheri on 2/18/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADRedditPost : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subreddit;
@property (strong, nonatomic) UIImage  *thumbnail;
@end
