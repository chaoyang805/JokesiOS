//
//  Joke.h
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Joke : NSObject

@property (nonatomic) int ID;
@property (nonatomic) NSString* jokeTitle;
@property (nonatomic) NSString* jokeContent;
@property (nonatomic) NSString* jokeDate;
@property (nonatomic) int commentCount;

- (instancetype)initWithTitle:(NSString *)title andContent:(NSString*) content andDate:(NSString*)date;

+(Joke*)jokeWithTitle:(NSString *)title andContent:(NSString*)content andDate:(NSString*)date;
+(NSMutableArray*)jokesWithArray:(NSArray*)array;
@end
