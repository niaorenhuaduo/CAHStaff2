//
//  ViewController.m
//  Staff
//
//  Created by Christopher Harris on 3/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "StaffController.h"

@implementation StaffController

@synthesize staffView;
@synthesize lines;
@synthesize spaces;
@synthesize notes;

-(id)init{
    [self viewDidLoad];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Uncomment to run controllers talking to controllers code
    //AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    //[mainDelegate.viewController.dataController testmethod:[NSString stringWithFormat:@"%@",self.class]];
    
    self.notes = NULL;
    [self buildStaff];
    [self buildLines];
    [self buildSpaces];
    [self setFlatsAndSharps];
    
    
    //EXAMPLE OF HOW STAFF CHANGES//
    // NSMutableArray *thing = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1",@"0",@"0",@"0",nil];
    // [self performSelector:@selector(changeScale:) withObject:thing afterDelay:2.0];
    // NSMutableArray *thing2 = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"0",@"0",@"0",@"0",@"0",nil];
    // [self performSelector:@selector(changeScale:) withObject:thing2 afterDelay:4.0];
    // [self performSelector:@selector(clearAllSharpsAndFlatsFromStaff) withObject:nil afterDelay:6.0];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)buildStaff
{    
    self.staffView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 748)];
    [self.staffView setBackgroundColor:[UIColor whiteColor]];
    self.view = self.staffView;
}

- (void)buildLines
{
    lines = [[NSMutableDictionary alloc] initWithCapacity:7];
    [lines setObject:[[dashedLine alloc] initWithFrame:CGRectMake(0, 58, 400, 32)] forKey:@"aline"];
    [lines setObject:[[solidLine alloc] initWithFrame:CGRectMake(0, 158, 400, 32)] forKey:@"fline"];
    [lines setObject:[[solidLine alloc] initWithFrame:CGRectMake(0, 258, 400, 32)] forKey:@"dline"];
    [lines setObject:[[solidLine alloc] initWithFrame:CGRectMake(0, 358, 400, 32)] forKey:@"bline"];
    [lines setObject:[[solidLine alloc] initWithFrame:CGRectMake(0, 458, 400, 32)] forKey:@"gline"];
    [lines setObject:[[solidLine alloc] initWithFrame:CGRectMake(0, 558, 400, 32)] forKey:@"eline"];
    [lines setObject:[[dashedLine alloc] initWithFrame:CGRectMake(0, 658, 400, 32)] forKey:@"cline"];
    
    [self setLineTags];
    
    NSEnumerator *enumerator = [lines keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        UIView *line = [lines objectForKey:key];
        [staffView addSubview:line];
    }
}

-(void)setLineTags
{
    [[lines objectForKey:@"aline"] setTag:2];
    [[lines objectForKey:@"fline"] setTag:4];
    [[lines objectForKey:@"dline"] setTag:6];
    [[lines objectForKey:@"bline"] setTag:8];
    [[lines objectForKey:@"gline"] setTag:10];
    [[lines objectForKey:@"eline"] setTag:12];
    [[lines objectForKey:@"cline"] setTag:14];
}

- (void)buildSpaces
{
    spaces = [[NSMutableDictionary alloc] initWithCapacity:8];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 58)] forKey:@"b2space"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 90, 400, 68)] forKey:@"gspace"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 190, 400, 68)] forKey:@"espace"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 290, 400, 68)] forKey:@"cspace"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 390, 400, 68)] forKey:@"aspace"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 490, 400, 68)] forKey:@"fspace"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 590, 400, 68)] forKey:@"dspace"];
    [spaces setObject:[[UIView alloc] initWithFrame:CGRectMake(0, 690, 400, 58)] forKey:@"bspace"];
    [self setSpaceTags];
  
    NSEnumerator *enumerator = [spaces keyEnumerator];
    id key;
    while ((key = [enumerator nextObject])) {
        UIView *space = [spaces objectForKey:key];
        [space setBackgroundColor:[UIColor whiteColor]];
        [staffView addSubview:space];
    }
}

- (void)setSpaceTags
{
    [[spaces objectForKey:@"b2space"] setTag:1];
    [[spaces objectForKey:@"gspace"] setTag:3];
    [[spaces objectForKey:@"espace"] setTag:5];
    [[spaces objectForKey:@"cspace"] setTag:7];
    [[spaces objectForKey:@"aspace"] setTag:9];
    [[spaces objectForKey:@"fspace"] setTag:11];
    [[spaces objectForKey:@"dspace"] setTag:13];
    [[spaces objectForKey:@"bspace"] setTag:15];
}

