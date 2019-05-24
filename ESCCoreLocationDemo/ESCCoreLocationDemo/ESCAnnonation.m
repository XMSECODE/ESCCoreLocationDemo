//
//  ESCAnnonation.m
//  ESCCoreLocationDemo
//
//  Created by xiang on 5/24/19.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "ESCAnnonation.h"

@interface ESCAnnonation ()

@end

@implementation ESCAnnonation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"f";
        self.subtitle = @"x";
        self.image = [UIImage imageNamed:@"timg"];
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(10_9, 4_0) {
    
}

@end
