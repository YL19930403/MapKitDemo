
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


@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager * locationM ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.mapView.mapType = MKMapTypeHybridFlyover ;
//    self.mapView.zoomEnabled = NO ;
//    self.mapView.showsCompass = NO;
    //比例尺
    self.mapView.showsScale = YES ;
    //显示建筑物
//    self.mapView.showsBuildings = YES ;
    [self locationM];
    //请求获取用户位置，需要授权（导入CoreLocation框架）
    self.mapView.showsUserLocation = YES ;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading ;
}

#pragma  mark - MKMapViewDelegate
- (void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
      /**
        MKUserLocation (大头针模型)
       */
    userLocation.title = @"你猜你猜你猜猜猜";
    userLocation.subtitle = @"去找百度地图";
   
    //设置地图显示中心
    [self.mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    //设置地图显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(0.051109, 0.034153);
    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [self.mapView setRegion:region animated:YES];
    
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
   NSLog(@"%f----%f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}

- (CLLocationManager *)locationM
{
    if (!_locationM) {
        _locationM = [[CLLocationManager alloc] init];
        if ([_locationM respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            //需要在info.plist 里面配置NSLocationAlwaysUsageDescription
            [_locationM requestAlwaysAuthorization];
        }
        
    }
    return _locationM ;
}


@end

















