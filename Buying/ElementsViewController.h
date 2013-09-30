//
//  ElementsViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 29.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseController.h"
#import "ScrollViewController.h"

@interface ElementsViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *picker;
    DataBaseController *dbController;
    ScrollViewController *mainScrollView;
}

@property (nonatomic, retain) IBOutlet ScrollViewController *mainScrollView;

-(void) buttonImageUpInside:(id) sender;
- (IBAction)takePhotoButtonUpInside:(id)sender;

@end
