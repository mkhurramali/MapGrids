//
//  CentralMeridian.m
//  MapGrids
//
//  Created by Khurram Ali on 8/9/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "CentralMeridian.h"

@implementation CentralMeridian

#pragma mark - Initialization

/**
 * Initialize the meridian lines for all zones.
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
            zoneStart.longitude = kMaxLong - ((UTM_TOTAL_ZONES - i) * UTM_ZONE_WIDTH) - (UTM_ZONE_WIDTH / 2);
            
            RMLatLong zoneEnd;
            zoneEnd.latitude = UTM_ZONE_END_LAT;
            zoneEnd.longitude = kMaxLong - ((UTM_TOTAL_ZONES - i) * UTM_ZONE_WIDTH) - (UTM_ZONE_WIDTH / 2);
            
            [self moveToLatLong:zoneStart];
            [self addLineToLatLong:zoneEnd];
        }
    }
    
    return self;
}

@end
