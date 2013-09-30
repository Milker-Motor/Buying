//
//  chooseViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 10.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "chooseViewController.h"

//@interface chooseViewController

@implementation chooseViewController

@synthesize listName, delegate;
@synthesize strPassedValue;
@synthesize strException;
@synthesize strValueException;
//@synthesize dictPassedValue;


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    //NSLog(@"%@", strPassedValue);
    DataBaseController *dbController = [[DataBaseController alloc] init];
    listName = [[NSMutableArray alloc] init];
    self.title = strPassedValue;
    //self.title = [dictPassedValue valueForKey:@"text"];
    [dbController openDatabase];
    
    listName = [[dbController returnArrayFromDataBase:strPassedValue arrayObjects:[NSArray arrayWithObjects:@"name", nil] exception:strException valueException:strValueException] copy];
    //listName = [[dbController returnArrayFromDataBase:[dictPassedValue valueForKey:@"text"] arrayObjects:[NSArray arrayWithObjects:@"name", nil]] copy];
    [dbController closeDatabase];

    dbController = nil;
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
 //   [tfNewData setText:@"return text"];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        //Создание ячейки
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[listName valueForKey:@"name"] objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [delegate dismissPop:cell.textLabel.text];  // make delegate callback here
}

@end
