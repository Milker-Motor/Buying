//
//  DataBaseController.m
//  Price3
//
//  Created by a.lytvynov-bogdanov on 20.04.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DataBaseController.h"
#include "stdio.h"


@implementation DataBaseController

@synthesize database;

-(void) openDatabase
{
	int returnCode;
    //NSLog(@"%@", NSHomeDirectory());
	const char *databaseName = (char *)[[NSString stringWithFormat:@"%@/Documents/%@.db",NSHomeDirectory(), gNameDBFile] UTF8String];

    returnCode = sqlite3_open(databaseName, &database);
	
	if (returnCode != SQLITE_OK)
	{
		NSLog(@"Ошибка открытия базы данных. Ошибка: %s", sqlite3_errmsg(database));
	}
}

-(void) closeDatabase
{
	sqlite3_close(database);
}

-(NSArray *)getListOfTable
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnumerator = [fileManager enumeratorAtPath:[NSString stringWithFormat:@"%@/Documents/XML/",NSHomeDirectory()]];
    NSString *currPath;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    while (currPath = [dirEnumerator nextObject])
    {
        if ([[[currPath pathExtension] lowercaseString] isEqualToString: @"xml"])
        {
            [arr addObject:[currPath substringToIndex:[currPath length] - 4]];
        }
    }
    
    return arr;
}

