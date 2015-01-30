//
//  LocatonManager.m
//  KVO_EXT
//
//  Created by iXiaobo on 15-1-30.
//  Copyright (c) 2015年 iXiaobo. All rights reserved.
//

#import "LocatonManager.h"

@implementation LocatonManager
@synthesize lat,lon;
@synthesize locationStatus;
@synthesize didUpdateLocations;

+(LocatonManager *)sharedLocationManager
{
    static LocatonManager *locationManager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        locationManager = [[LocatonManager alloc] init];
    });
    return locationManager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.lat = 0.0;
        self.lon = 0.0;
        myLocationManager = [[CLLocationManager alloc] init];
        [myLocationManager setDelegate:self];
        myLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        myLocationManager.distanceFilter = 1000.0f;
        locationLock = [[NSLock alloc] init];
    }
    return self;
}



#pragma mark API
- (void)startLocation
{
    if ([locationLock tryLock])
    {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0)
        {
            [myLocationManager requestWhenInUseAuthorization];
        }
        [myLocationManager startUpdatingLocation];
        didUpdateLocations = NO;
        self.locationStatus = LocationStatusDoing;
    }
   
}


- (void)stopLocation
{
    [locationLock unlock];
    [myLocationManager stopUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate 
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (!didUpdateLocations)
    {
        didUpdateLocations = YES;
        CLLocation *location = [locations lastObject];
        [self setValue:[NSNumber numberWithDouble:location.coordinate.latitude] forKey:@"lat"];
        [self setValue:[NSNumber numberWithDouble:location.coordinate.longitude] forKey:@"lon"];
        [self setValue:[NSNumber numberWithInteger:LocationStatusSuccess] forKey:@"locationStatus"];
        
        [self stopLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [manager requestAlwaysAuthorization];
            }
            
            if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [manager requestWhenInUseAuthorization];
            }
            
            break;
        case kCLAuthorizationStatusRestricted:
            
            break;
        case kCLAuthorizationStatusDenied:
            
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)])
            {
                [manager requestAlwaysAuthorization];
            }
            break;
            
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        
            if ([manager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [manager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self stopLocation];
    [self setValue:[NSNumber numberWithInteger:LocationStatusFail] forKey:@"locationStatus"];
}

- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    
     [self stopLocation];
     [self setValue:[NSNumber numberWithInteger:LocationStatusFail] forKey:@"locationStatus"];
}


#pragma mark CLLocationManagerDelegate




@end
