//
//  LocatonManager.h
//  KVO_EXT
//
//  Created by iXiaobo on 15-1-30.
//  Copyright (c) 2015年 iXiaobo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum LocationStatus
{
    LocationStatusSuccess = 0,
    LocationStatusFail,
    LocationStatusDoing,
}LocationStatus;


@interface LocatonManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *myLocationManager;
    NSLock *locationLock;
    
}
@property(nonatomic)BOOL didUpdateLocations;
@property(nonatomic)LocationStatus locationStatus;
@property(nonatomic)double lat;
@property(nonatomic)double lon;

+(LocatonManager *)sharedLocationManager;

- (void)startLocation;
- (void)stopLocation;

@end
