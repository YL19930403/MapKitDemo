
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


@interface ViewController ()
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
    self.mapView.showsCompass = NO;
    //比例尺
    self.mapView.showsScale = YES ;
    //显示建筑物
    self.mapView.showsBuildings = YES ;
    [self locationM];
    //请求获取用户位置，需要授权（导入CoreLocation框架）
    self.mapView.showsUserLocation = YES ;
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading ;
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

















