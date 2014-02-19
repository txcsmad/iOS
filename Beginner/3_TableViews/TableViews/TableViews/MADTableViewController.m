//
//  MADTableViewController.m
//  TableViews
//
//  Created by Comyar Zaheri on 2/18/14.
//  Copyright (c) 2014 Comyar Zaheri. All rights reserved.
//

#import "MADTableViewController.h"
#import "MADRedditPostDownloader.h"
#import "MADRedditPost.h"

@interface MADTableViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@end

@implementation MADTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
	[MADRedditPostDownloader popularPostsFromSubreddit:@"all" completion: ^ (NSArray *posts, NSError *error) {
        self.posts = posts;
        [self.tableView reloadData];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedditCell"];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"RedditCell"];
    }
    MADRedditPost *post = self.posts[indexPath.row];
    cell.textLabel.text = post.title;
    cell.detailTextLabel.text = post.subreddit;
    cell.imageView.image = post.thumbnail;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

@end
