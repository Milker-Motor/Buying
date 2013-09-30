//
//  ScrollViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 27.08.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "ScrollViewController.h"

@implementation ScrollViewController

@synthesize lastPointX, lastPointY;

-(void) addViewWithOrdersOnScrollView:(UIScrollView *) scrollView selfIsTheMainObjecn:(id) selfObject addingView:(UIView *) addView target:(SEL) target
{
    lastPointY = 0.0;
    DataBaseController *dbController = [[DataBaseController alloc] init];
    [dbController openDatabase];
    //NSArray *listOrders = [[dbController returnListOfOrders:@"Orders"] copy];
    NSArray *listOrders = [[dbController returnArrayFromDataBase:@"Orders" arrayObjects:[NSArray arrayWithObjects:@"contractor", @"brand", @"season", @"order_date", @"delivery_period_with", @"delivery_period_for", nil] exception:@"" valueException:@""] copy];
    [dbController closeDatabase];
    dbController = nil;
    
    int i = 0;
    for (NSDictionary *dict in listOrders)
        {
            NSData *archivedViewData = [NSKeyedArchiver archivedDataWithRootObject: addView];
            UIView *newView = [NSKeyedUnarchiver unarchiveObjectWithData:archivedViewData];
            int widthView = newView.frame.size.width;
            int heightView = newView.frame.size.height;
            
            for (id labelOfView in newView.subviews)
            {
                if ([[labelOfView restorationIdentifier] isEqualToString:@"buttonID"])
                {
                    UIButton *button = labelOfView;
                    [button setTag:i];
                    [button addTarget:selfObject action:@selector(insertDataOrderButtonUpInside:) forControlEvents:UIControlEventTouchUpInside];
                }
                

                if ([[labelOfView restorationIdentifier] isEqualToString:@"seasonID"])
                {
                    UILabel *label = labelOfView;
                    label.text = [dict valueForKey:@"season"];
                    label = nil;
                }
                if ([[labelOfView restorationIdentifier] isEqualToString:@"brandID"])
                {
                    UILabel *label = labelOfView;
                    label.text = [dict valueForKey:@"brand"];
                    label = nil;
                }
                if ([[labelOfView restorationIdentifier] isEqualToString:@"countID"])
                {
                    //labelOfView.text = [dict valueForKey:@"count"];
                }
                if ([[labelOfView restorationIdentifier] isEqualToString:@"sumID"])
                {
                    //labelOfView.text = [dict valueForKey:@"sum"];
                }
                if ([[labelOfView restorationIdentifier] isEqualToString:@"contractorID"])
                {
                    UILabel *label = labelOfView;
                    label.text = [dict valueForKey:@"contractor"];
                    label = nil;
                }
                if ([[labelOfView restorationIdentifier] isEqualToString:@"shopID"])
                {
                    UILabel *label = labelOfView;
                    label.text = [dict valueForKey:@"shop"];
                    label = nil;
                }
                if ([[labelOfView restorationIdentifier] isEqualToString:@"order_dateID"])
                {
                    UILabel *label = labelOfView;
                    label.text = [dict valueForKey:@"order_date"];
                    label = nil;
                }
            }
            
            [newView setFrame:CGRectMake(0, lastPointY, widthView, heightView)];
            
            [scrollView insertSubview:newView atIndex:i];
            lastPointY += heightView;
            i++;
            archivedViewData = nil;
            newView = nil;
        }
    listOrders = nil;
    scrollView.contentSize = CGSizeMake(0,lastPointY);
}

-(void) addButtonWithImageOnScrollView:(UIScrollView *) scrollView selfObject:(id) selfObject listButtons:(NSArray *) listButtons
{
    int widthButton = 170;
    int heightButton = 225;
    
    int widthLabel = 170;
    int heightLabel = 21;
    
    int shift = 20;
    
    lastPointX = 20.0;
    lastPointY = 0.0;
    
    int widthScroll = 900;//scrollView.viewForBaselineLayout.frame.size.width;
    //NSLog(@"%@", scrollView.viewForBaselineLayout);
    int countButtonInString = 0;
    for (int i = 0; i < widthScroll; i += widthButton + shift)
    {
        countButtonInString++;
    }
    int numberObject = 0;
    
    for (int i = 0; i < [listButtons count]; i++)
    {
        UIButton *button = [[UIButton alloc] init];
        UILabel *label = [[UILabel alloc] init];
        
        [button setFrame:CGRectMake(lastPointX, lastPointY, widthButton, heightButton)];
        [label setFrame:CGRectMake(lastPointX, lastPointY + heightButton + 10, widthLabel, heightLabel)];
        
        if (lastPointX + widthButton + shift < widthScroll)
        {
            lastPointX += widthButton + shift;
        } else
        {
            lastPointX = 20.0;
            lastPointY += heightButton + shift + heightLabel + 10;
        }
        
        //[button setBackgroundImage:image forState:UIControlStateNormal];
        [button setHighlighted:true];
        [label setHighlighted:true];
        
        [button setBackgroundColor:[UIColor blackColor]];
        
        [label setText:[[listButtons objectAtIndex:i] objectForKey:@"model"]];
        
        [button addTarget:selfObject action:@selector(buttonImageUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        [scrollView insertSubview:button atIndex:numberObject];
        [scrollView insertSubview:label atIndex:numberObject + 1];
        
        numberObject +=2;
    }
    
    scrollView.contentSize = CGSizeMake(0,lastPointY + heightButton + heightLabel + 10);
}

-(void) addViewWithMaterialOnScrollView:(UIScrollView *) scrollView addingView:(UIView *) addView selfObject:(id) selfObject tag:(int) tag
{
    NSData *archivedViewData = [NSKeyedArchiver archivedDataWithRootObject: addView];
    UIView *view = [NSKeyedUnarchiver unarchiveObjectWithData:archivedViewData];
    view.tag = tag;
    [scrollView insertSubview:view atIndex:tag];
    NSLog(@"Y = %f, height view = %f", lastPointY, view.frame.size.height);
    scrollView.contentSize = CGSizeMake(0,lastPointY + view.frame.size.height);
//    scrollView.contentSize = CGSizeMake(0,70 + addView.frame.size.height);
}

@end
