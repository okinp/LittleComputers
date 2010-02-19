//
//  redSquareAppDelegate.h
//  redSquare
//
//  Created by Nikolas Psaroudakis on 2/19/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class redSquareViewController;

@interface redSquareAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    redSquareViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet redSquareViewController *viewController;

@end

