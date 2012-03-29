//
//  MainController.h
//  Staff
//
//  Created by Aaron Tietz on 3/27/12.
//  Copyright (c) 2012 Tufts University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StaffController.h"
#import "DataController.h"
#import "ChordViewController.h"

@interface MainController : UIViewController

@property (strong, nonatomic) StaffController *staffController;

@property (strong, nonatomic) ChordViewController *chordController;

@property (strong, nonatomic) DataController* dataController;


@end
