//
//  YLAnnotion.h
//  地图MapKit
//
//  Created by 余亮 on 16/2/19.
//  Copyright © 2016年 余亮. All rights reserved.
//

/**  
   自定义大头针
 */

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YLAnnotion : NSObject<MKAnnotation>

@property(nonatomic,assign)CLLocationCoordinate2D coordinate ;

@property(nonatomic,copy,nullable)NSString * title ;

@property(nonatomic,copy,nullable)NSString * subtitle ;

@property(nonatomic,assign)NSInteger type ;

@end
