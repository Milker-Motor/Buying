//
//  ArticleViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 29.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController
@synthesize type_item;
@synthesize model;
@synthesize code_material;
@synthesize description_material;
@synthesize code_color;
@synthesize description_color;
@synthesize dimensional_grid;
@synthesize jeans;
@synthesize knitwear;
@synthesize skin;
@synthesize fur;
@synthesize beach;
@synthesize doscription_style;
@synthesize gender;
@synthesize color;
@synthesize comment;
@synthesize price1;
@synthesize price2;
@synthesize price3;
@synthesize price4;
@synthesize price5;
@synthesize type_collection;
@synthesize line;
@synthesize country;
@synthesize material_composition;
@synthesize shop;
@synthesize discount;

@synthesize chooseController;
//@synthesize сompositionMaterialViewController;
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

-(void) setUpWindow
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"ElementsViewControllerID"];
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:vc animated:YES completion:NULL];
    sb = nil;
    vc = nil;
}

- (IBAction)saveButtonUpInside:(id)sender
{
    DataBaseController *dbController = [[DataBaseController alloc] init];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:@"id", @"type_item", @"model", @"code_material", @"description_material", @"code_color", @"description_color", @"dimensional_grid", @"jeans", @"knitwear", @"skin", @"fur", @"beach", @"doscription_style", @"gender", @"color", @"comment", @"price1", @"price2", @"price3", @"price4", @"price5", @"type_collection", @"line", @"country", @"material_composition", @"shop", @"discount", @"order_reference", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"", @"id",
                          [type_item text], @"type_item",
                          [model text], @"model",
                          [code_material text], @"code_material",
                          [description_material text], @"description_material",
                          [code_color text], @"code_color",
                          [description_color text], @"description_color",
                          [dimensional_grid text], @"dimensional_grid",
                          @"", @"jeans",
                          @"", @"knitwear",
                          @"", @"skin",
                          @"", @"fur",
                          @"", @"beach",
                          [doscription_style text], @"doscription_style",
                          [gender text], @"gender",
                          [color text], @"color",
                          [comment text], @"comment",
                          [price1 text], @"price1",
                          [price2 text], @"price2",
                          [price3 text], @"price3",
                          [price4 text], @"price4",
                          [price5 text], @"price5",
                          [type_collection text], @"type_collection",
                          [line text], @"line",
                          [country text], @"country",
                          [material_composition text], @"material_composition",
                          [shop text], @"shop",
                          [discount text], @"discount",
                          @"", @"order_reference",
                          nil];
    [dbController openDatabase];
    [dbController insertStringsInDatabase:@"Elements" value:dict keys:arr];
    [dbController closeDatabase];
    arr = nil;
    dict = nil;
    dbController = nil;
    
    [self setUpWindow];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //if ([[segue identifier] isEqualToString:@"segPop"]) {
    currentPopoverSegue = (UIStoryboardPopoverSegue *)segue;
    chooseController = [segue destinationViewController];
    [chooseController setDelegate:self];
    
    //сompositionMaterialViewController = [segue destinationViewController];
    //[сompositionMaterialViewController setDelegate:self];
    
    tagObject = [sender tag];
    
    
    switch (tagObject)
    {
        case 1: // types collection button
            [chooseController setStrPassedValue:@"TypesCollection"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 2:  //dimensional grid button
            [chooseController setStrPassedValue:@"DimensionalGrids"];
            [chooseController setStrException:@"group_element"];
            [chooseController setStrValueException:@"1"];
            break;
        case 3:  //gender button
            [chooseController setStrPassedValue:@"Gender"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 4:  //color button
            [chooseController setStrPassedValue:@"Colors"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 5:  //type collection button
            [chooseController setStrPassedValue:@"TypesCollection"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 6:  //line button
            [chooseController setStrPassedValue:@"Line"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 7:  //country button
            [chooseController setStrPassedValue:@"Country"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 8:  //shop button
            [chooseController setStrPassedValue:@"Shops"];
            [chooseController setStrException:@""];
            [chooseController setStrValueException:@""];
            break;
        case 9:  //composition material button
            //[chooseController setStrPassedValue:@"Shops"];
            //[chooseController setStrException:@""];
            //[chooseController setStrValueException:@""];
            break;
    }
    
}

- (void)dismissPop:(NSString *)value
{
    switch (tagObject)
    {
        case 1: // types collection button
            type_item.text = value;
            break;
        case 2: //dimensional grid button
            dimensional_grid.text = value;
            break;
        case 3: //gender button
            gender.text = value;
            break;
        case 4: //color button
            color.text = value;
            break;
        case 5:  //type collection button
            type_collection.text = value;
            break;
        case 6:  //line button
            line.text = value;
            break;
        case 7:  //country button
            country.text = value;
            break;
        case 8:  //shop button
            shop.text = value;
            break;
        case 9:  //composition material button
            //shop.text = value;
            break;
    }
    [[currentPopoverSegue popoverController] dismissPopoverAnimated: YES]; // dismiss the popover
}

- (IBAction)cancelButtonUpInside:(id)sender
{
    [self setUpWindow];
}
@end
