//
//  JokeDetailController.m
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/7.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import "JokeDetailController.h"

@interface JokeDetailController ()

@end

@implementation JokeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Joke *currentItem = [self.currentData objectForKey:@"current_item"];
    self.title = currentItem.jokeTitle;
    [tvContent setText:currentItem.jokeContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
