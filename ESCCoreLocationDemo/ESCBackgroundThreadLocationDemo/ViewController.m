//
//  ViewController.m
//  ESCBackgroundThreadLocationDemo
//
//  Created by xiatian on 2024/1/3.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager* locationManager;

@property(nonatomic,strong)NSThread* locationThread;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationThread = [[NSThread alloc] initWithTarget:self selector:@selector(initLocationManager) object:nil];
    
//    [self initLocationManager];
    
    [self.locationThread start];
}

- (void)initLocationManager {
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    NSLog(@"%@",[NSThread currentThread]);
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.distanceFilter = 2;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
    NSPort *port = [[NSPort alloc] init];
    [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

   
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations API_AVAILABLE(ios(6.0), macos(10.9)) {
    NSLog(@"%@",[NSThread currentThread]);

    NSLog(@"didUpdateLocations %@",locations);
//
//        [self.locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading API_AVAILABLE(ios(3.0), macos(10.15), watchos(2.0)) API_UNAVAILABLE(tvos) {
    NSLog(@"%@",[NSThread currentThread]);

    NSLog(@"didUpdateHeading %@",newHeading);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@",[NSThread currentThread]);

    NSLog(@"didFailWithError %@",error);
}
@end
