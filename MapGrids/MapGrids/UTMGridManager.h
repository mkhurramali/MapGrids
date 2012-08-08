//
//  UTMGridManager.h
//  MapGrids
//
//  Created by Khurram Ali on 8/9/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMMapViewDelegate.h"
#import "RMMapView.h"
#import "RMLayerCollection.h"
#import "UTMPath.h"
#import "MGRSPath.h"
#import "CentralMeridian.h"
#import "DistanceGrid.h"

// Grid types.
#define GRID_MANAGER_NO_GRID   0
#define GRID_MANAGER_UTM_GRID  1
#define GRID_MANAGER_MGRS_GRID 2

@interface UTMGridManager : NSObject <RMMapViewDelegate> {
    RMMapView *mapView;
    UTMPath   *utm;
    MGRSPath  *mgrs;
    CentralMeridian *meridian;
    DistanceGrid *distance;
    
    // Look customization.
    UIColor   *gridColor;
    UIColor   *meridianColor;
    UIColor   *distanceColor;
    
    // Current grid type
    int       gridType;
}

@property (nonatomic, strong) UIColor *gridColor;
@property (nonatomic, strong) UIColor *meridianColor;
@property (nonatomic, strong) UIColor *distanceColor;

- (id)initWithMapView:(RMMapView *)mapView;
- (void)setGridType:(int)type;

@end
