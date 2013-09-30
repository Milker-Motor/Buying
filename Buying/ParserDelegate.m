//
//  ParserDelegate.m
//  Buying
//
//  Created by a.lytvynov-bogdanov on 02.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import "ParserDelegate.h"

@implementation ParserDelegate

@synthesize done=m_done;
@synthesize titles;
@synthesize error=m_error;

// чистка ресурсов
-(void) dealloc {
    m_error = nil;
    //m_title = nil;
}

// документ начал парситься
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    m_done = NO;
    titles = [[NSMutableArray alloc] init];
    //m_titles = [NSMutableArray new];
}
// парсинг окончен
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    m_done = YES;
}
// если произошла ошибка парсинга
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    m_done = YES;
    m_error = [parseError copy];
}
// если произошла ошибка валидации
-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    m_done = YES;
    m_error = [validationError copy];
}
/*
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    //NSLog(@"%@", namespaceURI);
    // если элемент title закончился - добавим строку в результат
    if ( m_isTitle ) {
        [m_titles addObject:m_title];
        NSLog(@"%@", m_title);
        m_title = nil;
    }
}*/

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"Object"])
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        [dict setValue:[attributeDict valueForKey:@"id"] forKey:@"id"];
        [dict setValue:[attributeDict valueForKey:@"level"] forKey:@"level"];
        [dict setValue:[attributeDict valueForKey:@"id_parent"] forKey:@"id_parent"];
        [dict setValue:[attributeDict valueForKey:@"name"] forKey:@"name"];
        [dict setValue:[attributeDict valueForKey:@"group_element"] forKey:@"group_element"];
        [dict setValue:[attributeDict valueForKey:@"owner_id"] forKey:@"owner_id"];
        [titles addObject:dict];
        dict = nil;
    }
}

@end
