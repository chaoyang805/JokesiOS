//
//  NetConnection.h
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetConnection : NSObject

@property (nonatomic,nonnull) NSString *urlStr;

+(void)requestJokesWithUrl: (NSString* _Nonnull)url jokesCount: (int)count successHandler: (void (^__nullable)(BOOL finished,NSData* __nullable resultData))success errorHandler: (void (^__nullable)( NSError* _Nonnull errorMsg))error;
@end
