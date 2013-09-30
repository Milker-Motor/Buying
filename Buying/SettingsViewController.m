//
//  SettingsViewController.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 02.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
-(void) reloadDB:(NSString *) nameDB listDate:(NSArray *) listDate
{
    DataBaseController *dbController = [[DataBaseController alloc] init];
    [dbController openDatabase];
    [dbController removeFromDatabase:nameDB];
    NSArray *arr = [[NSArray alloc] initWithObjects:@"id", @"level", @"id_parent", @"name", @"group_element", @"owner_id", nil];
    for (NSDictionary *dict in listDate)
    {
        [dbController insertStringsInDatabase:nameDB value:dict keys:arr];
    }
    [dbController closeDatabase];
    arr = nil;
    dbController = nil;
}

-(void)reloadBrandXML
{
    // создаем делегат
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnumerator = [fileManager enumeratorAtPath:[NSString stringWithFormat:@"%@/Documents/XML/",NSHomeDirectory()]];
    NSString *currPath;
    while (currPath = [dirEnumerator nextObject])
    {
        if ([[[currPath pathExtension] lowercaseString] isEqualToString: @"xml"])
        {
            NSString *nameFile = [currPath substringToIndex:[currPath length] - 4];
            //NSLog(@"%@", nameFile);
            ParserDelegate *delegate = [ParserDelegate new];
            
            // создаем парсер при помощи файла, назначаем делегат и запускаем
            NSString* path = [NSString stringWithFormat:@"%@/Documents/XML/%@",NSHomeDirectory(), currPath];
            NSData* data = [NSData dataWithContentsOfFile: path];
            NSXMLParser* parser = [[NSXMLParser alloc] initWithData: data];
            
            [parser setDelegate:(id)delegate];
            [parser parse];
            
            // ждем, пока идет загрука и парсинг
            while (!delegate.done) sleep(1);
            
            // когда парсинг окончен
            // проверяем была ли ошибка парсинга
            if ( delegate.error == nil ) {
                // если нет то выводим результат
               // NSLog(@"%@",delegate.titles);
            } else {
                // если была - выводим ошибку
                NSLog(@"Error: %@", delegate.error);
            }
            
            [self reloadDB:nameFile listDate:delegate.titles];
            
            // освобождаем ресуры
            delegate = nil;
            parser = nil;
        }
    }
    currPath = nil;
    dirEnumerator = nil;
    fileManager = nil;
}

- (IBAction)updateDBUpInside:(id)sender
{
    [self reloadBrandXML];
    
}
@end
