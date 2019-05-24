//
//  ESCLocationManager.h
//  ESCCoreLocationDemo
//
//  Created by xiang on 5/24/19.
//  Copyright © 2019 xiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class ESCLocationManager;

NS_ASSUME_NONNULL_BEGIN

@protocol ESCLocationManagerDelegate <NSObject>

- (void)locationManager:(ESCLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations;

@end

@interface ESCLocationManager : NSObject

@property(nonatomic,weak)id delegate;

- (void)checkLocationAuthorizationState;

- (void)getCurrentLocation;

@end

NS_ASSUME_NONNULL_END
