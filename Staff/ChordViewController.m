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
#import "DataController.h"
#import "Circleof5thsController.h"
#import "TwoFingerOptionSelector.h"

@implementation ChordViewController

@synthesize bpmStepper;
@synthesize bpmLabel;
@synthesize metronomeOnOff;
@synthesize metronomeTimer;

#define GROW_ANIMATION_DURATION_SECONDS 0.15    // Determines how fast a piece size grows when it is moved.
#define SHRINK_ANIMATION_DURATION_SECONDS 0.15  // Determines how fast a piece size shrinks when a piece stops moving.

-(void) setUpChords:(NSArray*)theChords{
    
    chordChoices = [[NSMutableArray alloc] initWithArray:theChords];

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
    
    pickerArray = [[NSArray alloc] initWithObjects:picker1, picker2, picker3, picker4, picker5, picker6, picker7, picker8, nil];
    
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
    //chordChosen1.titleLabel.font  = [UIFont systemFontOfSize:10];
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
    
    chordsToBePlayed = [[NSMutableArray alloc] initWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", nil];
    chosenChordButtonsArray = [[NSArray alloc] initWithObjects:chordChosen1, chordChosen2, chordChosen3, chordChosen4, chordChosen5, chordChosen6, chordChosen7, chordChosen8, nil];
    
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
    stop.adjustsImageWhenDisabled = TRUE;
    
    clearAll = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    clearAll.frame = CGRectMake(290, 340, 120, 90);
    [clearAll setTitle:@"Clear All" forState:UIControlStateNormal];
    [clearAll addTarget:self action:@selector(clearButton_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.view)
    {
        [self.view addSubview: play];
        [self.view addSubview: stop];
        [self.view addSubview: clearAll];
    }    
}

-(void) layoutStars
{
    starImage = [UIImage imageNamed:@"star.png"];
    
    star1 = [[UIImageView alloc] initWithImage:starImage];
    [star1 setFrame:CGRectMake(30, 280, 40, 40)];
    
    star2 = [[UIImageView alloc] initWithImage:starImage];
    [star2 setFrame:CGRectMake(80, 280, 40, 40)];
    
    star3 = [[UIImageView alloc] initWithImage:starImage];
    [star3 setFrame:CGRectMake(130, 280, 40, 40)];
    
    star4 = [[UIImageView alloc] initWithImage:starImage];
    [star4 setFrame:CGRectMake(180, 280, 40, 40)];
    
    starsHaveAppeared = FALSE;
}

- (void) loadView
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    self.view = [[UIView alloc] initWithFrame: CGRectMake(400, 0, 624, 768)];
    [self.view setBackgroundColor:[UIColor brownColor]]; 
    
    [self layoutChordPickers];
    [self layoutChordsToBePlayed];
    [self layoutControlBar];
    [self layoutStars];
    [self setupMetronome];
    [mainDelegate.viewController.circleOf5thsController setup];
    //[mainDelegate.viewController.twoFingerOptionSelector setup];
}


/*********************************************************
 The functions below implements the metronome
 *********************************************************/

- (void) setupMetronome
{
    bpmStepper = [[UIStepper alloc] initWithFrame:CGRectMake(433, 332, 100, 30)];
    [bpmStepper setMinimumValue:20.0];
    [bpmStepper setMaximumValue:160.0];
    [bpmStepper setValue:80.0];
    [bpmStepper setStepValue:1];
    [bpmStepper setContinuous:YES];
    [bpmStepper setWraps:YES];
    [bpmStepper setAutorepeat:YES];
    
    bpmLabel = [[UILabel alloc] initWithFrame:CGRectMake(420, 367, 120, 40)];
    [[bpmLabel layer] setCornerRadius:10];
    [bpmLabel setText:@"80"];
    [bpmLabel setTextAlignment:UITextAlignmentCenter];
    [bpmLabel setFont:[UIFont systemFontOfSize:24]];
     
    metronomeOnOff = [[UISwitch alloc] initWithFrame:CGRectMake(440, 415, 79, 27)];
    [metronomeOnOff setOn:NO animated:YES];
    
    [self.view addSubview:bpmLabel];
    [self.view addSubview:bpmStepper];
    [self.view addSubview:metronomeOnOff];
    
    [bpmStepper addTarget:self action:@selector(bpmStepperValueChanged:) forControlEvents:UIControlEventValueChanged];
    [metronomeOnOff addTarget:self action:@selector(metronomeOnOffChanged:) forControlEvents:UIControlEventValueChanged];
    
    beforePlayCounter = 0;
}

- (IBAction)metronomeOnOffChanged:(id)sender
{
    if(metronomeOnOff.on){
        double bpm = 60 / [[bpmLabel text] doubleValue];
        metronomeTimer = [NSTimer scheduledTimerWithTimeInterval: bpm
                 target:self 
                 selector:@selector(fireMetronomeSound:) 
                 userInfo:nil
                 repeats:YES];
    } else {
        [[self metronomeTimer] invalidate];
        metronomeTimer = nil;
    }
}

- (IBAction)fireMetronomeSound:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [mainDelegate.viewController.dataController metronomeTick];    
}

