//
//  NSString+JudgeIfEmpty.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-8-27.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JudgeIfEmpty)

-(BOOL)isEmptyWithTrim;
-(NSString*)stringWithTrim;

@end
