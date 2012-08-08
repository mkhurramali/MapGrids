//
//  UTMPath.m
//  MapGrids
//
//  Created by Khurram Ali on 7/30/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "UTMPath.h"
#import "RMProjection.h"
#import "RMTransform.h"
#import "RMMapContents.h"
#import "RMMercatorToScreenProjection.h"

@implementation UTMPath

#define DEGREE_TO_RADIAN(x) ( (x / 180.0) * M_PI)
#define RADIAN_TO_DEGREE(x) ( (x * 180.0) / M_PI) 

#pragma mark - Point at a distance

/**
 * Next point at a distance on the given course (in radians from north).
 *
 * Reference: http://www.movable-type.co.uk/scripts/latlong.html
 */
- (RMLatLong)pointFrom:(RMLatLong)point course:(float)course distance:(float)distance {
    RMLatLong nextPoint;
    
    // Conversion to radian.
    point.latitude = DEGREE_TO_RADIAN( point.latitude );
    point.longitude = DEGREE_TO_RADIAN( point.longitude );
    
    // lat2 = asin(sin(lat1)*cos(d/R) + cos(lat1)*sin(d/R)*cos(θ))
    nextPoint.latitude = asin( ( sin( point.latitude ) * cos( distance / UTM_EARTH_RADIUS ) ) +
                               ( cos( point.latitude ) * sin( distance / UTM_EARTH_RADIUS ) * cos( course )));
    
    // lon2 = lon1 + atan2(sin(θ)*sin(d/R)*cos(lat1), cos(d/R)−sin(lat1)*sin(lat2))
    nextPoint.longitude = point.longitude + 
                atan2( sin( course ) * sin( distance / UTM_EARTH_RADIUS) * cos( point.latitude ) ,
                       cos( distance / UTM_EARTH_RADIUS ) - ( sin( point.latitude ) * sin( nextPoint.latitude ) ));
    
    // Conversion to degrees
    nextPoint.latitude = RADIAN_TO_DEGREE(nextPoint.latitude);
    nextPoint.longitude = RADIAN_TO_DEGREE(nextPoint.longitude);
    
    return nextPoint;
}

#pragma mark - Coordinate to UTM zone

- (int)coordinateToUTM:(CLLocationCoordinate2D)point {
    return floor(( point.longitude + 180 ) / 6.0);
}

#pragma mark - Initialization

/**
 * Initialize the UTMPath with all grids.
 */
-(id)initWithContents:(RMMapContents *)aContents {
    self = [super initWithContents:aContents];
    
    // If everything is good, add all grids.
    if ( self != nil ) {
        
        // Add all the zones. Move to the start line, then draw a line
        // to the bottom for the zone's beginning line. End line is just
        // beginning line of next zone. We start from the last zone.
        for ( int i = UTM_TOTAL_ZONES; i > 0; i-- ) {
            RMLatLong zoneStart;
            zoneStart.latitude = UTM_ZONE_START_LAT;
            zoneStart.longitude = kMaxLong - ((UTM_TOTAL_ZONES - i) * UTM_ZONE_WIDTH);
            
            RMLatLong zoneEnd;
            zoneEnd.latitude = UTM_ZONE_END_LAT;
            zoneEnd.longitude = kMaxLong - ((UTM_TOTAL_ZONES - i) * UTM_ZONE_WIDTH);
            
            [self moveToLatLong:zoneStart];
            [self addLineToLatLong:zoneEnd];
        }
    }
    
    return self;
}

@end
