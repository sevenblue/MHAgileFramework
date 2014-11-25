//
//  NSObject+ETAdditions.m
//  GYBusiness
//
//  Created by weipeng on 13-4-24.
//  Copyright (c) 2013年 weipeng. All rights reserved.
//

#import "NSObject+ETAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation NSObject (ETAdditions)

@end


@implementation UILabel(PTAdditions)

+ (UILabel *)customLabel:(NSString *)labFrame withTitle:(NSString *)title textSize:(int)size  textColor:(UIColor *)textColor
{
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectFromString(labFrame)];
    titleLab.font = [UIFont systemFontOfSize:size];
    titleLab.textAlignment = UITextAlignmentCenter;
    if ([title isEqualToString:@"(null)"]  )
    {
        titleLab.text = @"";
    }
    else
    {
        titleLab.text = title;
    }
    titleLab.backgroundColor = [UIColor clearColor];
    titleLab.textColor = textColor;
    return titleLab;
}

@end



@implementation UIView(PTAdditions)

- (void) Shake
{
	CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	[keyAn setDuration:0.5f];
	NSArray *array = [[NSArray alloc] initWithObjects:
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
					  [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
					  nil];
	[keyAn setValues:array];
	NSArray *times = [[NSArray alloc] initWithObjects:
					  [NSNumber numberWithFloat:0.1f],
					  [NSNumber numberWithFloat:0.2f],
					  [NSNumber numberWithFloat:0.3f],
					  [NSNumber numberWithFloat:0.4f],
					  [NSNumber numberWithFloat:0.5f],
					  [NSNumber numberWithFloat:0.6f],
					  [NSNumber numberWithFloat:0.7f],
					  [NSNumber numberWithFloat:0.8f],
					  [NSNumber numberWithFloat:0.9f],
					  [NSNumber numberWithFloat:1.0f],
					  nil];
	[keyAn setKeyTimes:times];
	[self.layer addAnimation:keyAn forKey:@"TextAnim"];
}


@end
