//
//  TableViewController.h
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/7.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetConnection.h"
#import "Config.h"
#import "Joke.h"
#import "JsonParser.h"
#import "JokeDetailController.h"

#define TAG_CELL_TITLE 1
#define TAG_CELL_DATE 2
#define CELL_HEIGHT 60
#define STATE_INIT 0
#define STATE_NORMAL 1
#define STATE_PULL_REFRESH 2
#define STATE_UP_REFRESH 3
@interface TableViewController : UITableViewController{
    UILabel *jokeName;
    UILabel *jokeDate;
    NSMutableArray *jokes;
    
    UIButton *btnLoadMore;
    int currentState;
}

- (void)getJokesWithOffset:(int)offset;
- (void)initPullToRefreshControl;
- (void)initBottomButton;
@end
