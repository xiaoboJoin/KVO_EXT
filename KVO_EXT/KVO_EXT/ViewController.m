//
//  ViewController.m
//  KVO_EXT
//
//  Created by iXiaobo on 15-1-30.
//  Copyright (c) 2015年 iXiaobo. All rights reserved.
//

#import "ViewController.h"
#import "LocatonManager.h"
#import "Observer.h"


@interface ViewController ()
{
    Observer *observer;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    observer = [[Observer alloc] init];
//    
   // [[LocatonManager sharedLocationManager] addObserver:observer forKeyPath:@"lat" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [[LocatonManager sharedLocationManager] addObserver:observer forKeyPath:@"lon" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"context2"];
//    
//    
//    [[LocatonManager sharedLocationManager] addObserver:self forKeyPath:@"lat" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    [[LocatonManager sharedLocationManager] addObserver:self forKeyPath:@"lon" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
     [[LocatonManager sharedLocationManager] addObserver:self forKeyPath:@"locationStatus" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"context1"];
    [[LocatonManager sharedLocationManager] startLocation];
    // Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keyPath:%@",keyPath);
    NSLog(@"object:%@",object);
    NSLog(@"change:%@",change);
    NSLog(@"context:%@",context);
}



@end
