//
//  JokeDetailController.h
//  JokesiOS
//
//  Created by chaoyang805 on 16/1/7.
//  Copyright © 2016年 com.jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Joke.h"
@interface JokeDetailController : UIViewController{
    
    IBOutlet UITextView *tvContent;
}
@property (nonatomic,strong) NSDictionary *currentData;

@end
