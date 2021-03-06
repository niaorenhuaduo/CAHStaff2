//
//  ChordOptionsViewController.h
//  Staff
//
//  Created by Hu Huang on 3/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chord.h"

@interface ChordOptionsViewController : UIViewController
{
    UIImage *deleteImage;
    UIButton *deleteChord;
    UILabel *beatStepperLabel;
    UILabel *beatLabel;
    UIStepper *beatStepper;
    UIPopoverController *_popOverController;
    
    Chord *_chord;
    BOOL deletePressed;
}

@property (retain) Chord *theChord;

-(void) stepperPressed:(id)sender;
-(void) setPopoverController:(UIPopoverController *) popOverController;
-(void) delete_onTouchUpInside;
-(BOOL) wasDeletePressed;

@end
