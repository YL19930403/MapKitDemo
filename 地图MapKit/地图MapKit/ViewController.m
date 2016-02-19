
//
//  ViewController.m
//  地图MapKit
//
//  Created by 余亮 on 16/2/19.
//  Copyright © 2016年 余亮. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "YLAnnotion.h"


@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager * locationM ;
@property(nonatomic,strong)CLGeocoder * geoC ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //1.获取当前触摸点
    CGPoint point = [[touches anyObject] locationInView:self.mapView];
    //2.转换为经纬度
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    //3.添加大头针
    [self convertCoordinateWithPoint:coordinate];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //移除大头针
    NSArray * annos = self.mapView.annotations ;  //annotations存放着地图上所有的大头针
    [self.mapView removeAnnotations:annos];
}

#pragma mark - 地图某一点 转  经纬度
- (void)convertCoordinateWithPoint:(CLLocationCoordinate2D)point
{
    /**
     MKUserLocation (大头针模型)
     */
    YLAnnotion * anno = [[YLAnnotion alloc] init];
    anno.coordinate = point ;
    anno.title = @"你猜你猜";
    anno.subtitle = @"我猜不出";
    [self.mapView addAnnotation:anno];
    
    //根据大头针所在经纬度，通过反地理编码求出所在的城市,街道
    CLLocation * location = [[CLLocation alloc] initWithLatitude:anno.coordinate.latitude longitude:anno.coordinate.longitude];
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //地标对象
        CLPlacemark * placeMark = [placemarks firstObject];
        anno.subtitle = placeMark.locality ;
        anno.title = placeMark.country ;
        NSLog(@"%@",placeMark.country);
        NSLog(@"%@",placeMark.locality);
        
    }];
    //添加多个大头针
//    [self.mapView addAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#>]
}

#pragma  mark - MKMapViewDelegate
- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}


/**
 *  当添加大头针时会调用这个代理方法
 *  注意：如果返回值为nil，则会调用系统自身的某个方法
 */
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return nil;
}

- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC ;
}

@end

















