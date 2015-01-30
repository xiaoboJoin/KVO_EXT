//
//  Observer.m
//  KVO_EXT
//
//  Created by iXiaobo on 15-1-30.
//  Copyright (c) 2015年 iXiaobo. All rights reserved.
//

#import "Observer.h"

@implementation Observer


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"Observer-keyPath:%@",keyPath);
    NSLog(@"Observer-object:%@",object);
    NSLog(@"Observer-change:%@",change);
    NSLog(@"context:%@",context);

}



@end
