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
    region.span.longitudeDelta = 0.5;
    region.span.latitudeDelta = 0.5;
    [self.mapView setRegion:region animated:YES];

}

#pragma mark - ESCLocationManagerDelegate
- (void)locationManager:(ESCLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *location = locations.firstObject;
    CLLocationCoordinate2D coor = location.coordinate;
    [self.mapView setCenterCoordinate:coor animated:YES];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    DLog(@"%@",view);
}

- (void)mapView:(MKMapView *)mapView annotationView:(nonnull MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState {
    DLog(@"%@",view);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.mapView];
    CLLocationCoordinate2D coor = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    NSLog(@"%lf===%lf",coor.latitude,coor.longitude);
}

@end
