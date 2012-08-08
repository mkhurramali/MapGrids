//
//  DistanceGrid.m
//  MapGrids
//
//  Created by Khurram Ali on 8/9/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "DistanceGrid.h"
#import "RMMapContents.h"

@implementation DistanceGrid

#pragma mark - Initialization

/**
 * Initialize the distance grids for current screen.
 */
-(id)initWithContents:(RMMapContents *)aContents {
    self = [super initWithContents:aContents];
    
    // If everything is good, add all grids.
    if ( self != nil ) {
        
        // Determine the screen to meters ratio and therefore the grid we need
        // to show.
        float metersPerPixel = [aContents metersPerPixel];
        
        // Get the screen size.
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        // How many meters can we show?
        float metersOnScreen = metersPerPixel * screenWidth;
        
        // Will we get enough grid lines for the 100 KM grid?
        if ( metersOnScreen / DISTANCE_GRID_100KM >= DISTANCE_GRID_DESIRED_LINES ) {
            gridDistance = DISTANCE_GRID_100KM;
        } else if ( metersOnScreen / DISTANCE_GRID_10KM >= DISTANCE_GRID_DESIRED_LINES ) {
            gridDistance = DISTANCE_GRID_10KM;
        } else if ( metersOnScreen / DISTANCE_GRID_1KM >= DISTANCE_GRID_DESIRED_LINES ) {
            gridDistance = DISTANCE_GRID_1KM;
        } else {
            gridDistance = DISTANCE_GRID_100M;
        }
        
        // Make sure we do not have more than max desired lines for the large distance.
        if ( gridDistance != DISTANCE_GRID_100KM || metersOnScreen / gridDistance <= DISTANCE_GRID_MAX_LINES ) { 
        
            // Add the center line
            CGPoint start = CGPointMake( screenWidth / 2, 0);
            CGPoint end = CGPointMake(screenWidth / 2, screenHeight);
        
            [self moveToScreenPoint:start];
            [self addLineToScreenPoint:end];
        
            // Starting from the center, add all grid lines.
            for ( int i = gridDistance / metersPerPixel; i <= (screenWidth / 2); i += (gridDistance / metersPerPixel) ) {
                // Right line
                start = CGPointMake( (screenWidth / 2) + i, 0);
                end = CGPointMake( (screenWidth / 2) + i, screenHeight);
            
                [self moveToScreenPoint:start];
                [self addLineToScreenPoint:end];
            
                // Left line.
                start = CGPointMake( (screenWidth / 2) - i, 0);
                end = CGPointMake( (screenWidth / 2) - i, screenHeight);
            
                [self moveToScreenPoint:start];
                [self addLineToScreenPoint:end];
            }
        }
    }
    return self;
}

@end
