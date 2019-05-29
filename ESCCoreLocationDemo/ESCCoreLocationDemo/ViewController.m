//
//  ViewController.m
//  ESCCoreLocationDemo
//
//  Created by xiang on 5/24/19.
//  Copyright © 2019 xiang. All rights reserved.
//

#import "ViewController.h"
#import "ESCLocationManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ESCAnnonation.h"


#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

@interface ViewController () <ESCLocationManagerDelegate, MKMapViewDelegate>

@property(nonatomic,strong)ESCLocationManager* locationManager;

@property(nonatomic,weak)MKMapView* mapView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[ESCLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager checkLocationAuthorizationState];
    
    [self.locationManager getCurrentLocation];
    
    MKMapView *mapView = [[MKMapView alloc] init];
    self.mapView = mapView;
    [self.view addSubview:self.mapView];
    self.mapView.frame = self.view.bounds;
    self.mapView.delegate = self;
    
    MKCoordinateRegion region = self.mapView.region;
    region.span.longitudeDelta = 0.05;
    region.span.latitudeDelta = 0.05;
    [self.mapView setRegion:region animated:YES];
    
}

#pragma mark - ESCLocationManagerDelegate
- (void)locationManager:(ESCLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    CLLocationCoordinate2D coor = location.coordinate;
    [self.mapView setCenterCoordinate:coor animated:YES];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil;
    
//    static NSString *defaultPinID = @"com.invasivecode.pin";
//    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//    if ( pinView == nil ) pinView = [[MKPinAnnotationView alloc]
//                                      initWithAnnotation:annotation reuseIdentifier:defaultPinID];
//    pinView.pinColor = MKPinAnnotationColorRed;
//    pinView.canShowCallout = YES;
//    pinView.animatesDrop = YES;
//    [mapView.userLocation setTitle:@"欧陆经典"];
//    [mapView.userLocation setSubtitle:@"vsp"];
//    return pinView;
    
    // 判断是否是当前自定义的大头针类
    if ([annotation isKindOfClass:[ESCAnnonation class]]) {
        // 先定义一个重用标识
        static NSString *identifier = @"Annotation";
        MKAnnotationView *annotationView =[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        // 重用机制
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            // 允许用户交互
            annotationView.canShowCallout = YES;
            // 设置详情和大头针的头偏移量
            annotationView.calloutOffset = CGPointMake(0, 1);
            // 设置详情的左视图
            annotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"88"]];
        }
        // 修改大头针视图
        annotationView.annotation = annotation;
        // 强转
        annotationView.image = ((ESCAnnonation *)annotation).image;
        return annotationView;
    } else {
        return nil;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.mapView];
    CLLocationCoordinate2D coor = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    NSLog(@"%lf===%lf",coor.latitude,coor.longitude);
    NSLog(@"%@",[NSThread currentThread]);
    //添加大头针
    ESCAnnonation *annonation = [[ESCAnnonation alloc] init];
    annonation.coordinate = coor;
    [self.mapView addAnnotation:annonation];
    
    
}

@end
