//
//  ScrollViewController.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 27.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataBaseController.h"

@interface ScrollViewController : UIScrollView
{
    float lastPointX;
    float lastPointY;
}

@property (nonatomic) float lastPointX;
@property (nonatomic) float lastPointY;

-(void) addViewWithOrdersOnScrollView:(UIScrollView *) scrollView selfIsTheMainObjecn:(id) selfObject addingView:(UIView *) addView target:(SEL) target;

-(void) addButtonWithImageOnScrollView:(UIScrollView *) scrollView selfObject:(id) selfObject listButtons:(NSArray *) listButtons;

-(void) addViewWithMaterialOnScrollView:(UIScrollView *) scrollView addingView:(UIView *) addView selfObject:(id) selfObject tag:(int) tag;

@end
