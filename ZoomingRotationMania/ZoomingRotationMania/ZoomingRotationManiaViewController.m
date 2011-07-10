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
    
    pinch.delegate = self;
    rotation.delegate = self;
    
    zoomingRotationViewScale = 1.0;
}

- (void) pinched:(UIPinchGestureRecognizer*)pinch {
    if (pinch.state == UIGestureRecognizerStateChanged) {
        CGAffineTransform currentTransform = zoomingRotationView.transform;
        CGFloat rotation = atan2f(currentTransform.b, currentTransform.a);
        CGAffineTransform newTransform = CGAffineTransformMakeRotation(rotation);

        CGFloat newScale = zoomingRotationViewScale * pinch.scale;
        newTransform = CGAffineTransformScale(newTransform, newScale, newScale);
        zoomingRotationView.transform = newTransform;
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    if (([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] || 
        [gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) &&
        ([otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] || 
         [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]])) {
        return YES;
    }
    return NO;
    
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
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

@end
