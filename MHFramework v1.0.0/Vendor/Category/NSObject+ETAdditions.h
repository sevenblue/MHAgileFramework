//
//  NSObject+ETAdditions.h
//  GYBusiness
//
//  Created by weipeng on 13-4-24.
//  Copyright (c) 2013年 weipeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ETAdditions)


@end


@interface UILabel(ETAdditions)

+ (UILabel *)customLabel:(NSString *)labFrame withTitle:(NSString *)title textSize:(int)size  textColor:(UIColor *)textColor;
@end

@interface UIView(PTAdditions)

- (void) Shake;

@end
