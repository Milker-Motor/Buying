//
//  BuyingViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 07.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseController.h"
#import "BuyingAppDelegate.h"
#import "ScrollViewController.h"

@interface BuyingViewController : UIViewController
{
    DataBaseController *dbController;
}
@property (weak, nonatomic) IBOutlet ScrollViewController *mainScrollView;
@property (strong, nonatomic) IBOutlet UIView *orderView;

- (IBAction)insertDataOrderButtonUpInside:(id)sender;



@end
