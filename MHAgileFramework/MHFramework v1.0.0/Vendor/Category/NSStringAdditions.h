//
//  NSStringAdditions.h
//  BizIQ
//
//  Created by zhoucy on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(isPureInt)

- (BOOL)isPureInt;
// if srcString == nil retrun @"" else return [srcString autorelease]
+ (NSString*)nilString:(NSString*)srcString;
// 在长度大于limitLength的string后面添加...
+ (NSString*)decorateStringWithDotsByLength:(uint)limitLength string:(NSString*)srcString;
//return @"0" if srcString == nil or srcString == @""
+ (NSString*)stringToZeroValueString:(NSString*)srcString;
// autoRelease string formmater value
+ (NSString*)stringFromDouble:(double)value;

+ (NSString*)stringWithNewUUID;

+ (NSString*)stringWithIntValue:(int)value;

+ (NSString *)lastString:(NSString *)_str;

+ (NSString *)headString:(NSString *)_str;

+ (NSString *)stringWithMaxLength:(int)length string:(NSString*)srcString;

+ (NSString *)removeEmoji:(NSString*)emojiString;

+ (id)newContentByOld:(NSString*)oldString newString:(NSString*)string;

+ (NSString *)removeSpace:(NSString*)text;

+ (NSString *)createID;

+ (int)fromUID:(NSString *)bareStr;

- (id)JSONValue;
@end
