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
    //	[[mapView contents] setZoom:10.0];
	[mapView setBackgroundColor:[UIColor greenColor]];
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
