//
//  MHButton.m
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/10.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHButton.h"
@interface MHButton ()
{
    MHButtonBlock _touchUpInsideBlock;
}

@end

@implementation MHButton

+ (MHButton *)normalButtonWithTitle:(NSString *)title frame:(CGRect)frame action:(MHButtonBlock)block
{
    MHButton *btn = [MHButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.backgroundColor = [UIColor grayColor];
    btn.frame = frame;
    [btn setAction:block];
    return btn;
}

- (void)setAction:(MHButtonBlock)block
{
    _touchUpInsideBlock = block;
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action:(id)sender
{
    if (_touchUpInsideBlock) {
        _touchUpInsideBlock(sender);
    }
}

@end