- (BOOL)changeScale:(NSArray *)notesFromDataController
{
<<<<<<< HEAD
=======
    
>>>>>>> 5bc7e90170fb30c48fce32f36763a6209b1081b8
    //Return false if array is not normalized properly
    if(notesFromDataController.count != NUMBER_OF_NOTES + 1){
        NSLog(@" Recieved this number of notes: %@", [notesFromDataController count]);
        return FALSE;
    }
    
    //Parse values for validity first
    int num = -1;
    for(int i = 1; i <= NUMBER_OF_NOTES; i++)
    {
        num = [[notesFromDataController objectAtIndex:i] integerValue];
        if(num != -1 && num != 0 && num != 1){
            NSLog(@"Invalid Number: %d",num);
            return FALSE;
        }
        
    }
    
    //Reset staff with no icons
    [self clearAllSharpsAndFlatsFromStaff];
    
    num = -1;
    
    //For each, display flat/sharp if value -1/1
    for(int pos = 1; pos <= NUMBER_OF_NOTES; pos++)
    {
<<<<<<< HEAD
=======
        NSLog(@"note value: %d",[[notesFromDataController objectAtIndex:pos] intValue]);
        
>>>>>>> 5bc7e90170fb30c48fce32f36763a6209b1081b8
        num = [[notesFromDataController objectAtIndex:pos] intValue];
        if(num != 0){
<<<<<<< HEAD
            //Add +1 to pos becase tag attributes of lines/spaces start at 1
            [self setFlatOrSharpOnSpecificLineOrSpace:num withNotePosition:pos+1];
            [self findAccidentalNote:pos+1];
=======
            [self setFlatOrSharpOnSpecificLineOrSpace:num withNotePosition:pos];
>>>>>>> 5bc7e90170fb30c48fce32f36763a6209b1081b8
        }
    }
    return TRUE;
}

- (void)findAccidentalNote:(int)pos
{
    id key;
    if((pos % 2) == 1){
        NSEnumerator *senumerator = [spaces keyEnumerator];
        while ((key = [senumerator nextObject])) {
            UIView *subview = [spaces objectForKey:key];
            if(pos == [subview tag]){
                [self registerAccidentalNote:subview withPos:pos];
                return;
            }
        }
    } else {
        NSEnumerator *lenumerator = [lines keyEnumerator];
        while ((key = [lenumerator nextObject])) {
            UIView *subview = [lines objectForKey:key];
            if(pos == [subview tag]){
                [self registerAccidentalNote:subview withPos:pos];
                return;
            }
        }
    }
}

- (void)registerAccidentalNote:(UIView *)view withPos:(int)pos
{   
    NSLog(@"%@",view);
    UILongPressGestureRecognizer *accidentalGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(twoFingeredAccidentalNote:)];
    [accidentalGesture setNumberOfTapsRequired:1];
    [accidentalGesture setNumberOfTouchesRequired:2];
    [accidentalGesture setMinimumPressDuration:0];
    [view addGestureRecognizer:accidentalGesture];
}

- (void)twoFingeredAccidentalNote:(UILongPressGestureRecognizer *)recognizer
{
    NSLog(@"HERE!!!!!");
    AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if(recognizer.state == UIGestureRecognizerStateEnded){
        NSLog(@"stop accidental");
        [mainDelegate.viewController.dataController stopNote];
    } else {
        NSLog(@"start accidental");
        [mainDelegate.viewController.dataController playNoteAt:(recognizer.view.tag -1) WithHalfStepAlteration:TRUE];
    }
}

- (void)clearAllSharpsAndFlatsFromStaff
{   
    int sharpNum = 3;
    int flatNum = 5;
    UIImageView *icon = NULL;
    
    for(int pos = 0; pos < ICON_COUNT; pos++)
    {
        icon = [sharps objectForKey:[NSString stringWithFormat:@"%d",pos+sharpNum]];
        [icon setHidden:TRUE];
        icon = [flats objectForKey:[NSString stringWithFormat:@"%d",pos+flatNum]];
        [icon setHidden:TRUE];
        
    }
}