-(void) addStringToDB:(NSArray *) tableCreate tableColumn: (NSString *) tableColumn
{
    const char *sqlStatement;
    char *errorMsg = "";
    int returnCode;
    
    for (NSString *str in tableCreate)
	{
		sqlStatement = (char *)[[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (%@)", str, tableColumn] UTF8String];
		returnCode = sqlite3_exec(database, sqlStatement, NULL, NULL, &errorMsg);
		
		if (returnCode != SQLITE_OK)
		{
			returnCode = sqlite3_exec(database, sqlStatement, NULL, NULL, &errorMsg);
			
            NSLog(@"Ошибка создание базы данных \n %s", sqlite3_errmsg(database));
			sqlite3_free(errorMsg);
			
		}
	}
}

-(void) createDatabase
{
    NSMutableArray *tableCreate = [[NSMutableArray alloc] initWithObjects:@"Orders", nil];
    NSString *tableColumn = @"contractor TEXT, " "brand TEXT, " "season TEXT," "order_date TEXT," "delivery_period_with TEXT," "delivery_period_for TEXT";
	
	[self openDatabase];
    
    [self addStringToDB:tableCreate tableColumn:tableColumn];
    
    [tableCreate removeAllObjects];
    
    [tableCreate addObject:@"Elements"];
    tableColumn = @"id TEXT," "type_item TEXT," "model TEXT," "code_material TEXT," "description_material TEXT," "code_color TEXT," "description_color TEXT," "dimensional_grid TEXT," "jeans TEXT," "knitwear TEXT," "skin TEXT," "fur TEXT," "beach TEXT," "doscription_style TEXT," "gender TEXT," "color TEXT," "comment TEXT," "price1 TEXT," "price2 TEXT," "price3 TEXT," "price4 TEXT," "price5 TEXT," "type_collection TEXT," "line TEXT," "country TEXT," "material_composition TEXT," "shop TEXT," "discount TEXT," "order_reference TEXT," "order_on_the_screen TEXT";
    
    [self addStringToDB:tableCreate tableColumn:tableColumn];
    
	//[self closeDatabase];
    
    [tableCreate removeAllObjects];
    [tableCreate addObjectsFromArray:[self getListOfTable]];
    tableColumn = @"id TEXT, " "level TEXT, " "id_parent TEXT," "name TEXT," "group_element TEXT," "owner_id TEXT";
    
    [self addStringToDB:tableCreate tableColumn:tableColumn];
    
	[self closeDatabase];
}

-(void) insertStringsInDatabase:(NSString *) nameTable value:(NSDictionary *) values keys:(NSArray *) keys
{
    int returnCode;
	sqlite3_stmt *pStmt;
	
	NSString *string = @"?";
	
	for (int i = 1; i < [values count]; i++)
	{
		{
			string = [NSString stringWithFormat:@"%@, ?", string];
		}
	}
	
	const char *st = (char *)[[NSString stringWithFormat:@"INSERT INTO %@ VALUES (%@)", nameTable, string] UTF8String];
    
	
	returnCode = sqlite3_prepare_v2(database, st, -1, &pStmt, 0);
    
	if (returnCode != SQLITE_OK)
	{
        // NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
		NSLog(@"Ошибка добавления новой строки в базу данных по причине \n %s", sqlite3_errmsg(database));
		return;
	}
	
	int i = 1;
	for (NSString *str in keys)
    //for (NSDictionary *value in values)
	{
        st = (char *)[[NSString stringWithFormat:@"%@", [values valueForKey:str]] UTF8String];
		sqlite3_bind_text(pStmt, i, [[values valueForKey:str] UTF8String], -1, SQLITE_STATIC);
        //sqlite3_bind_text(pStmt, i, [[@"qwe" valueForKey:str] UTF8String], -1, SQLITE_STATIC);
		i++;
	}
	
	returnCode = sqlite3_step(pStmt);
	return;
	if (returnCode != SQLITE_DONE)
	{
		NSLog(@"Ошибка добавления строки в таблицу БД.");
	}
	
	returnCode = sqlite3_finalize(pStmt);
	
	if (returnCode != SQLITE_OK)
	{
		NSLog(@"Ошибка добавления строки в таблицу БД.");
	}
	sqlite3_finalize(pStmt);
	/*for (NSDictionary *value in values)
	{
		[self insertString:nameTable value:value keys:keys];
	}*/
    
}

-(NSMutableArray*) returnValue:(const char *) request listOfColumn:(NSArray *) listOfColumn
{
	int returnCode;
	sqlite3_stmt *statement;
	
	char* sqlStatement = sqlite3_mprintf(request);
    
	returnCode = sqlite3_prepare_v2(database, sqlStatement, strlen(sqlStatement), &statement, NULL);
	sqlite3_free(sqlStatement);
	sqlStatement = nil;
	
	if (returnCode != SQLITE_OK)
	{
		NSLog(@"Ошибка выполнения запроса по полю. %s", sqlite3_errmsg(database));
        //  NSAssert1(0, @"Error: failed to set cache size with message '%s'.", sqlite3_errmsg(db));
		sqlite3_errmsg(database);
		
		return 0;
	}
	
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	returnCode = sqlite3_step(statement);
	while (returnCode  == SQLITE_ROW)
	{
		for (int i = 0; i < [listOfColumn count]; i++)
		{
			NSString *str;
			str = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(statement, i)];
			
			[dict setValue:str forKey:[listOfColumn objectAtIndex:i]];
		}
		NSDictionary *d = [[NSDictionary alloc] initWithDictionary:dict];
		[arr addObject:d];
		
        d = nil;
		
		returnCode = sqlite3_step(statement);
	}
	
	dict = nil;
	statement = nil;
	sqlite3_finalize(statement);
	
	return arr;
}

-(void) removeFromDatabase:(NSString *) nameTable
{
    
	int returnCode;
	sqlite3_stmt *statement;
	    
	char* sqlStatement = (char *) sqlite3_mprintf("DELETE FROM %s" , (char *) [nameTable UTF8String]);
    //char* sqlStatement = (char *) sqlite3_mprintf("TRUNCATE TABLE Brands");
	
	returnCode = sqlite3_prepare_v2(database, sqlStatement, strlen(sqlStatement), &statement, NULL);

    sqlite3_free(sqlStatement);
	
	if (returnCode != SQLITE_OK)
	{
		NSLog(@"Ошибка очистки таблицы %@ по причине \n %s", nameTable, sqlite3_errmsg(database));
		sqlite3_errmsg(database);
		
		return;
	}
    
	sqlite3_finalize(statement);
    
}

-(NSArray *) returnArrayFromDataBase:(NSString *) nameDB arrayObjects:(NSArray *) arrayObjects exception:(NSString *) exception valueException:(NSString *) valueException
{
    NSString *stringColumn = @"";
    for (int i = 0; i < [arrayObjects count]; i++)
    {
        if (i == 0)
        {
            stringColumn = [NSString stringWithFormat:@"%@", [arrayObjects objectAtIndex:i]];
        }
        else
        {
            stringColumn = [NSString stringWithFormat:@"%@, %@", stringColumn, [arrayObjects objectAtIndex:i]];
        }
    }
    
    const char *stringRequest;
    
    if ([exception length] == 0)
    {
        stringRequest = (char *)[[NSString stringWithFormat:@"SELECT %@ FROM %@", stringColumn, nameDB] UTF8String];
    }
    else
    {
        stringRequest = (char *)[[NSString stringWithFormat:@"SELECT %@ FROM %@ WHERE %@ = %@", stringColumn, nameDB, exception, valueException] UTF8String];
    }
    
    NSArray *listOfColumn = [[NSArray alloc] initWithArray:arrayObjects];
    NSArray *arr = [[NSArray alloc] initWithArray:[self returnValue:stringRequest listOfColumn:listOfColumn]];
    
    stringColumn = nil;
    listOfColumn = nil;
    return arr;
}

@end
