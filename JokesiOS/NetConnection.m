//
//  NetConnection.m
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import "NetConnection.h"


@implementation NetConnection


+(void)requestJokesWithUrl:(NSString *)url jokesCount:(int)count successHandler:(void (^)(BOOL finished, NSData* __nullable resultData))success errorHandler:(void (^)(NSError*  __nullable errorMsg))error{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (connectionError) {
            error(connectionError);
        }else {
            if (data) {
//                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSRange range;
//                while ((range = [str rangeOfString:@"\\<.*?>" options:NSRegularExpressionSearch]).location != NSNotFound) {
//                    str = [str stringByReplacingCharactersInRange:range withString:@""];
//                }
//                NSLog(@"%@",str);
                success(true,data);
            }
        }
    }];
}
@end
