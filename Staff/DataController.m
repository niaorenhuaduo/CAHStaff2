//
//  HACStaffDataController.m
//  HACdata
//
//  Created by Aaron Tietz on 3/26/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AppDelegate.h"
#import "MainController.h"
#import "StaffController.h"
#import "DataController.h"

@implementation DataController

@synthesize keySignatureAccidentals = _keySignatureAccidentals, chordsForKeySignatures = _chordsForKeySignatures, currentKeySignature = _currentKeySignature, keySignatureNoteMap = _keySignatureNoteMap, currentKey = _currentKey, majorKeyChords = _majorKeyChords;

-(id) init{    
    self = [super init];
    return self;
}

-(BOOL) loadData{
    [self fillKeySignatureAccidentals];
    [self fillNotesInKeySignatureDictionary];
    [self fillChordsDictionary];
    
    {
		AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
		unsigned char sysex[13] = {0x41, 0x10, 0x42, 0x12, 0x40, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0xF7};
		appDelegate._api->setSystemExclusiveMessage (appDelegate.handle, 0, 0xF0, sysex, 13);
	}
    
    // Initialize key signature choice to C
    [self setCurrentKeySignature:@"C"];
    [self instrumentWasChosen:0];
    [self keySignatureWasChosen:_currentKeySignature]; 

    halfStepAlteration = 0;
    
    return TRUE;
}

