//
//  Joke.m
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import "Joke.h"
#import "Config.h"
@implementation Joke

- (instancetype)initWithTitle:(NSString *)title andContent:(NSString*) content andDate:(NSString*)date {
    self = [super init];
    if (self) {
        self.jokeTitle = title;
        self.jokeContent = content;
        self.jokeDate = date;
    }
    return self;
}
+(Joke*)jokeWithTitle:(NSString *)title andContent:(NSString*)content andDate:(NSString*)date {
    return [[Joke alloc] initWithTitle:title andContent:content andDate:date];
}

+(NSMutableArray*)jokesWithArray:(NSArray *)array{
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSString *title;
    NSString *content;
    NSString *date;
    
    Joke *joke;
    for(int i = 0;i < [array count];i++){
        
        title = [array[i] objectForKey:KEY_POST_TITLE];
        content = [array[i] objectForKey:KEY_POST_CONTENT];
        date = [array[i] objectForKey:KEY_POST_DATE];
        
        joke = [[Joke alloc] initWithTitle:title andContent:content andDate:date];
        [result addObject:joke];
    }
    return result;
}
@end
