//
//  ChordOptionsViewController.m
//  Staff
//
//  Created by Hu Huang on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ChordOptionsViewController.h"

@implementation ChordOptionsViewController

@synthesize theChord = _chord;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 180)];
    
    deleteImage = [UIImage imageNamed:@"bin_small.png"];
    
    beatStepperLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 180, 30)];
    [beatStepperLabel setText: @"Beats per Chord:"];
    beatStepperLabel.font = [UIFont fontWithName:@"Noteworthy-Light" size:20.0f];
    [beatStepperLabel setTextAlignment:UITextAlignmentCenter];
    
    beatLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 45, 40, 25)];
    beatLabel.font = [UIFont fontWithName:@"Noteworthy-Light" size:20.0f];
    [beatLabel setTextAlignment:UITextAlignmentCenter];
    [beatLabel setText:[NSString stringWithFormat:@"%d", _chord.beatsPerMeasure]];
    
    beatStepper = [[UIStepper alloc] initWithFrame:CGRectMake(70, 45, 100, 40)];
    [beatStepper addTarget:self action:@selector(stepperPressed:) forControlEvents:UIControlEventValueChanged];
    
    // Set min and max
    [beatStepper setMinimumValue:1];
    [beatStepper setMaximumValue:16];
    beatStepper.value = _chord.beatsPerMeasure;
    
    // Value wraps around from minimum to maximum
    [beatStepper setWraps:NO];
    
    // If continuos (default), changes are sent for each change in stepper,
    // otherwise, change event occurs once user lets up on button
    [beatStepper setContinuous:NO];
    
    deleteChord = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteChord.frame = CGRectMake(50, 85, 52, 68);
    [deleteChord setImage:deleteImage forState:UIControlStateNormal];
    [deleteChord addTarget:self action:@selector(delete_onTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:beatStepperLabel];
    [self.view addSubview:beatLabel];
    [self.view addSubview:beatStepper];
    [self.view addSubview:deleteChord];
    
    deletePressed = FALSE;
}

-(void) setPopoverController:(UIPopoverController *) popOverController
{
    // We need a reference to the popover controller so that we can dismiss it
    _popOverController = popOverController;
}

-(void) stepperPressed:(id)sender
{
    // Set the value of the label and increment the beats
    _chord.beatsPerMeasure = beatStepper.value;
    [beatLabel setText:[NSString stringWithFormat:@"%d", _chord.beatsPerMeasure]];
}

-(void) delete_onTouchUpInside
{
    // We will manually call the delegate function
    deletePressed = TRUE;
    [_popOverController dismissPopoverAnimated:TRUE];
    [_popOverController.delegate popoverControllerDidDismissPopover:_popOverController];
}

-(BOOL) wasDeletePressed
{
    return deletePressed;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
