//
//  MainView.h
//  MapGrids
//
//  Created by Khurram Ali on 7/30/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMMapView.h"
#import "UTMGridManager.h"

@interface MainView : UIViewController {
    RMMapView *mapView;
    UTMGridManager *gridManager;
    
    // Manage button
    int       gridState;
    UIButton  *gridButton;
}

@property (nonatomic, strong) IBOutlet UIButton *gridButton;

- (IBAction)onGridButtonPressed:(id)sender;

@end
