//
//  MHBaseTableViewController.h
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//
/**
 *  @abstract   带上拉下拉刷新的tableView基类
 *  @requite    - (void)initData    初始化数据
 *              - (void)addUI       加载UI
 *              - requestURL        获取list数据的URL
 **/
#import "MHBaseViewController.h"

@interface MHBaseTableViewController : MHBaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) int indexPage;

@property (nonatomic, strong)UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *tableDataArray;

@property (nonatomic, assign, readwrite) ACTIONTYPE actionType;

@property (nonatomic,assign) BOOL configureTableFrame;

#pragma mark - subClass must inherited func 
- (NSString *)requestURL;
- (NSDictionary *)requestParameters;

#pragma mark - refresh data
- (void)refreshData;

#pragma mark - delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)setExtraCellLineHidden: (UITableView *)tableView;

@end