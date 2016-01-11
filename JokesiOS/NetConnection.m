//
//  NetConnection.m
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import "NetConnection.h"

@implementation NetConnection


+(void)requestJokesWithUrl:(NSString *)url jokesCount:(int)count successHandler:(void (^)(NSData* __nullable resultData))success errorHandler:(void (^)(NSError*  __nullable errorMsg))error{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable e) {
        if (e) {
            error(e);
        }else {
            
            if (data){
                success(data);
            }
        }

    }];
    [task resume];
//    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//    
//        if (connectionError) {
//            error(connectionError);
//        }else {
//            if (data) {
//                success(data);
//            }
//        }
//    }];
}
@end
