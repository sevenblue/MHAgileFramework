//
//  MHBaseTableViewController.m
//  PeopleDailyNew
//
//  Created by Steven Nelson on 14-6-24.
//  Copyright (c) 2014年 M.H.International. All rights reserved.
//

#import "MHBaseTableViewController.h"
#import "MJRefresh.h"

@interface MHBaseTableViewController ()
{
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    CGRect tableFrame;
}
@end

@implementation MHBaseTableViewController
@synthesize tableView = _tableView;
@synthesize tableDataArray = _tableDataArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)requestURL{
    return @"";
}

- (NSDictionary *)requestParameters{
    return nil;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.checkLogin = NO;
}

- (void)initData{
    [super initData];
    
    _tableDataArray = [[NSMutableArray alloc]init];
}

- (void)addUI
{
    [super addUI];
    
    //initilize tableview
    [self addTableView];
    
    /*上拉下拉刷新*/
    [self addHeader];
    
    [self addFooter];
}

/**
 *  @description 在此方法里面添加headerView
 *  @return header的高度
 **/
- (float )addHeaderView{
    float headerHeight = 0;
    return headerHeight;
}

- (void)addTableView{
    CGRect tableRect;
    float tableHeith = 0;
    float headerHeith = [self addHeaderView];
    
    if (headerHeith) {
    }
    tableHeith = isIOS7AndLater?(-headerHeith-44-22):(-headerHeith-44);
    
    if(self.configureTableFrame)
    {
        CGFloat height = isIOS7AndLater?20:0;
        _tableView = [[UITableView alloc]
                      initWithFrame:CGRectMake(0, headerHeith, 320, self.view.bounds.size.height -headerHeith+height) style:UITableViewStylePlain];
    }
    else
    {
        _tableView = [[UITableView alloc]
                      initWithFrame:tableRect style:UITableViewStylePlain];
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [self setExtraCellLineHidden:_tableView];
}


#pragma mark -MJRefresh
- (void)addHeader
{
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = self.tableView;
    if (self.checkLogin)
    {
        //如果没有登录就停止监听pull
        if (![[MHUserInfo sharedInstance] isUserExist])
        {
            [header free];
            //
            //            [SharedAppDelegate.tabBarController presentViewController:[MHLoginViewController new] animated:YES completion:nil];
            return;
        }
    }
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        // TODO刷新数据
        _indexPage -= _indexPage;
        if (![[self requestURL]length]){
            [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
            return;
        }
        
        [self loadDataWithURL:[self requestURL] param:[self requestParameters] response:^(id result, NSDictionary *parameters){
            if([self.tableDataArray count]>0)[self.tableDataArray removeAllObjects];
            
            id data = [result objectForKey:@"data"];
            if ([data class]==NSClassFromString(@"NSNull")) {
                [self showAlertWithTitle:@"提示" andMessage:@"暂无数据!"];
                [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
                return ;
            }
            
            for (id dic in data)
            {
                TableDataModel*info = [TableDataModel setInfoByDictionary:dic type:_actionType];
                [self.tableDataArray addObject:info];
            }
            
            [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
        }];
    };
    [header beginRefreshing];
    _header = header;
}

- (void)addFooter
{
    MJRefreshFooterView *footer = [MJRefreshFooterView footer];
    footer.scrollView = self.tableView;
    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView) {
        _indexPage+=1;
        NSMutableDictionary *tempParameters = [NSMutableDictionary dictionaryWithDictionary: [self requestParameters]];
        [tempParameters setValue:[NSString stringWithFormat:@"%d",_indexPage] forKey:@"offset"];
        [self loadDataWithURL:[self requestURL] param:[self requestParameters] response:^(id result, NSDictionary *parameters){
            NSDictionary *data = [result objectForKey:@"data"];
            if ([data class]==NSClassFromString(@"NSNull") ||!data) {
                [self showAlertWithTitle:@"提示" andMessage:@"列表为空!"];
                [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
                _indexPage-=1;
                return ;
            }
            
            for (id dic in data)
            {
                TableDataModel *info = [TableDataModel setInfoByDictionary:dic type:_actionType];
                [self.tableDataArray addObject:info];
            }
        }];
        
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:0];
    };
    _footer = footer;
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    // 刷新表格
    [self.tableView reloadData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [refreshView endRefreshing];
}

- (void)refreshData{
    _indexPage = 0;
    [_header setState:MJRefreshStateRefreshing];
}

#pragma mark - tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - tableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end