//
//  redSquareAppDelegate.m
//  redSquare
//
//  Created by Nikolas Psaroudakis on 2/19/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "redSquareAppDelegate.h"
#import "redSquareViewController.h"

@implementation redSquareAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
