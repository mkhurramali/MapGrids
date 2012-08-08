//
//  UTMGridManager.m
//  MapGrids
//
//  Created by Khurram Ali on 8/9/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "UTMGridManager.h"

@implementation UTMGridManager
@synthesize gridColor;
@synthesize meridianColor;
@synthesize distanceColor;

#pragma mark - Mapping delegate

- (void)updateDistanceGrid:(RMMapView *)map {
    if ( gridType > GRID_MANAGER_NO_GRID ) {
        [[map.contents overlay] removeSublayer:distance];
        
        // Add a new distance grid.
        distance = [[DistanceGrid alloc] initForMap:mapView];
        [distance setLineColor:distanceColor];
        [distance setLineWidth:1];
        [[mapView.contents overlay] addSublayer:distance];
    }
}

- (void) afterMapMove: (RMMapView*) map {
    [self updateDistanceGrid:map];
}

- (void) afterMapZoom: (RMMapView*) map byFactor: (float) zoomFactor near:(CGPoint) center {
    [self updateDistanceGrid:map];
}

#pragma mark - Manage grid type

/**
 * Let the grid manager know which grid type to show.
 */
- (void)setGridType:(int)type {
    
    // Remove previously added grid.
    switch ( gridType ) {
        case GRID_MANAGER_MGRS_GRID:
            [[mapView.contents overlay] removeSublayer:mgrs];
        case GRID_MANAGER_UTM_GRID:
            [[mapView.contents overlay] removeSublayer:utm];
            [[mapView.contents overlay] removeSublayer:meridian];
            [[mapView.contents overlay] removeSublayer:distance];
            break;
    }
    
    // Update button title.
    switch ( type ) {
            
        case GRID_MANAGER_MGRS_GRID:
            
            // MGRS grids. Only initialize the first time we load path.
            if ( mgrs == nil ) {
                mgrs = [[MGRSPath alloc] initForMap:mapView];
                [mgrs setLineColor:gridColor];
                [mgrs setLineWidth:1];
            }
            
            [[mapView.contents overlay] addSublayer:mgrs];
            
        case GRID_MANAGER_UTM_GRID:
             
            // UTM Zone. Only initialize the first time we load path.
            if ( utm == nil ) {
                utm = [[UTMPath alloc] initForMap:mapView];
                [utm setLineColor:gridColor];
                [utm setLineWidth:1];
            }
             
            [[mapView.contents overlay] addSublayer:utm];
            
            // Meridian for the zones.
            if ( meridian == nil ) {
                meridian = [[CentralMeridian alloc] initForMap:mapView];
                [meridian setLineColor:meridianColor];
                [meridian setLineWidth:1];
            }
            
            [[mapView.contents overlay] addSublayer:meridian];
            
            // Distance grid.
            distance = [[DistanceGrid alloc] initForMap:mapView];
            [distance setLineColor:distanceColor];
            [distance setLineWidth:1];
            [[mapView.contents overlay] addSublayer:distance];
             
            break;
    }
    
    // Update the current grid type.
    gridType = type;
}

#pragma mark - Initialization

/**
 * Initialize the grid with given mapview.
 */
- (id)initWithMapView:(RMMapView *)map {
    if ( ( self = [super init]) ) {
        mapView = map;
        gridColor = [UIColor orangeColor];
        meridianColor = [UIColor yellowColor];
        distanceColor = [UIColor greenColor];
    }
    
    return self;
}


@end
