//
//  MHJsonModel.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/12/11.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import "MHBaseModel.h"
#import "BaseNSObject.h"

@interface MHJsonModel : BaseNSObject

@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,retain) NSArray *children;
@property (nonatomic,copy) NSString *click_avatar;
@property (nonatomic,copy) NSString *e_name;
@property (nonatomic,copy) NSString *localicon;
@property (nonatomic,copy) NSString *tag_id;
@property (nonatomic,copy) NSString *tag_name;
@property (nonatomic,copy) NSString *tag_type;

@end
