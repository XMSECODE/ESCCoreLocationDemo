//
//  ESCLocationManager.m
//  ESCCoreLocationDemo
//
//  Created by xiang on 5/24/19.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "ESCLocationManager.h"

@interface ESCLocationManager () <CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager* locationManager;

@property(nonatomic,assign)BOOL authorizationState;

@end

@implementation ESCLocationManager

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    return self;
}

- (void)checkLocationAuthorizationState {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.authorizationState = YES;
        return;
    }
    [self.locationManager requestWhenInUseAuthorization];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"kCLAuthorizationStatusNotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"kCLAuthorizationStatusRestricted");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"kCLAuthorizationStatusDenied");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"kCLAuthorizationStatusAuthorizedAlways");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"kCLAuthorizationStatusAuthorizedWhenInUse");
            self.authorizationState = YES;
            break;
    }
    
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    if (locationServicesEnabled == NO) {
        NSLog(@"定位服务不可用");
        return;
    }
}

- (void)getCurrentLocation {
    //    [self.locationManager startUpdatingLocation];
    [self.locationManager requestLocation];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations API_AVAILABLE(ios(6.0), macos(10.9)) {
    NSLog(@"%@",locations);
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
        [self.delegate locationManager:self didUpdateLocations:locations];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error = %@",error);
}

@end
