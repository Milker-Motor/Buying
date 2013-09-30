//
//  CompositionMaterialViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 18.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "chooseViewController.h"
#import "ScrollViewController.h"

@protocol PopCompositionMaterialViewControllerDelegate;

@interface CompositionMaterialViewController : UIViewController <PopViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *materialView;
@property (weak, nonatomic) IBOutlet UILabel *materialLabel;
@property (weak, nonatomic) IBOutlet UITextField *percentTextView;
@property (weak) id <PopCompositionMaterialViewControllerDelegate> delegate;
//@property (weak, nonatomic) IBOutlet UILabel *materialLabel;

@property (strong, nonatomic) UIStoryboardPopoverSegue *currentPopoverSegue;
@property (strong, nonatomic) chooseViewController *chooseController;//pvc
@property (strong, nonatomic) NSMutableArray *listMaterial;

//- (IBAction)insertNewObject:(id)sender;

@end

@protocol PopCompositionMaterialViewControllerDelegate <NSObject>

@required
- (void)dismissPop:(NSString *)value;
 @end