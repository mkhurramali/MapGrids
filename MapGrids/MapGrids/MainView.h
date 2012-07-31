//
//  MainView.h
//  MapGrids
//
//  Created by Khurram Ali on 7/30/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"
#import "UTMPath.h"
#import "MGRSPath.h"

#define NO_GRID   0
#define UTM_GRID  1
#define MGRS_GRID 2

@interface MainView : UIViewController {
    RMMapView *mapView;
    UTMPath   *utm;
    MGRSPath  *mgrs;
    
    // Manage button
    int       gridState;
    UIButton  *gridButton;
}

@property (nonatomic, strong) IBOutlet UIButton *gridButton;

- (IBAction)onGridButtonPressed:(id)sender;

@end