- (IBAction)bpmStepperValueChanged:(UIStepper *)sender {
    double stepperValue = bpmStepper.value;
    self.bpmLabel.text = [NSString stringWithFormat:@"%.f", stepperValue];
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
    Chord *newChord = [[Chord alloc] initWithName:draggedChord.chordName Notes:draggedChord.chordChosen.notes andID:draggedChord.chordChosen.idNumber];
    [newChord resetValues];
    
	// Check to see which view, or views,  the point is in and then animate to that position.
	if (CGRectContainsPoint([chordChosen1 frame], position)) {
		[chordChosen1 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:0 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen2 frame], position)) {
		[chordChosen2 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:1 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen3 frame], position)) {
		[chordChosen3 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:2 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen4 frame], position)) {
		[chordChosen4 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:3 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen5 frame], position)) {
		[chordChosen5 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:4 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen6 frame], position)) {
		[chordChosen6 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:5 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen7 frame], position)) {
		[chordChosen7 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:6 withObject: newChord];
	}
    else if (CGRectContainsPoint([chordChosen8 frame], position)) {
		[chordChosen8 setTitle:draggedChord.chordName forState:UIControlStateNormal] ;
        
        [chordsToBePlayed replaceObjectAtIndex:7 withObject: newChord];
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
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 0];
	}
    else if (CGRectContainsPoint([picker2 frame], touchPoint)) {
        [draggedChord setFrame:[picker2 frame]];
        [draggedChord changeChordName:picker2.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 1];
	}
    else if (CGRectContainsPoint([picker3 frame], touchPoint)) {
        [draggedChord setFrame:[picker3 frame]];
        [draggedChord changeChordName:picker3.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 2];
	}
    else if (CGRectContainsPoint([picker4 frame], touchPoint)) {
        [draggedChord setFrame:[picker4 frame]];
        [draggedChord changeChordName:picker4.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 3];
	}
    else if (CGRectContainsPoint([picker5 frame], touchPoint)) {
        [draggedChord setFrame:[picker5 frame]];
        [draggedChord changeChordName:picker5.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 4];
	}
    else if (CGRectContainsPoint([picker6 frame], touchPoint)) {
        [draggedChord setFrame:[picker6 frame]];
        [draggedChord changeChordName:picker6.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 5];
	}
    else if (CGRectContainsPoint([picker7 frame], touchPoint)) {
        [draggedChord setFrame:[picker7 frame]];
        [draggedChord changeChordName:picker7.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 6];
	}
    else if (CGRectContainsPoint([picker8 frame], touchPoint)) {
        [draggedChord setFrame:[picker8 frame]];
        [draggedChord changeChordName:picker8.chordName];
        touchIsInPicker = true;
        
        draggedChord.chordChosen = [chordChoices objectAtIndex: 7];
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
    
    // Clear the data structure by replacing all items with an NSString
    for (int x=0; x<chordsToBePlayed.count; x++) {
        [chordsToBePlayed replaceObjectAtIndex:x withObject:@""];
    }
}
// Hit it once, it pauses, hit it again it plays. Basically a toggle button
-(void) playButton_onTouchUpInside
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    
    // We will do some prechecks before we send over the chords to be played.
    // Namely: 1) That we have no gaps and 2) If all the spaces are not occupied, then we fill the rest of the array with rest chords
    // If there are gaps, refuse to play.
    bool hasGaps = false;
    bool isFull = TRUE;
    
    // Check if full by checking if last object is a NSString
    if ([[chordsToBePlayed objectAtIndex:chordsToBePlayed.count - 1] isKindOfClass:[NSString class]]) {
        isFull = FALSE;
    }
         
    // Check for gaps  
    int lastChordIndex = 0;
    for (int x=0;x<chordsToBePlayed.count; x++) {
        // If the object is not a chord, then we check if it is larger than lastChordIndex + 1
        // If it is, then there is a gap
        if ([[chordsToBePlayed objectAtIndex:x] isKindOfClass:[Chord class]]) {
            if (x > lastChordIndex + 1) {
                hasGaps = TRUE;
                break;
            }
            else if (x == lastChordIndex + 1)    
                lastChordIndex++;
        }
    }
    
    progressionEndIndx = -1;
    if (!hasGaps) 
    {
        progressionToBeSent = [[NSMutableArray alloc] initWithArray:chordsToBePlayed];
        
        // If not full, we fill the rest of the array with rest chords and send it off
        // We will work backwards since this means less lookups
        // I'm assuming that there are no rests in the middle
        if (!isFull) {
            for (int x=chordsToBePlayed.count-1; x>-1; x--) {
                // There's no need to fill the rest of the chords with rests
                if (![[chordsToBePlayed objectAtIndex:x] isKindOfClass:[Chord class]]) {
                    continue; // Just skip over it
                }
                else
                {
                    progressionEndIndx = x; // We track where the progression stops
                    break;
                }
            }
        }
        
        if (isPaused && progressionEndIndx > -1) {
            // If the UI hint has appeared already, don't do it again and just play the chords from where it left off
            if (!starsHaveAppeared) {
                // When we hit play, we will have to disable the stop button until the UI hint has finished
                currentChordPlayingIndex = 0;
                
                // We're going to call the metronome to keep track for 4 beats, then shut it off
                starsHaveAppeared = TRUE;
                [metronomeOnOff setOn:TRUE];
            }
            else
                beforePlayCounter = 4;
            
            [self metronome_onSwitchOnBeforePlay:metronomeOnOff];
            [stop setEnabled:FALSE];
            isPaused = FALSE;
            [play setTitle:@"Pause" forState:UIControlStateNormal];
        }
        else {
            //[mainDelegate.viewController.dataController pauseChords];
            isPaused = TRUE;
            [play setTitle:@"Play" forState:UIControlStateNormal];
        }
    }
    else 
    {
        // We render something on the UI to tell the user that there are gaps
        // For now, we'll just popup an alert message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Can not play chords with gaps in the middle" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) fireMetronome_onPlay:(id)sender
{
    if (beforePlayCounter < 4) {
        [self fireMetronomeSound:sender];
        
        // UI Count down 
        switch (beforePlayCounter) {
            case 0:
                [self.view addSubview:star1];
                break;
            case 1:
                [self.view addSubview:star2];
                break;
            case 2:
                [self.view addSubview:star3];
                break;
            case 3:
                [self.view addSubview:star4];
                break;
            default:
                break;
        }
        
        beforePlayCounter++;
        return;
    }
    
    // Once we hit 4 beats, stop metronome timer and start the chord time
    double bpm = 60 / [[bpmLabel text] doubleValue];
    chordTimer = [NSTimer scheduledTimerWithTimeInterval: bpm
                                                  target:self 
                                                selector:@selector(fireChord_onPlay:) 
                                                userInfo:nil
                                                 repeats:YES];
    
    beforePlayCounter = 0;
    [metronomeOnOff setOn:FALSE];
    [[self metronomeTimer] invalidate];
    metronomeTimer = nil;
    
    // Remove the stars
    [star1 removeFromSuperview];
    [star2 removeFromSuperview];
    [star3 removeFromSuperview];
    [star4 removeFromSuperview];
    [stop setEnabled:TRUE];
}

// This method is not called automatically if metronome is set on programmatically, have to manually call it
-(void) metronome_onSwitchOnBeforePlay:(id)sender
{
    // We're going to call the metronome function until the counter is greater than 4
    double bpm = 60 / [[bpmLabel text] doubleValue];
    metronomeTimer = [NSTimer scheduledTimerWithTimeInterval: bpm
                                                      target:self 
                                                    selector:@selector(fireMetronome_onPlay:) 
                                                    userInfo:nil
                                                     repeats:YES];
}

-(void) fireChord_onPlay:(id)sender
{
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    // Play current chord and increment the index somehow
    
    // Loop back to the beginning if progression is at an end
    if (currentChordPlayingIndex > progressionEndIndx)
        currentChordPlayingIndex = 0;
    
    // Update UI, change state of the chord chosen buttons to selected
    UIButton *chosenButton = [chosenChordButtonsArray objectAtIndex:currentChordPlayingIndex];
    [self scaleUpChordChosenButton:chosenButton];
    
    Chord *chordToBeSent = [progressionToBeSent objectAtIndex:currentChordPlayingIndex];
    [mainDelegate.viewController.dataController playChord:chordToBeSent];
    
    // We make a copy of the current chord playing because we do not want to affect the UI when we hit
    // stop. This also allows us to play with the number of beats per measure and actually have it be responsive
    // Though this approach is not the most memory friendly approach
    if (currentChordPlaying == nil) {
        currentChordPlaying = [[Chord alloc] initWithName:chordToBeSent.name Notes:chordToBeSent.notes andID:chordToBeSent.idNumber];
        currentChordPlaying.beatsPerMeasure = chordToBeSent.beatsPerMeasure;
        currentChordPlaying.numberOfMeasures = chordToBeSent.numberOfMeasures;
    }
    
    currentChordPlaying.beatsPerMeasure--; // Decrease beats per measure
    
    // We will only increment index if the num beats = 0
    if (currentChordPlaying.beatsPerMeasure == 0)
    {
        [self scaleDownChordChosenButton:chosenButton];	
        currentChordPlayingIndex++;
        currentChordPlaying = nil;
    }
}

-(void) scaleUpChordChosenButton:(UIButton *)theButton
{
    [UIButton beginAnimations:nil context:nil];
	[UIButton setAnimationDuration:GROW_ANIMATION_DURATION_SECONDS];
	theButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
	[UIButton commitAnimations];
}

-(void) scaleDownChordChosenButton:(UIButton *)theButton
{
    [UIButton beginAnimations:nil context:NULL];
    [UIButton setAnimationDuration:SHRINK_ANIMATION_DURATION_SECONDS];
    // Set the transform back to the identity, thus undoing the previous scaling effect.
    theButton.transform = CGAffineTransformIdentity;
    [UIButton commitAnimations];	
}

-(void) stopButton_onTouchUpInside
{
    // Stop the chord timer
    [chordTimer invalidate];
    chordTimer = nil;
    
    // Stop the last chord
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    [mainDelegate.viewController.dataController stopChord:currentChordPlaying];
    
    UIButton *chosenButton;
    
    if (currentChordPlayingIndex > progressionEndIndx)
        chosenButton = [chosenChordButtonsArray objectAtIndex:progressionEndIndx];
    else
        chosenButton = [chosenChordButtonsArray objectAtIndex:currentChordPlayingIndex];
    
    [self scaleDownChordChosenButton:chosenButton];
    
    isPaused = TRUE;
    [play setTitle:@"Play" forState:UIControlStateNormal];
    
    starsHaveAppeared = FALSE;
    progressionToBeSent = nil;
}

// Once the user touches a chord chosen, present the popover view
// Todo need to send chords
-(void) chordChosen_onTouchUpInside:(id)sender
{
    // We check if the chord to be played is of a type of chord class, this is only true if
    // the position is filled with a chord
    if ([[chordsToBePlayed objectAtIndex: [chosenChordButtonsArray indexOfObject:sender]] isKindOfClass:[Chord class]]) 
    {
        ChordOptionsViewController *chordOptionsController = [[ChordOptionsViewController alloc] init];
        
        // Send in the chord to the view controller and add it to the list of things to be played
        int index = 0;
        if ([sender isEqual:chordChosen1])
            index = 0;
        else if ([sender isEqual:chordChosen2])
            index = 1;
        else if ([sender isEqual:chordChosen3])
            index = 2;
        else if ([sender isEqual:chordChosen4])
            index = 3;
        else if ([sender isEqual:chordChosen5])
            index = 4;
        else if ([sender isEqual:chordChosen6])
            index = 5;
        else if ([sender isEqual:chordChosen7])
            index = 6;
        else if ([sender isEqual:chordChosen8])
            index = 7;
        
        chordOptionsController.theChord = [chordsToBePlayed objectAtIndex:index];
        
        if (popOverController == nil) {
            UIPopoverController *popOver = [[UIPopoverController alloc] initWithContentViewController:chordOptionsController];
                    
            // Specifiying size
            popOver.popoverContentSize = CGSizeMake(200, 180);
            popOver.delegate = self;
            popOverController = popOver;
        }
        else 
            popOverController.contentViewController = chordOptionsController;
        
        [chordOptionsController setPopoverController:popOverController];
        
        [popOverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:TRUE];
    }
}

// Implemented as part of UIPopoverControllerdelegate
-(void) popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    // Must check if delete was pressed since this call back is executed for non-programmatic calls
    if ([(ChordOptionsViewController *)popoverController.contentViewController wasDeletePressed]) {
        // Remove the chord and reset the button
        
        // Gets the appropriate button from the chord chosen and we remove the text associated
        UIButton *buttonChosen = (UIButton *)[chosenChordButtonsArray objectAtIndex:[chordsToBePlayed indexOfObject:[(ChordOptionsViewController *)popoverController.contentViewController theChord]]];
        
        [buttonChosen setTitle:@"" forState:UIControlStateNormal];
        [[(ChordOptionsViewController *)popoverController.contentViewController theChord] resetValues];
        
        // Now we remove the chord also from the array
        [chordsToBePlayed replaceObjectAtIndex:[chordsToBePlayed indexOfObject:[(ChordOptionsViewController *)popoverController.contentViewController theChord]] withObject:@""]; 
    }
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
