//
//  OrderViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 07.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chooseViewController.h"
#import "CompositionMaterialViewController.h"

@interface OrderViewController : UIViewController <PopViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *contractorButton;
@property (weak, nonatomic) IBOutlet UIButton *brandButton;

@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *contractorLabel;
@property (weak, nonatomic) IBOutlet UITextField *season;
@property (weak, nonatomic) IBOutlet UITextField *order_date;
@property (weak, nonatomic) IBOutlet UITextField *delivery_period_with;
@property (weak, nonatomic) IBOutlet UITextField *delivery_period_for;
@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) chooseViewController *chooseController;//pvc

- (IBAction)addOrderButtonUpInside:(id)sender;
- (IBAction)cancelButtonUpInside:(id)sender;

@end
