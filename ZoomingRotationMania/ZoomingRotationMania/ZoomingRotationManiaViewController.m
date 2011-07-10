//
//  ZoomingRotationManiaViewController.m
//  ZoomingRotationMania
//
//  Created by Jonathon Manning on 7/07/11.
//  Copyright 2011 Secret Lab. All rights reserved.
//

#import "ZoomingRotationManiaViewController.h"

@implementation ZoomingRotationManiaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPinchGestureRecognizer* pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinched:)];
    [zoomingRotationView addGestureRecognizer:pinch];
    [pinch release];
    
    UIRotationGestureRecognizer* rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotated:)];
    [zoomingRotationView addGestureRecognizer:rotation];
    [rotation release];
    
    zoomingRotationViewScale = 1.0;
}

- (void) pinched:(UIPinchGestureRecognizer*)pinch {
    if (pinch.state == UIGestureRecognizerStateChanged) {
        CGFloat newScale = zoomingRotationViewScale * pinch.scale;
        CGAffineTransform transform = CGAffineTransformMakeScale(newScale, newScale);
        zoomingRotationView.transform = transform;
    }
    if (pinch.state == UIGestureRecognizerStateEnded || pinch.state == UIGestureRecognizerStateCancelled) {
        zoomingRotationViewScale *= pinch.scale;
    }
}

- (void) rotated:(UIRotationGestureRecognizer*) rotation {
    if (rotation.state == UIGestureRecognizerStateChanged) {
        CGFloat rotationAmount = [rotation rotation];
        CGAffineTransform transform  = zoomingRotationView.transform;
        transform = CGAffineTransformRotate(transform, rotationAmount);
        rotation.rotation = 0;
        zoomingRotationView.transform = transform;
    }
}

- (void)dealloc
{
    [zoomingRotationView release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [zoomingRotationView release];
    zoomingRotationView = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