-(void)fillKeySignatureAccidentals{
    
    NSNumber *flat = [[NSNumber alloc] initWithInt:-1];
    NSNumber *none = [[NSNumber alloc] initWithInt:0];
    NSNumber *sharp = [[NSNumber alloc] initWithInt:1];
    
    NSNumber *B3 = [[NSNumber alloc] initWithInt:15];
    NSNumber *C4 = [[NSNumber alloc] initWithInt:14];
    NSNumber *D4 = [[NSNumber alloc] initWithInt:13];
    NSNumber *E4 = [[NSNumber alloc] initWithInt:12];
    NSNumber *F4 = [[NSNumber alloc] initWithInt:11];
    NSNumber *G4 = [[NSNumber alloc] initWithInt:10];
    NSNumber *A4 = [[NSNumber alloc] initWithInt:9];
    
    // Create arrays for all keySignatures in the Circle of 5ths, where 1 is the first b 
    // above the treble clef and 15 the first b below 0 is a none note
    //  -1 is flat, and 1 is sharp. Position 0 is the starting point of the key
    
    /** all natural notes **/
    
    NSArray *CMajor = [[NSArray alloc] initWithObjects:C4, 
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *AMinor = [[NSArray alloc] initWithObjects:A4,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    
	/** b: B **/
    
    NSArray *FMajor = [[NSArray alloc] initWithObjects:F4,
                       none,none,none,none,
                       none,none,none,flat,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *DMinor = [[NSArray alloc] initWithObjects:D4,
                       none,none,none,none,
                       none,none,none,flat,
                       none,none,none,none,
                       none,none,none,nil];
    
    
    /** b: B, E **/
    
    NSArray *BflatMajor = [[NSArray alloc] initWithObjects:B3,
                           none,none,none,none,
                           flat,none,none,flat,
                           none,none,none,none,
                           none,none,none,nil];
    
    NSArray *GMinor = [[NSArray alloc] initWithObjects:G4,
                       none,none,none,none,
                       flat,none,none,flat,
                       none,none,none,none,
                       none,none,none,nil];
    
    
    /** b: A, B, E **/		
    
    NSArray *EflatMajor = [[NSArray alloc] initWithObjects:E4,
                           none,none,none,none,
                           flat,none,none,flat,
                           flat,none,none,none,
                           none,none,none,nil];
    
    
    NSArray *CMinor = [[NSArray alloc] initWithObjects:C4,
                       none,none,none,none,
                       flat,none,none,flat,
                       flat,none,none,none,
                       none,none,none,nil];
    
    
    /** b: A, B, D, E **/
    
    NSArray *AflatMajor = [[NSArray alloc] initWithObjects:A4,
                           none,none,none,none,
                           flat,flat,none,flat,
                           flat,none,none,none,
                           none,none,none,nil];
    
    NSArray *FMinor = [[NSArray alloc] initWithObjects:F4,
                       none,none,none,none,
                       flat,flat,none,flat,
                       flat,none,none,none,
                       none,none,none,nil];
	
    
    /** b: A, B, D, E, G **/
    
    NSArray *DflatMajor = [[NSArray alloc] initWithObjects:D4,
                           none,none,none,none,
                           flat,flat,none,flat,
                           flat,flat,none,none,
                           none,none,none,nil];
    
    NSArray *BflatMinor = [[NSArray alloc] initWithObjects:B3,
                           none,none,none,none,
                           flat,flat,none,flat,
                           flat,flat,none,none,
                           none,none,none,nil];
    
    
    /** b: A, B, C, D, E, G **/
    
    NSArray *GflatMajor = [[NSArray alloc] initWithObjects:G4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,none,none,
                           none,none,none,nil];
    
    NSArray *EflatMinor = [[NSArray alloc] initWithObjects:E4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,none,none,
                           none,none,none,nil];
    
    
    /** b: A, B, C, D, E, G, F **/
    
	NSArray *CflatMajor = [[NSArray alloc] initWithObjects:C4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,flat,none,
                           none,none,none,nil];
    
    NSArray *AflatMinor = [[NSArray alloc] initWithObjects:A4,
                           none,none,none,none,
                           flat,flat,flat,flat,
                           flat,flat,flat,none,
                           none,none,none,nil];
    
    
    /** #: F **/
    
    NSArray *GMajor = [[NSArray alloc] initWithObjects:G4,
                       none,none,none,sharp,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *EMinor = [[NSArray alloc] initWithObjects:E4,
                       none,none,none,sharp,
                       none,none,none,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    
    /** #: C, F **/
    
    NSArray *DMajor = [[NSArray alloc] initWithObjects:D4,
                       none,none,none,sharp,
                       none,none,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *BMinor = [[NSArray alloc] initWithObjects:B3,
                       none,none,none,sharp,
                       none,none,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    
    /** #: C, F, G **/
    
    NSArray *AMajor = [[NSArray alloc] initWithObjects:A4,
                       none,none,sharp,sharp,
                       none,none,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects:F4,
                            none,none,sharp,sharp,
                            none,none,sharp,none,
                            none,none,none,none,
                            none,none,none,nil];
    
    
    /** #: C, D, F, G **/
    
	NSArray *EMajor = [[NSArray alloc] initWithObjects:E4,
                       none,none,sharp,sharp,
                       none,sharp,sharp,none,
                       none,none,none,none,
                       none,none,none,nil];
    
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects:C4,
                            none,none,sharp,sharp,
                            none,sharp,sharp,none,
                            none,none,none,none,
                            none,none,none,nil];
    
    
    /** #: A, C, D, F, G **/
    
    NSArray *BMajor = [[NSArray alloc] initWithObjects:B3,
                       none,none,sharp,sharp,
                       none,sharp,sharp,none,
                       sharp,none,none,none,
                       none,none,none,nil];
    
	NSArray *GsharpMinor = [[NSArray alloc] initWithObjects:G4,
                            none,none,sharp,sharp,
                            none,sharp,sharp,none,
                            sharp,none,none,none,
                            none,none,none,nil];
    
    
    /** #: A, C, D, E, F, G **/   
    
    NSArray *FsharpMajor = [[NSArray alloc] initWithObjects:F4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,none,
                            sharp,none,none,none,
                            none,none,none,nil];
	
	NSArray *DsharpMinor = [[NSArray alloc] initWithObjects:D4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,none,
                            sharp,none,none,none,
                            none,none,none,nil];	
    
    /** #: A, B, C, D, E, F, G **/   
    
	NSArray *CsharpMajor = [[NSArray alloc] initWithObjects:C4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,sharp,
                            sharp,none,none,none,
                            none,none,none,nil];	
    
    NSArray *AsharpMinor = [[NSArray alloc] initWithObjects:A4,
                            none,none,sharp,sharp,
                            sharp,sharp,sharp,sharp,
                            sharp,none,none,none,
                            none,none,none,nil];	 
    
    // Fill the keySignatures dictionary with each array and their corresponding key (to be the same as in the circle of fifths picker)
    _keySignatureAccidentals = [[NSDictionary alloc] initWithObjectsAndKeys:
                                CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", 
                                BMajor, @"B", FsharpMajor, @"F#", CsharpMajor, @"C#", CflatMajor, @"Cb", GflatMajor, @"Gb",
                                DflatMajor, @"Db", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", 
                                AMinor, @"Am", EMinor, @"Em", BMinor, @"Bm", FsharpMinor, @"F#m", CsharpMinor, @"C#m", 
                                GsharpMinor, @"G#m", DsharpMinor, @"D# Minor", AsharpMinor, @"A#m", AflatMinor, @"Abm", EflatMinor, @"Ebm", 
                                BflatMinor, @"Bbm", FMinor, @"Fm", CMinor, @"Cm", GMinor, @"Gm", DMinor, @"Dm", nil];
    
}

-(void)fillNotesInKeySignatureDictionary{
    
    NSNumber *fiftyEightNoteNum = [[NSNumber alloc] initWithInt:58];
    NSNumber *fiftyNineNoteNum = [[NSNumber alloc] initWithInt:59];
    NSNumber *sixtyNoteNum = [[NSNumber alloc] initWithInt:60];
    NSNumber *sixtyOneNoteNum = [[NSNumber alloc] initWithInt:61];
    NSNumber *sixtyTwoNoteNum = [[NSNumber alloc] initWithInt:62];
    NSNumber *sixtyThreeNoteNum = [[NSNumber alloc] initWithInt:63];
    NSNumber *sixtyFourNoteNum = [[NSNumber alloc] initWithInt:64];
    NSNumber *sixtyFiveNoteNum = [[NSNumber alloc] initWithInt:65];
    NSNumber *sixtySixNoteNum = [[NSNumber alloc] initWithInt:66];
    NSNumber *sixtySevenNoteNum = [[NSNumber alloc] initWithInt:67];
    NSNumber *sixtyEightNoteNum = [[NSNumber alloc] initWithInt:68];
    NSNumber *sixtyNineNoteNum = [[NSNumber alloc] initWithInt:69];
    NSNumber *seventyNoteNum = [[NSNumber alloc] initWithInt:70];
    NSNumber *seventyOneNoteNum = [[NSNumber alloc] initWithInt:71];
    NSNumber *seventyTwoNoteNum = [[NSNumber alloc] initWithInt:72];
    NSNumber *seventyThreeNoteNum = [[NSNumber alloc] initWithInt:73];
    NSNumber *seventyFourNoteNum = [[NSNumber alloc] initWithInt:74];
    NSNumber *seventyFiveNoteNum = [[NSNumber alloc] initWithInt:75];
    NSNumber *seventySixNoteNum = [[NSNumber alloc] initWithInt:76];
    NSNumber *seventySevenNoteNum = [[NSNumber alloc] initWithInt:77];
    NSNumber *seventyEightNoteNum = [[NSNumber alloc] initWithInt:78];
    NSNumber *seventyNineNoteNum = [[NSNumber alloc] initWithInt:79];
    NSNumber *eightyNoteNum = [[NSNumber alloc] initWithInt:80];
    NSNumber *eightyOneNoteNum = [[NSNumber alloc] initWithInt:81];
    NSNumber *eightyTwoNoteNum = [[NSNumber alloc] initWithInt:82];
    NSNumber *eightyThreeNoteNum = [[NSNumber alloc] initWithInt:83];
    NSNumber *eightyFourNoteNum = [[NSNumber alloc] initWithInt:84];
    
    
    NSArray *CMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *GMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *DMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *AMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *EMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *BMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *FsharpMajor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *CsharpMajor = [[NSArray alloc] initWithObjects:eightyFourNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                           seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum,
                           sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, nil];  
    
    NSArray *CflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySixNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *GflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *DflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *AflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *EflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *BflatMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *FMajor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    
    
    NSArray* AMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *EMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *BMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventyEightNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *FsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySixNoteNum, seventyFourNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *CsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyOneNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, sixtyNineNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *GsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySixNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
    NSArray *DsharpMinor = [[NSArray alloc] initWithObjects:eightyThreeNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, nil];
    
	NSArray *AsharpMinor = [[NSArray alloc] initWithObjects:eightyFourNoteNum, eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, 
                            seventySevenNoteNum, seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum,
                            sixtySixNoteNum, sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, nil]; 
    
    NSArray *AflatMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySixNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFourNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *EflatMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyOneNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, fiftyNineNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *BflatMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyEightNoteNum, seventySevenNoteNum, 
                           seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySixNoteNum,
                           sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *FMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventyFiveNoteNum, seventyThreeNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyOneNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *CMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyEightNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *GMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventyFiveNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyThreeNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    NSArray *DMinor = [[NSArray alloc] initWithObjects:eightyTwoNoteNum, eightyOneNoteNum, seventyNineNoteNum, seventySevenNoteNum, 
                       seventySixNoteNum, seventyFourNoteNum, seventyTwoNoteNum, seventyNoteNum, sixtyNineNoteNum, sixtySevenNoteNum,
                       sixtyFiveNoteNum, sixtyFourNoteNum, sixtyTwoNoteNum, sixtyNoteNum, fiftyEightNoteNum, nil];
    
    
    _keySignatureNoteMap = [[NSDictionary alloc] initWithObjectsAndKeys:
                            CMajor, @"C", GMajor, @"G", DMajor, @"D", AMajor, @"A", EMajor, @"E", 
                            BMajor, @"B", FsharpMajor, @"F#", DflatMajor, @"Db", CflatMajor, @"Cb", GflatMajor, @"Gb", 
                            CsharpMajor, @"C#", AflatMajor, @"Ab", EflatMajor, @"Eb", BflatMajor, @"Bb", FMajor, @"F", 
                            AMinor, @"Am", EMinor, @"Em", BMinor, @"Bm", FsharpMinor, @"F#m", CsharpMinor, @"C#m", 
                            GsharpMinor, @"G#m", DsharpMinor, @"D#m", BflatMinor, @"Bbm", AflatMinor, @"Abm", EflatMinor, @"Ebm",
                            AsharpMinor, @"A#m", FMinor, @"Fm", CMinor, @"Cm", GMinor, @"Gm", DMinor, @"Dm", nil];

}


-(void) fillChordsDictionary{ 

    NSNumber *one = [[NSNumber alloc]initWithFloat:1.0];
    NSNumber *three = [[NSNumber alloc]initWithFloat:3.0];
    NSNumber *threeFlat = [[NSNumber alloc]initWithFloat:3.1];
    NSNumber *five = [[NSNumber alloc]initWithFloat:5.0];
    NSNumber *four = [[NSNumber alloc]initWithFloat:4.0];
    NSNumber *fiveSharp = [[NSNumber alloc]initWithFloat:5.5];
    NSNumber *fiveFlat = [[NSNumber alloc]initWithFloat:5.1];
    NSNumber *six = [[NSNumber alloc]initWithFloat:6.0];
    NSNumber *sevenFlat = [[NSNumber alloc]initWithFloat:7.1];
    
    
    //Chord *rest = [[Chord alloc] initWithName:@"rest" Notes:nil andID:0];
    
    NSArray *a = [[NSArray alloc] initWithObjects:one, three, five, nil];
    Chord *Maj = [[Chord alloc] initWithName:@"Maj" Notes:a  andID:1];
    
    NSArray *b = [[NSArray alloc] initWithObjects:one, threeFlat, five, nil];
    Chord *min = [[Chord alloc] initWithName:@"min" Notes:b andID:2];
    
    NSArray *c = [[NSArray alloc] initWithObjects: one, three, fiveSharp, nil];
    Chord *aug  = [[Chord alloc] initWithName:@"aug" Notes:c andID:3];
    
    NSArray *d = [[NSArray alloc] initWithObjects:one, threeFlat, fiveFlat, nil];
    Chord *dim = [[Chord alloc] initWithName:@"dim" Notes:d andID:4];
    
    NSArray *e = [[NSArray alloc] initWithObjects:one, four, five, nil];
    Chord *sus4  = [[Chord alloc] initWithName:@"sus4" Notes:e andID:5];
    
    NSArray *f = [[NSArray alloc] initWithObjects:one, three, five, six, nil];
    Chord *Maj6 = [[Chord alloc] initWithName:@"Maj6" Notes:f andID:6];
    
    NSArray *g = [[NSArray alloc] initWithObjects:one, threeFlat, five, six, nil];
    Chord *min6 = [[Chord alloc] initWithName:@"min6" Notes:g andID:7];
    
    NSArray *h = [[NSArray alloc] initWithObjects:one, three, five, sevenFlat, nil];
    Chord *dom7 = [[Chord alloc] initWithName:@"dom7" Notes:h andID:8];
    
    _majorKeyChords = [[NSArray alloc]initWithObjects:Maj, min, aug, dim, sus4, Maj6, 
                         min6, dom7, nil];
}

-(void)addKeyToChords:(NSString*)theKey{
    for(Chord *c in _majorKeyChords){
        [c setKey:theKey];
    }
}


-(void)keySignatureWasChosen:(NSString*)choice
{
    
    NSArray* keySignaturetoDraw = [_keySignatureAccidentals objectForKey:choice];   
    currentKeySignatureNotes = [_keySignatureNoteMap objectForKey:choice];
    _currentKey = choice;
    [self addKeyToChords:choice];

    
    if(keySignaturetoDraw){
        AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        [mainDelegate.viewController.staffController changeScale:keySignaturetoDraw];
        [mainDelegate.viewController.chordController setUpChords:(NSArray*)_majorKeyChords];
    }
    else
        NSLog(@"changeScale called with unknown key signature %@", choice);
}


-(void)playNoteAt:(int)position WithHalfStepAlteration:(int) accidentalState{
    
    int noteNumber = [[currentKeySignatureNotes objectAtIndex:position] intValue];
    
    // add -1 or 1 to flat or sharp the note if the user wanted
    if(accidentalState){
        noteNumber += halfStepAlteration;
    }
    currentNote = noteNumber;
    
    NSLog(@"Playing note %d", noteNumber);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC0, MIDIinstrument, 0x00);
	appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x90, noteNumber, 0x7F);
}

-(void)metronomeTick{
    NSLog(@"Tick");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    // 115 is the wooden block
    
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC0, 115, 0x00);
	appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x90, 65, 0x7F);
}

-(void) instrumentWasChosen:(int)instrument{
    
    if(instrument > -1 && instrument < 128){
        MIDIinstrument = instrument;
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC0, MIDIinstrument, 0x00);
        [self performSelector:@selector(changeInstrumentName) withObject:nil afterDelay:0.1f];
    }
}

-(void)changeInstrumentName{
 	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	char name[128];
	appDelegate._api->ctrl (appDelegate.handle, CRMD_CTRL_GET_INSTRUMENT_NAME, name, sizeof (name));
	
	NSString *string = [NSString stringWithFormat:@"#%03d : %@", MIDIinstrument, [NSString stringWithCString:name encoding:NSASCIIStringEncoding]];
	NSLog(@"Changed to instrument: %@", string);   
}

-(void)twoFingerOptionWasSelected:(NSString*)option{
    NSLog(@"Half step choice made: %@", option);
    if(option == @"Apply Sharp" ){
        halfStepAlteration = 1;
    }
    else if(option == @"Apply Flat"){
        halfStepAlteration = -1;
    }
    else
        halfStepAlteration = 0;
    NSLog(@"Half step alteration is now: %d", halfStepAlteration);
}

-(void)stopNote{
    NSLog(@"Stopped playing note");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC0, 115, 0x00);
	appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x90, currentNote, 0x00);
}

