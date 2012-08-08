//
//  DistanceGrid.h
//  MapGrids
//
//  Created by Khurram Ali on 8/9/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "RMPath.h"

#define DISTANCE_GRID_100M  100
#define DISTANCE_GRID_1KM   1000
#define DISTANCE_GRID_10KM  10000
#define DISTANCE_GRID_100KM 100000
#define DISTANCE_GRID_DESIRED_LINES 2
#define DISTANCE_GRID_MAX_LINES 10

@interface DistanceGrid : RMPath {
    float   gridDistance;
}

@end
