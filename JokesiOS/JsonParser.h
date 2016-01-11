//
//  JsonParser.h
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/8.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

+(NSArray*)jsonObjectWithData:(NSData*)data;
@end
