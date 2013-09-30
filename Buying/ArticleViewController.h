//
//  ArticleViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 29.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseController.h"
#import "chooseViewController.h"
#import "CompositionMaterialViewController.h"

@interface ArticleViewController : UIViewController <PopViewControllerDelegate>
{
    int tagObject;
}

- (IBAction)saveButtonUpInside:(id)sender;
- (IBAction)cancelButtonUpInside:(id)sender;
//@property (weak, nonatomic) IBOutlet UITextField *type_item;

@property (weak, nonatomic) IBOutlet UILabel *type_item;
@property (weak, nonatomic) IBOutlet UITextField *model;
@property (weak, nonatomic) IBOutlet UITextField *code_material;
@property (weak, nonatomic) IBOutlet UITextField *description_material;
@property (weak, nonatomic) IBOutlet UITextField *code_color;
@property (weak, nonatomic) IBOutlet UITextField *description_color;
//@property (weak, nonatomic) IBOutlet UITextField *dimensional_grid;
@property (weak, nonatomic) IBOutlet UILabel *dimensional_grid;
@property (weak, nonatomic) IBOutlet UISwitch *jeans;
@property (weak, nonatomic) IBOutlet UISwitch *knitwear;
@property (weak, nonatomic) IBOutlet UISwitch *skin;
@property (weak, nonatomic) IBOutlet UISwitch *fur;
@property (weak, nonatomic) IBOutlet UISwitch *beach;
@property (weak, nonatomic) IBOutlet UITextField *doscription_style;
@property (weak, nonatomic) IBOutlet UILabel *gender;
@property (weak, nonatomic) IBOutlet UILabel *color;
@property (weak, nonatomic) IBOutlet UITextField *comment;
@property (weak, nonatomic) IBOutlet UITextField *price1;
@property (weak, nonatomic) IBOutlet UITextField *price2;
@property (weak, nonatomic) IBOutlet UITextField *price3;
@property (weak, nonatomic) IBOutlet UITextField *price4;
@property (weak, nonatomic) IBOutlet UITextField *price5;
@property (weak, nonatomic) IBOutlet UILabel *type_collection;
@property (weak, nonatomic) IBOutlet UILabel *line;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UITextField *material_composition;
@property (weak, nonatomic) IBOutlet UILabel *shop;
@property (weak, nonatomic) IBOutlet UITextField *discount;

@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) chooseViewController *chooseController;//pvc
//@property (strong, nonatomic) CompositionMaterialViewController *сompositionMaterialViewController;//pvc



@end
