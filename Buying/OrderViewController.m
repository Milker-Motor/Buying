//
//  OrderViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 07.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "OrderViewController.h"
#import "DataBaseController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

@synthesize contractorButton;
@synthesize brandButton;
@synthesize brandLabel;
@synthesize contractorLabel;
//@synthesize brand;
@synthesize season;
@synthesize order_date;
@synthesize delivery_period_with;
@synthesize delivery_period_for;
@synthesize chooseController;
@synthesize currentPopoverSegue;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setMainWindow
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"BuyingViewControllerID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
    sb = nil;
    vc = nil;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([[segue identifier] isEqualToString:@"segPop"]) {
    currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
    chooseController = [segue destinationViewController];
    [chooseController setDelegate:self];
    
    //}
    if ([sender tag] == 1) // contractor button
    {
        [chooseController setStrPassedValue:@"Contractors"];
        [chooseController setStrException:@""];
        [chooseController setStrValueException:@""];
    }
    else if ([sender tag] == 2) //brand button
    {
        [chooseController setStrPassedValue:@"Brands"];
        [chooseController setStrException:@""];
        [chooseController setStrValueException:@""];
    }
}

- (void)dismissPop:(NSString *)value
{
    brandLabel.text = value;
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
}

- (IBAction)addOrderButtonUpInside:(id)sender
{
    DataBaseController *dbController = [[DataBaseController alloc] init];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"contractor", @"brand", @"season", @"order_date", @"delivery_period_with", @"delivery_period_for", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[contractorLabel text], @"contractor", [brandLabel text], @"brand", [season text], @"season", [order_date text], @"order_date", [delivery_period_with text], @"delivery_period_with", [delivery_period_for text], @"delivery_period_for", nil];
    [dbController openDatabase];
    [dbController insertStringsInDatabase:@"Orders" value:dict keys:arr];
    [dbController closeDatabase];
    arr = nil;
    dict = nil;
    dbController = nil;
    [self setMainWindow];
}

- (IBAction)cancelButtonUpInside:(id)sender
{
    [self setMainWindow];
}

@end
