//
//  MHMainInterfaceViewController.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHMainInterfaceViewController.h"

@interface MHMainInterfaceViewController ()

@end

@implementation MHMainInterfaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavigationBar];
    
    [self addScrollView];
}

- (void)setNavigationBar{
    [self setLeftBarButtonWithImage:[UIImage imageNamed:@"navi_btn_left"] selectHandle:^{
        [[MHSlidingManager sharedInstance]showLeftViewController:YES];
    }];
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"navi_btn_right"] selectHandle:^{
        [[MHSlidingManager sharedInstance]showRightViewController:YES];
    }];
}

- (void)addScrollView{
    NSArray *colorArr = @[[UIColor greenColor],[UIColor whiteColor],[UIColor yellowColor]];
    
    UIScrollView *scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-250, 320, 150)];
    scrollV.contentSize = CGSizeMake(320*3, 150);
    scrollV.pagingEnabled = YES;
    for (int i = 0; i < 3; i ++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(320*i, 0, 320, 150)];
        view.backgroundColor = [colorArr objectAtIndex:i];
        [scrollV addSubview:view];
    }
    [self.view addSubview:scrollV];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
