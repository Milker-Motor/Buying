//
//  BuyingViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 07.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "BuyingViewController.h"

@interface BuyingViewController ()

@end

@implementation BuyingViewController
@synthesize mainScrollView;
@synthesize orderView;

- (void)viewDidLoad
{
    gNameDBFile = @"Buying";
    dbController = [[DataBaseController alloc] init];
    NSLog(@"%@", NSHomeDirectory());
    if ([[NSFileManager defaultManager] fileExistsAtPath: [NSString stringWithFormat:@"%@/Documents/%@.db",NSHomeDirectory(), gNameDBFile]] == FALSE)
    {
        [dbController createDatabase];
    }

    ScrollViewController *scrollView = [[ScrollViewController alloc] init];
    [scrollView addViewWithOrdersOnScrollView:mainScrollView selfIsTheMainObjecn:self addingView:orderView target:nil];
    scrollView = nil;

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void) viewDidUnload
{
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"1: dealloc");
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    /*
    if ([[segue identifier] isEqualToString:@"showDetail"])
    {
        [[segue destinationViewController] setText:@"SecondViewController"];
    }
    else
    {
        [super prepareForSegue:segue sender:sender];
    }*/
}

- (IBAction)insertDataOrderButtonUpInside:(id)sender
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ElementsViewControllerID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
    sb = nil;
    vc = nil;
}
@end
