//
//  MainView.m
//  MapGrids
//
//  Created by Khurram Ali on 7/30/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "MainView.h"

@interface MainView ()

@end

@implementation MainView

@synthesize gridButton;

#pragma mark - Grid Button Handling

/**
 * Switch between grids.
 */
- (IBAction)onGridButtonPressed:(id)sender {
    // Next state for grid.
    gridState = (gridState + 1) % 3;
    
    // Set the grid type
    [gridManager setGridType:gridState];
    
    // Update button title.
    switch (gridState) {
        case GRID_MANAGER_NO_GRID:
            [gridButton setTitle:@"None" forState:UIControlStateNormal];
            break;
        
        case GRID_MANAGER_UTM_GRID:
            [gridButton setTitle:@"UTM Grid" forState:UIControlStateNormal];
            break;
            
        case GRID_MANAGER_MGRS_GRID:
            [gridButton setTitle:@"MGRS Grid" forState:UIControlStateNormal];
            break;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CLLocationCoordinate2D firstLocation;
	firstLocation.latitude = 51.2795;
	firstLocation.longitude = 1.082;
	mapView = [[RMMapView alloc] initWithFrame:CGRectMake(0,0,320,420)
										WithLocation:firstLocation];
    
    [[mapView contents] setZoom:4.0];
	[[self view] addSubview:mapView];
	[[self view] sendSubviewToBack:mapView];
    
    // Set up the grid manager and make it the delegate for this map.
    gridManager = [[UTMGridManager alloc] initWithMapView:mapView];
    mapView.delegate = gridManager;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
