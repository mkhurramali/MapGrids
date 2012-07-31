//
//  MGRSPath.m
//  MapGrids
//
//  Created by Khurram Ali on 7/31/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "MGRSPath.h"

@implementation MGRSPath

#pragma mark - Initialization

/**
 * Initialize the MGRS with all grids.
 */
-(id)initWithContents:(RMMapContents *)aContents {
    self = [super initWithContents:aContents];
    
    // If everything is good, add all grids. Longitude lines have already
    // been added.
    if ( self != nil ) {
        
        // Move to the start line, then draw a line
        for ( int i = MGRS_TOTAL_HORIZONTAL_LINES; i > 0; i-- ) {
            RMLatLong zoneStart;
            zoneStart.latitude = MGRS_START_LAT - ((MGRS_TOTAL_HORIZONTAL_LINES - i) * MGRS_ZONE_HEIGHT);
            zoneStart.longitude = kMaxLong;
            
            RMLatLong zoneEnd;
            zoneEnd.latitude = MGRS_START_LAT - ((MGRS_TOTAL_HORIZONTAL_LINES - i) * MGRS_ZONE_HEIGHT);
            zoneEnd.longitude = -1 * kMaxLong;
            
            [self moveToLatLong:zoneStart];
            [self addLineToLatLong:zoneEnd];
        }
    }
    
    return self;
}

@end
