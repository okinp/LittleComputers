//
//  MyCustomView.h
//  redSquare
//
//  Created by Nikolas Psaroudakis on 2/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomView : UIView <UIAccelerometerDelegate>
{
	CGFloat                    squareSize;
	CGFloat                    rotation;
	CGColorRef                 aColor;
	BOOL                       twoFingers;
	CGFloat					   centerx;
	CGFloat					   centery;
	
	IBOutlet UILabel           *xField;
	IBOutlet UILabel           *yField;
	IBOutlet UILabel           *zField;
	CGRect rect;
}
-(void) configureAccelerometer;
@end
