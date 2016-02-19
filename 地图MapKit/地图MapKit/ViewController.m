
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
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.获取当前触摸点
    CGPoint point = [[touches anyObject] locationInView:self.mapView];
    //2.转换为经纬度
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    //3.添加大头针
    [self convertCoordinateWithPoint:coordinate];
}

#pragma mark  -  拖拽的时候移除大头针
//- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    NSArray * annos = self.mapView.annotations ;  //annotations存放着地图上所有的大头针
//    [self.mapView removeAnnotations:annos];
//}

#pragma mark - 地图某一点 转  经纬度
- (void)convertCoordinateWithPoint:(CLLocationCoordinate2D)point
{
    /**
     MKUserLocation (大头针模型)
     */
    __block YLAnnotion * anno = [[YLAnnotion alloc] init];
    anno.coordinate = point ;
    anno.title = @"你猜你猜";
    anno.subtitle = @"我猜不出";
    anno.type = arc4random_uniform(5) ;//生成0-4之间的随机数

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
//    return nil;
    /**
        MKPinAnnotationView 为系统自带的大头针样式
     */
    /*
    static NSString * identifier = @"MKpinAnnotation";
    MKPinAnnotationView * pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    pin.annotation = annotation ;
    
    //设置是否弹出标注
    pin.canShowCallout = YES ;
    
    //设置大头针颜色
    pin.pinTintColor = [UIColor orangeColor];
    
    //设置大头针显示效果
    pin.animatesDrop = YES ;
    
    //设置大头针可以拖拽效果
    pin.draggable = YES ;   //按住control键再拖动
    return  pin ;
    */
    
    
    /**
       自定义大头针
     */
    static NSString * identifier = @"MKCustomAnnotation";
    MKAnnotationView * CustomAnno = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (CustomAnno == nil) {
        CustomAnno = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    CustomAnno.canShowCallout = YES ;
    CustomAnno.annotation = annotation ;
    CustomAnno.draggable = YES ;
    //设置大头针顶部弹出view的偏移量
    CustomAnno.calloutOffset = CGPointMake(5, 10);
    YLAnnotion * YLAnno = (YLAnnotion *)annotation ;
    NSString * imageName = [NSString stringWithFormat:@"category_%zd",YLAnno.type+1];
    CustomAnno.image = [UIImage imageNamed:imageName];
    
    //设置大头针顶部左边的image
    UIImageView * leftImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    leftImgV.image = [UIImage imageNamed:@"htl"];
    CustomAnno.leftCalloutAccessoryView = leftImgV ;
    
    //设置大头针顶部右边的image
    UIImageView * rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    rightImgV.image = [UIImage imageNamed:@"eason"];
    CustomAnno.rightCalloutAccessoryView = rightImgV ;
    
    CustomAnno.detailCalloutAccessoryView = [[UISwitch alloc] init];
    return  CustomAnno ;
}

- (CLGeocoder *)geoC
{
    if (!_geoC) {
        _geoC = [[CLGeocoder alloc] init];
    }
    return _geoC ;
}

@end

















