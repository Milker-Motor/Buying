//
//  ParserDelegate.h
//  Buying
//
//  Created by a.lytvynov-bogdanov on 02.09.13.
//  Copyright (c) 2013 o.lytvynov-bogdanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserDelegate : NSObject
{
    BOOL m_done;
    BOOL m_isTitle;
    NSError* m_error;
//    NSMutableArray* m_titles;
//    NSMutableString* m_title;
}
// свойство-флаг, который показывает закончен ли парсинг
@property (readonly) BOOL done;
// если есть ошибка - ее описание, если нет - nil
@property (readonly) NSError* error;
// результат парсинга
@property (readonly) NSMutableArray* titles;

@end
