//
//  ZoomingRotationManiaAppDelegate.h
//  ZoomingRotationMania
//
//  Created by Jonathon Manning on 7/07/11.
//  Copyright 2011 Secret Lab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZoomingRotationManiaViewController;

@interface ZoomingRotationManiaAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ZoomingRotationManiaViewController *viewController;

@end