- (BOOL)setFlatOrSharpOnSpecificLineOrSpace:(int)num withNotePosition:(int)pos
{
    
    NSString *type = (num < 0) ? @"flat" : @"sharp";
   
    /*
    NSLog(@"NUM: %d",num);
    NSLog(@"TYPE: %@",type);
    NSLog(@"POS: %d",pos);
     */
    
    if(type == @"sharp" && (pos < 3 || pos > 10)){
        NSLog(@"Error: No sharp for note position: %d",pos);
        return FALSE;
    }
    else if(type == @"flat" && (pos < 5 || pos > 12)){
        NSLog(@"Error: No flat for note position: %d",pos);
        return FALSE; 
    }
    
    UIImageView *icon = (type == @"sharp") ? [sharps objectForKey:[NSString stringWithFormat:@"%d",pos]] : 
        [flats objectForKey:[NSString stringWithFormat:@"%d",pos]];
    [icon setHidden:FALSE];
    return TRUE;
}

- (void)setFlatsAndSharps
{
    IVM sharpData, flatData;
    int d_width = 30;
    int d_height = 30;
    int d_x = 10;

    sharpData.width = d_width;
    sharpData.height = d_height;
    sharpData.x = d_x;
    sharpData.y = 110;
    flatData.width = d_width;
    flatData.height = d_height;
    flatData.x = d_x;
    flatData.y = 210;
    
    int sharpNoteCount = 3;
    int flatNoteCount = 5;
    
    sharps = [[NSMutableDictionary alloc] initWithCapacity:ICON_COUNT];
    flats = [[NSMutableDictionary alloc] initWithCapacity:ICON_COUNT];
    
    for (int i = 0; i < ICON_COUNT; i++) {
        
        //Add sharp icons to staffView, hide all
        UIImageView *sharp = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smallsharp.gif"]];
        [sharp setFrame:CGRectMake(sharpData.x, sharpData.y, sharpData.width, sharpData.height)];
        [sharp setHidden:TRUE];
        //[self fadeOut : sharp withDuration: 3 andWait : 1 ];
        [sharps setValue:sharp forKey:[NSString stringWithFormat:@"%d",sharpNoteCount]];
        [staffView addSubview:sharp];
        
        //Add flat icons to staffView, hide all
        UIImageView *flat = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"smallflat.gif"]];
        [flat setFrame:CGRectMake(flatData.x, flatData.y, flatData.width, flatData.height)];
        [flat setHidden:TRUE];
        //[self fadeOut : flat withDuration: 3 andWait : 1 ];
        [flats setValue:flat forKey:[NSString stringWithFormat:@"%d",flatNoteCount]];
        [staffView addSubview:flat];
        
        flatData.y += 50;
        flatNoteCount +=1;
        sharpData.y += 50;
        sharpNoteCount += 1;
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"# of Touches: %d",[touches count]);
    NSArray *allTouches = [touches allObjects];
    for (UITouch *touch in allTouches)
    {
        if(touch.view.tag > 0)
        {
            //NSLog(@"Began - Tag: %d",touch.view.tag);
            AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [mainDelegate.viewController.dataController playNoteAt:(touch.view.tag -1) WithHalfStepAlteration:FALSE];
        }
    }
    
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        // Get a single touch and it's location
        
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.view];
        
        // Draw a red circle where the touch occurred
        UIView *touchView = [[UIView alloc] init];
        [touchView setTag:666];
        [touchView setBackgroundColor:[UIColor colorWithRed:0.0/255 green:153.0/255 blue:255.0/255 alpha:0.6]];
        [touchView setFrame:CGRectMake(touchPoint.x-15, touchPoint.y-15, 30, 30)];
        [[touchView layer] setCornerRadius:15];
        touchView.layer.borderColor = [UIColor colorWithRed:221.0/255 green:221.0/255 blue:221.0/255 alpha:0.9].CGColor;
        [[touchView layer] setBorderWidth:2]; 
        [staffView addSubview:touchView];     
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSArray *allTouches = [touches allObjects];
    for (UITouch *touch in allTouches){
        if(touch.view.tag > 0){
            AppDelegate *mainDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
            [mainDelegate.viewController.dataController stopNote];
        }
    }
    
    NSArray *subviews = [self.view subviews];
    for (UIView *view in subviews){
        if(view.tag == 666){
            [view removeFromSuperview];
        }
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
