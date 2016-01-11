//
//  JsonParser.m
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import "JsonParser.h"

@implementation JsonParser

+(NSArray*)jsonObjectWithData:(NSData*)data{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return [dict objectForKey:@"posts"];
}

@end
