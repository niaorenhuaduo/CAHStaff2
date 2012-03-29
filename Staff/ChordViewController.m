//
//  ChordViewController.m
//  COMP150ISWFinalProject
//
//  Created by Hu Huang on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ChordViewController.h"
#import "DraggedChord.h"
#import "ChordOptionsViewController.h"

@implementation ChordViewController

#define GROW_ANIMATION_DURATION_SECONDS 0.15    // Determines how fast a piece size grows when it is moved.
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15  // Determines how fast a piece size shrinks when a piece stops moving.

-(void) setUpChords:(NSArray*)theChords{
    [picker1  changeChordName:[[theChords objectAtIndex: 0] name]];
    [picker2  changeChordName:[[theChords objectAtIndex: 1] name]];
    [picker3  changeChordName:[[theChords objectAtIndex: 2] name]];
    [picker4  changeChordName:[[theChords objectAtIndex: 3] name]];
    [picker5  changeChordName:[[theChords objectAtIndex: 4] name]];
    [picker6  changeChordName:[[theChords objectAtIndex: 5] name]];
    [picker7  changeChordName:[[theChords objectAtIndex: 6] name]];
    [picker8  changeChordName:[[theChords objectAtIndex: 7] name]];
    
}

-(void) currentKey:(NSString *)newKey
{
   if (![newKey isEqualToString:@""])
   {
       currentKey = newKey;
   }
}

-(NSString *) currentKey
{
    return currentKey; 
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void) layoutChordPickers
{    
    // Coordinates are relative to the parent container
    picker1 = [[DraggedChord alloc] init];
    picker1.frame = CGRectMake(50, 550, 80, 80);
    
    picker2 = [[DraggedChord alloc] init];
    picker2.frame = CGRectMake(180, 550, 80, 80);
    
    picker3 = [[DraggedChord alloc] init];
    picker3.frame = CGRectMake(310, 550, 80, 80);
    
    picker4 = [[DraggedChord alloc] init];
    picker4.frame = CGRectMake(440, 550, 80, 80);
    
    picker5 = [[DraggedChord alloc] init];
    picker5.frame = CGRectMake(50, 650, 80, 80);
    
    picker6 = [[DraggedChord alloc] init];
    picker6.frame = CGRectMake(180, 650, 80, 80);
    
    picker7 = [[DraggedChord alloc] init];
    picker7.frame = CGRectMake(310, 650, 80, 80);
    
    picker8 = [[DraggedChord alloc] init];
    picker8.frame = CGRectMake(440, 650, 80, 80);
    
    if (self.view)
    {
        [self.view addSubview: picker1];
        [self.view addSubview: picker2];
        [self.view addSubview: picker3];
        [self.view addSubview: picker4];
        [self.view addSubview: picker5];
        [self.view addSubview: picker6];
        [self.view addSubview: picker7];
        [self.view addSubview: picker8];
    }
}