-(void)playChord:(Chord *)chord
{
    NSLog(@"Playing chord:%@", chord.name);
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0xC0, MIDIinstrument, 0x00);
    
    for (int x=0; x<chord.notes.count; x++) {
        int note = [self calculateMajorNoteForChord:chord atPosition:x];
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x90, note, 0x7F);
    }
}

-(int)calculateMajorNoteForChord:(Chord*)chord atPosition:(int) pos{
    int note = 0;
    
    // get the starting note for this key
    int startingLocation = [[[_keySignatureAccidentals objectForKey:_currentKey] objectAtIndex:0] intValue] - 1;
    NSLog(@"root note: %d", startingLocation);
    
    /*
    NSNumber *one = [[NSNumber alloc]initWithFloat:1.0];
    NSNumber *three = [[NSNumber alloc]initWithFloat:3.0];
    NSNumber *threeFlat = [[NSNumber alloc]initWithFloat:3.1];
    NSNumber *four = [[NSNumber alloc]initWithFloat:4.0];
    NSNumber *five = [[NSNumber alloc]initWithFloat:5.0];
    NSNumber *fiveFlat = [[NSNumber alloc]initWithFloat:5.1];
    NSNumber *fiveSharp = [[NSNumber alloc]initWithFloat:5.5];
    NSNumber *six = [[NSNumber alloc]initWithFloat:6.0];
    NSNumber *sevenFlat = [[NSNumber alloc]initWithFloat:7.1];
    */
    float value = [[chord.notes objectAtIndex:pos] floatValue];
    
    if (value == 1.0){
        return [[currentKeySignatureNotes objectAtIndex:startingLocation]intValue];
    }
    else if(value == 3.0){
        return [[currentKeySignatureNotes objectAtIndex:startingLocation - 2]intValue];
    }
    else if(value == 3.1){
        return ([[currentKeySignatureNotes objectAtIndex:startingLocation - 2]intValue] -1); 
    }
    else if(value == 4.0){
        return [[currentKeySignatureNotes objectAtIndex:startingLocation - 3]intValue];        
    }    
    else if(value == 5.0){
        return [[currentKeySignatureNotes objectAtIndex:startingLocation - 4]intValue];
    }
    else if(value == 5.1){
        return ([[currentKeySignatureNotes objectAtIndex:startingLocation - 4]intValue] -1);        
    }
    else if(value == 5.5){
        return ([[currentKeySignatureNotes objectAtIndex:startingLocation - 5]intValue] + 1);
    }    
    else if(value == 6.0){
        return [[currentKeySignatureNotes objectAtIndex:startingLocation - 5]intValue];
    }
    else if(value == 7.1){
        return ([[currentKeySignatureNotes objectAtIndex:startingLocation - 6]intValue] -1);
    }
    else{
        NSLog(@"unknown chord note float value: %f", value);
    }
    

    
    
    return note;
}


-(void)stopChord:(Chord *)chord
{
    NSLog(@"Stop chord:%@", chord.name);
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    for (int x=0; x<chord.notes.count; x++) {
        int note = [[chord.notes objectAtIndex:x] intValue];
        appDelegate._api->setChannelMessage (appDelegate.handle, 0x00, 0x90, note, 0x00);
    }
}

@end
