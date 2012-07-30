//
//  MainView.m
//  MapGrids
//
//  Created by Khurram Ali on 7/30/12.
//  Copyright (c) 2012 RIKSOF. All rights reserved.
//

#import "MainView.h"
#import "RMLayerCollection.h"

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
    
    // Update button title.
    switch (gridState) {
        case NO_GRID:
            [gridButton setTitle:@"None" forState:UIControlStateNormal];
            break;
        
        case UTM_GRID:
            [gridButton setTitle:@"UTM Grid" forState:UIControlStateNormal];
            
            // UTM Zone. Only initialize the first time we load path.
            if ( utm == nil ) {
                utm = [[UTMPath alloc] initForMap:mapView];
                [utm setLineColor:[UIColor whiteColor]];
                [utm setLineWidth:2];
            }
            
            [[mapView.contents overlay] addSublayer:utm];
            
            break;
            
        case MGRS_GRID:
            [gridButton setTitle:@"MGRS Grid" forState:UIControlStateNormal];
            
            // Remove utm zone.
            [[mapView.contents overlay] removeSublayer:utm];
            
            break;
            
        default:
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
