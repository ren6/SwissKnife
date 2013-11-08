//
//  ThirdViewController.m
//  SwissKnife2
//
//  Created by renat on 08.11.13.
//  Copyright (c) 2013 renat. All rights reserved.
//

#import "ThirdViewController.h"
#import <MapKit/MapKit.h>
@interface ThirdViewController ()
@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation ThirdViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(20, 20, 280, 380)];
    [self.view insertSubview:self.mapView atIndex:0];
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MKMapTypeSatellite;
}
-(void) doSomtheinghWithMap{

}

@end
