//
//  TableViewController.m
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) NSMutableArray *listData;
@property (assign, nonatomic) ATRefreshLoad refreshLoad;
@end

@implementation TableViewController
+ (instancetype)vcWithRefreshLoad:(ATRefreshLoad )refreshLoad
{
    TableViewController *vc = [[TableViewController alloc] init];
    vc.refreshLoad = refreshLoad;
    
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.listData = [@[] mutableCopy];
    switch (self.refreshLoad) {
        case ATRefreshLoadNone:
        {//无下拉刷新、无上拉加载
            [self setupEmpty:self.tableView];
            [self setupRefresh:self.tableView option:ATRefreshNone];
            [self headerRefreshing];
        }break;
        case ATRefreshLoadHead:
        {//有下拉刷新、无上拉加载
            [self setupEmpty:self.tableView];
            [self setupRefresh:self.tableView option:ATHeaderRefresh|ATHeaderAutoRefresh];
        }break;
        case ATRefreshLoadFoot:
        {//无下拉刷新、有上拉加载
            [self setupEmpty:self.tableView];
            [self setupRefresh:self.tableView option:ATFooterRefresh|ATFooterAutoRefresh];
        }break;
        case ATRefreshLoadDefault:
        {//有下拉刷新、有上拉加载
            [self setupEmpty:self.tableView];
            [self setupRefresh:self.tableView option:ATRefreshDefault];
        }break;
        default:
            break;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)refreshData:(NSInteger)page
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (page == 1) {
            [self.listData removeAllObjects];
        }
        for (int i = 0; i<20; i++) {
            [self.listData addObject:[NSString stringWithFormat:@"第%@条数据",@(i)]];
        }
        if (self.refreshLoad == ATRefreshLoadHead) {
            int random = [self getRandomNumber:100 to:200];
            if (random%3==0) {
                [self.listData removeAllObjects];
                [self.tableView reloadData];
                [self endRefreshFailure];
            }else if(random%3==1)
            {
                [self.tableView reloadData];
                [self endRefresh:NO];
            }else
            {
                [self.tableView reloadData];
                [self endRefresh:YES];
            }
        }else
        {
            [self.tableView reloadData];
            [self endRefresh:YES];
        }
    });
}

- (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
