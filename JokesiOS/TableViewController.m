//
//  TableViewController.m
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/7.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    jokes = [[NSMutableArray alloc] init];
    self.title = @"笑话连连看";
    currentState = STATE_INIT;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CELL_HEIGHT, 0);
    [self getJokesWithOffset:0];
    
    [self initPullToRefreshControl];
    NSLog(@"%@",@"viewDidload");
    
}

- (void)initBottomButton{
    btnLoadMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnLoadMore setTitle:@"查看更多" forState:UIControlStateNormal];
    [btnLoadMore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnLoadMore setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [btnLoadMore addTarget:self action:@selector(upToRefresh) forControlEvents:UIControlEventTouchUpInside];
    CGFloat x = 0;
    CGFloat y = jokes.count * CELL_HEIGHT;
    CGFloat width = 320;
    CGFloat height = CELL_HEIGHT;
    btnLoadMore.frame = CGRectMake(x, y, width, height);
    [self.tableView addSubview:btnLoadMore];
    
}

- (void)upToRefresh{
    currentState = STATE_UP_REFRESH;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    btnLoadMore.enabled = NO;
    [btnLoadMore setTitle:@"正在加载..." forState:UIControlStateDisabled];
    NSLog(@"getJokes offset:%d",jokes.count);
    [self getJokesWithOffset:jokes.count];

}


- (void)pullToRefresh{
    currentState = STATE_PULL_REFRESH;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
    [self getJokesWithOffset:0];
    
}
-(void)resetBottomButton{
    btnLoadMore.frame = CGRectMake(0, jokes.count * CELL_HEIGHT, 320, CELL_HEIGHT);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return CELL_HEIGHT;
}

- (void)initPullToRefreshControl{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    refresh.tintColor = [UIColor greenColor];
    [refresh addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
}

- (void)getJokesWithOffset:(int)offset{
    NSString *params = [NSString stringWithFormat:@"action=get_posts&user_id=%d&offset=%d",1,offset];
    NSString *url = [NSString stringWithFormat:@"%@?%@",BASE_URL,params];
    
    [NetConnection requestJokesWithUrl:url jokesCount:10 successHandler:^(NSData * _Nullable data) {
        NSArray *arr = [JsonParser jsonObjectWithData:data];
        if (currentState == STATE_PULL_REFRESH) {
            [jokes removeAllObjects];
        }
        [jokes addObjectsFromArray:[Joke jokesWithArray:arr]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"%@",@"get jokes success reloadData");
            
            [self.tableView reloadData];
            switch (currentState) {
                case STATE_INIT:
                    [self initBottomButton];
                    currentState = STATE_NORMAL;
                    break;
                case STATE_PULL_REFRESH:
                    currentState = STATE_NORMAL;
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
                    [self.refreshControl endRefreshing];
                    [self resetBottomButton];
                case STATE_UP_REFRESH:
                    currentState = STATE_NORMAL;
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                    if (arr.count <= 0) {
                        [btnLoadMore setTitle:@"没有更多了" forState:UIControlStateNormal];
                    }else{
                        [btnLoadMore setTitle:@"加载更多" forState:UIControlStateNormal];
                    }
                    [self resetBottomButton];
                    btnLoadMore.enabled = YES;
                    [self resetBottomButton];
                
                default:
                    
                    break;
            }
            
        });
        
    } errorHandler:^(NSError * _Nonnull errorMsg) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (currentState == STATE_INIT) {
                currentState = STATE_NORMAL;
                [self initBottomButton];
            }
            btnLoadMore.enabled = YES;
            [btnLoadMore setTitle:@"出错了" forState:UIControlStateNormal];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            if (currentState == STATE_PULL_REFRESH) {
                [self.refreshControl endRefreshing];
            }
            NSLog(@"error! %@",errorMsg);
        });
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count = [jokes count];
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *title = [cell viewWithTag:TAG_CELL_TITLE];
    UILabel *date = [cell viewWithTag:TAG_CELL_DATE];
    
    Joke *item = jokes[indexPath.row];
    
    
    [title setText:item.jokeTitle];
    [date setText:item.jokeDate];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JokeDetailController *detailController = [[self storyboard] instantiateViewControllerWithIdentifier:@"joke"];
   
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:[jokes objectAtIndex:indexPath.row] forKey:@"current_item"];
    
    detailController.currentData = dict;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
