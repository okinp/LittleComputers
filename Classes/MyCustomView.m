//
//  MyCustomView.m
//  redSquare
//
//  Created by Nikolas Psaroudakis on 2/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyCustomView.h"

#define kAccelerometerFrequency        10 //Hz

@implementation MyCustomView

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
	}
	return self;
}

- (void) awakeFromNib
{
	// you have to initialize your view here since it's getting
	// instantiated by the nib
	squareSize = 100.0f;
	twoFingers = NO;
	rotation = 0.5f;
	// Get screen bounds
	rect = [[UIScreen mainScreen] bounds];
	//Initialize position
	centerx =rect.size.width/2;
	centery =rect.size.height/2;
	// You have to explicity turn on multitouch for the view
	self.multipleTouchEnabled = YES;
	
	// configure for accelerometer
	[self configureAccelerometer];
}

-(void)configureAccelerometer
{
	UIAccelerometer*  theAccelerometer = [UIAccelerometer sharedAccelerometer];
	
	if(theAccelerometer)
	{
		theAccelerometer.updateInterval = 1 / kAccelerometerFrequency;
		theAccelerometer.delegate = self;
	}
	else
	{
		NSLog(@"Oops we're not running on the device!");
	}
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
	UIAccelerationValue x, y, z;
	x = acceleration.x;
	y = acceleration.y;
	z = acceleration.z;
	
	// Do something with the values.
	xField.text = [NSString stringWithFormat:@"%.5f", x];
	yField.text = [NSString stringWithFormat:@"%.5f", y];
	zField.text = [NSString stringWithFormat:@"%.5f", z];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches began count %d, %@", [touches count], touches);
	if([touches count] >1 )
	{
		twoFingers = YES;
		//Get all the touches.
		NSSet *allTouches = [event allTouches];
		//Get the first touch.
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		//Get the second touch.
		UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
		CGFloat dx = [touch2 locationInView:self].x-[touch1	locationInView:self].x;
		CGFloat dy = [touch2 locationInView:self].y-[touch1	locationInView:self].y;
		NSLog(@"The differece x,y is: %f, %f",dx,dy);
		CGFloat myAngle= atan(dy/dx);
		rotation=myAngle;
		//Lets bring the rectangle to the midpoint of the the two touch points
		centerx=[touch2 locationInView:self].x/2+[touch1	locationInView:self].x/2;
		centery=[touch2 locationInView:self].y/2+[touch1	locationInView:self].y/2;

		
	} else {
		twoFingers =NO;
		NSSet *allTouches = [event allTouches];
		//Get the first touch.
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		//translate rectangle
		centerx = [touch1 locationInView:self].x;
		centery = [touch1 locationInView:self].y;
	}

	
	// tell the view to redraw
	[self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
	NSLog(@"touches moved count %d, %@", [touches count], touches);
	if ([touches count] <=1){
		twoFingers= NO;
		NSSet *allTouches = [event allTouches];
		//Get the first touch.
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		//translate rectangle on move
		centerx = [touch1 locationInView:self].x;
		centery = [touch1 locationInView:self].y;
	} else {
		twoFingers = YES;
		//Get all the touches.
		NSSet *allTouches = [event allTouches];
		//Get the first touch.
		UITouch *touch1 = [[allTouches allObjects] objectAtIndex:0];
		//Get the second touch.
		UITouch *touch2 = [[allTouches allObjects] objectAtIndex:1];
		CGFloat dx = [touch2 locationInView:self].x-[touch1	locationInView:self].x;
		CGFloat dy = [touch2 locationInView:self].y-[touch1	locationInView:self].y;
		NSLog(@"The differece x,y is: %f, %f",dx,dy);
		CGFloat myAngle= atan(dy/dx);
		rotation=myAngle;
		//Lets bring the rectangle to the midpoint of the the two touch points
		centerx=[touch2 locationInView:self].x/2+[touch1	locationInView:self].x/2;
		centery=[touch2 locationInView:self].y/2+[touch1	locationInView:self].y/2;
	}

	// tell the view to redraw
	[self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"touches moved count %d, %@", [touches count], touches);
	
	// reset the var
	twoFingers = NO;
	
	// tell the view to redraw
	[self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect
{
	NSLog(@"drawRect");
	
	//CGFloat centerx = centerx+rect.size.width/2;
	//CGFloat centery = rect.size.height/2;
	CGFloat half = squareSize/2;
	CGRect theRect = CGRectMake(-half, -half, squareSize, squareSize);
	
	// Grab the drawing context
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// like Processing pushMatrix
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, centerx, centery);
	
	// Uncomment to see the rotated square
	CGContextRotateCTM(context, rotation);
	
	// Set red stroke
	CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
	
	// Set different based on multitouch
	if(!twoFingers)
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 0.0, 1.0);
	}
	else
	{
		CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1.0);
	}
	
	// Draw a rect with a red stroke
	CGContextFillRect(context, theRect);
	CGContextStrokeRect(context, theRect);
	
	// like Processing popMatrix
	CGContextRestoreGState(context);
}

- (void) dealloc
{
	[super dealloc];
}

@end