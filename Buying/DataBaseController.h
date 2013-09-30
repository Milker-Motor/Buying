//
//  DataBaseController.h
//  Price3
//
//  Created by a.lytvynov-bogdanov on 20.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BuyingAppDelegate.h"
//#import "/usr/include/sqlite3.h"
#import <sqlite3.h>

@interface DataBaseController : NSObject
{
	sqlite3 *database;
}

@property (nonatomic) sqlite3 *database;

-(void) openDatabase;
-(void) closeDatabase;

-(void) createDatabase;
//-(void) createDatabase:(NSArray *) nameTableForCreate tableColumn:(NSString *)tableColumn tableKeys:(NSArray *) tableKeys;

-(void) insertStringsInDatabase:(NSString *) nameTable value:(NSDictionary *) values keys:(NSArray *) keys;

-(void) removeFromDatabase:(NSString *) nameTable;

-(NSArray *) returnArrayFromDataBase:(NSString *) nameDB arrayObjects:(NSArray *) arrayObjects exception:(NSString *) exception valueException:(NSString *) valueException;

@end
