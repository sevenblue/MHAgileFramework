//
//  MHButton.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/10.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MHButton;

typedef void(^MHButtonBlock)(MHButton *btn);

@interface MHButton : UIButton

- (void)setAction:(MHButtonBlock)block;

+ (MHButton *)normalButtonWithTitle:(NSString *)title frame:(CGRect)frame action:(MHButtonBlock)block;

@end
