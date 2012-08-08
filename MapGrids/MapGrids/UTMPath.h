//
//  UTMPath.h
//  MapGrids
//
//  Created by Khurram Ali on 7/30/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "RMPath.h"

#define UTM_TOTAL_ZONES       60
#define UTM_ZONE_WIDTH        6
#define UTM_ZONE_START_LAT    84
#define UTM_ZONE_END_LAT      -80
#define UTM_EARTH_RADIUS      6371
#define UTM_COURSE_EAST       1.57079633

@interface UTMPath : RMPath

@end
