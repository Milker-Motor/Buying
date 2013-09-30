//
//  chooseViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 10.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DataBaseController.h"

@protocol PopViewControllerDelegate;

@interface chooseViewController : UITableViewController

@property (weak) id <PopViewControllerDelegate> delegate;
@property (strong, nonatomic) NSMutableArray *listName;

@property (strong, nonatomic) NSString *strPassedValue;
@property (strong, nonatomic) NSString *strException;
@property (strong, nonatomic) NSString *strValueException;

//@property (strong, nonatomic) NSDictionary *dictPassedValue;

@end

@protocol PopViewControllerDelegate <NSObject>

@required
- (void)dismissPop:(NSString *)value;

@end