-(void) layoutChordsToBePlayed
{
    // Coordinates are relative to the parent container
    chordChosen1 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen1.frame = CGRectMake(50, 20, 80, 80);
    [chordChosen1 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen2 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen2.frame = CGRectMake(180, 20, 80, 80);
    [chordChosen2 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen3 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen3.frame = CGRectMake(310, 20, 80, 80);
    [chordChosen3 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen4 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen4.frame = CGRectMake(440, 20, 80, 80);
    [chordChosen4 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen5 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen5.frame = CGRectMake(50, 140, 80, 80);
    [chordChosen5 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen6 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen6.frame = CGRectMake(180, 140, 80, 80);
    [chordChosen6 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen7 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen7.frame = CGRectMake(310, 140, 80, 80);
    [chordChosen7 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    chordChosen8 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    chordChosen8.frame = CGRectMake(440, 140, 80, 80);
    [chordChosen8 addTarget:self action:@selector(chordChosen_onTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.view)
    {
        [self.view addSubview: chordChosen1];
        [self.view addSubview: chordChosen2];
        [self.view addSubview: chordChosen3];
        [self.view addSubview: chordChosen4];
        [self.view addSubview: chordChosen5];
        [self.view addSubview: chordChosen6];
        [self.view addSubview: chordChosen7];
        [self.view addSubview: chordChosen8];
    }    
}

-(void) layoutControlBar
{
    isPaused = TRUE;
    
    
    play = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    play.frame = CGRectMake(30, 340, 120, 90);
    [play setTitle:@"Play" forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playButton_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    stop = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    stop.frame = CGRectMake(160, 340, 120, 90);
    [stop setTitle:@"Stop" forState:UIControlStateNormal];
    [stop addTarget:self action:@selector(stopButton_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    clearAll = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    clearAll.frame = CGRectMake(290, 340, 120, 90);
    [clearAll setTitle:@"Clear All" forState:UIControlStateNormal];
    [clearAll addTarget:self action:@selector(clearButton_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    //    chordChosen4.frame = CGRectMake(640, 440, 80, 80);
    
    if (self.view)
    {
        [self.view addSubview: play];
        [self.view addSubview: stop];
        [self.view addSubview: clearAll];
    }    
}

- (void) loadView
{
    self.view = [[UIView alloc] initWithFrame: CGRectMake(400, 0, 624, 768)];
    [self.view setBackgroundColor:[UIColor brownColor]]; 
    
    [self layoutChordPickers];
    [self layoutChordsToBePlayed];
    [self layoutControlBar];
}

/*********************************************************
 The functions below implements drag and drop in the chord viewer
 *********************************************************/

// At touch begin, we will create a new instance of the dragged image and enlarge it
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Enumerate through all the touch objects.
	for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchFirstTouchAtPoint:[touch locationInView:self.view] forEvent:nil];
	}	 
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Enumerates through all touch object
	for (UITouch *touch in touches) {
		// Sends to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEndEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}   
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
		// Send to the dispatch method, which will make sure the appropriate subview is acted upon
		[self dispatchTouchEvent:[touch view] toPosition:[touch locationInView:self.view]];
	}  
}

// Moves the dragged chord around
-(void)dispatchTouchEvent:(UIView *)theView toPosition:(CGPoint)position
{
    draggedChord.center = position;
}

// Checks to see which view, or views,  the point is in and then calls a method to perform the closing animation,
// which is to return the piece to its original size, as if it is being put down by the user.
-(void)dispatchTouchEndEvent:(UIView *)theView toPosition:(CGPoint)position
{   
	// Check to see which view, or views,  the point is in and then animate to that position.
	if (CGRectContainsPoint([chordChosen1 frame], position)) {
		[chordChosen1 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen2 frame], position)) {
		[chordChosen2 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen3 frame], position)) {
		[chordChosen3 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen4 frame], position)) {
		[chordChosen4 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen5 frame], position)) {
		[chordChosen5 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen6 frame], position)) {
		[chordChosen6 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen7 frame], position)) {
		[chordChosen7 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    if (CGRectContainsPoint([chordChosen8 frame], position)) {
		[chordChosen8 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
	}
    // Now we must remove the dragged chord
    [draggedChord removeFromSuperview]; 
}


// Checks to see which view, or views, the point is in and then calls a method to perform the opening animation,
// which  makes the piece slightly larger, as if it is being picked up by the user.
-(void)dispatchFirstTouchAtPoint:(CGPoint)touchPoint forEvent:(UIEvent *)event
{
    draggedChord = [[DraggedChord alloc] init];
    
    BOOL touchIsInPicker = false;
    
	if (CGRectContainsPoint([picker1 frame], touchPoint)) {
        [draggedChord setFrame:[picker1 frame]];
        [draggedChord changeChordName:picker1.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker2 frame], touchPoint)) {
        [draggedChord setFrame:[picker2 frame]];
        [draggedChord changeChordName:picker2.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker3 frame], touchPoint)) {
        [draggedChord setFrame:[picker3 frame]];
        [draggedChord changeChordName:picker3.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker4 frame], touchPoint)) {
        [draggedChord setFrame:[picker4 frame]];
        [draggedChord changeChordName:picker4.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker5 frame], touchPoint)) {
        [draggedChord setFrame:[picker5 frame]];
        [draggedChord changeChordName:picker5.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker6 frame], touchPoint)) {
        [draggedChord setFrame:[picker6 frame]];
        [draggedChord changeChordName:picker6.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker7 frame], touchPoint)) {
        [draggedChord setFrame:[picker7 frame]];
        [draggedChord changeChordName:picker7.chordName];
        touchIsInPicker = true;
	}
    if (CGRectContainsPoint([picker8 frame], touchPoint)) {
        [draggedChord setFrame:[picker8 frame]];
        [draggedChord changeChordName:picker8.chordName];
        touchIsInPicker = true;
	}
    
    if (touchIsInPicker) {
        [self.view addSubview:draggedChord];
        [self animateFirstTouchAtPoint:touchPoint forView:draggedChord];
    }
}

/*********************************************************
 The functions below deals with animations
 *********************************************************/

// Scales up a view slightly which makes the piece slightly larger, as if it is being picked up by the user.
-(void)animateFirstTouchAtPoint:(CGPoint)touchPoint forView:(UIView *)theView
{
	// Pulse the view by scaling up, then move the view to under the finger.
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theView.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIView commitAnimations];
}

// Scales down the view and moves it to the new position. 
// TODO, need to modify this so for the chords picked
-(void)animateView:(UIView *)theView toPosition:(CGPoint)thePosition
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
	// Set the center to the final postion
	theView.center = thePosition;
	// Set the transform back to the identity, thus undoing the previous scaling effect.
	theView.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];	
}

-(void) clearButton_onTouchUpInside
{
    // Clear UI
    [chordChosen1 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen2 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen3 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen4 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen5 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen6 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen7 setTitle:@"" forState:UIControlStateNormal] ;
    [chordChosen8 setTitle:@"" forState:UIControlStateNormal] ;
    
    // Clear the data structure
}

// Hit it once, it pauses, hit it again it plays. Basically a toggle button
-(void) playButton_onTouchUpInside
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    if (isPaused) {
        [mainDelegate.viewController.dataController playChords];
        isPaused = FALSE;
        [play setTitle:@"Pause" forState:UIControlStateNormal];
    }
    else {
        [mainDelegate.viewController.dataController pauseChords];
        isPaused = TRUE;
        [play setTitle:@"Play" forState:UIControlStateNormal];
    }
}

-(void) stopButton_onTouchUpInside
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [mainDelegate.viewController.dataController stopChords];
}

// Once the user touches a chord chosen, present the popover view
// Todo need to send chords
-(void) chordChosen_onTouchUpInside:(id)sender
{
    ChordOptionsViewController *chordOptionsController = [[ChordOptionsViewController alloc] init];
    
    if (popOverController == nil) {
        UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:chordOptionsController];
    
        // Specifiying size
        popOver.popoverContentSize = CGSizeMake(200, 180);
        popOver.delegate = self;
        popOverController = popOver;
    }
    
    [popOverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:TRUE];
}
     


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
