//
//  CompositionMaterialViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 18.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "CompositionMaterialViewController.h"

@implementation CompositionMaterialViewController

@synthesize delegate;
@synthesize materialLabel;
@synthesize chooseController;
@synthesize currentPopoverSegue;
@synthesize listMaterial;
@synthesize mainScrollView;
@synthesize materialView;

- (void)viewDidLoad
{
    listMaterial = [[NSMutableArray alloc] init];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([[segue identifier] isEqualToString:@"segPop"]) {
    currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
    chooseController = [segue destinationViewController];
    [chooseController setDelegate:self];
    
    [chooseController setStrPassedValue:@"CompositionMaterial"];
    [chooseController setStrException:@""];
    [chooseController setStrValueException:@""];
}

- (void)dismissPop:(NSString *)value
{
    materialLabel.text = value;
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
    
    NSLog(@"%f", mainScrollView.contentSize.height);
    
    if (materialView.superview.tag == [listMaterial count])
    {
        ScrollViewController *scrollView = [[ScrollViewController alloc] init];
        scrollView.lastPointY = mainScrollView.contentSize.height;
        [scrollView addViewWithMaterialOnScrollView:mainScrollView addingView:materialView selfObject:self tag:[materialLabel superview].tag + 1];
    }
}

@end
