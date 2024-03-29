//
//  TableViewController.m
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

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
    [self loadUI];
}

- (void)loadUI{

    self.listData = [@[] mutableCopy];
    switch (self.refreshLoad) {
        case ATRefreshLoadNone:
        {//无下拉刷新、无上拉加载
            [self setupRefresh:self.tableView option:ATRefreshNone];
        }break;
        case ATRefreshLoadHead:
        {//有下拉刷新、无上拉加载
            [self setupRefresh:self.tableView option:ATHeaderRefresh|ATHeaderAutoRefresh];
        }break;
        case ATRefreshLoadFoot:
        {//无下拉刷新、有上拉加载
            [self setupRefresh:self.tableView option:ATFooterRefresh|ATFooterAutoRefresh];
        }break;
        case ATRefreshLoadDefault:
        {//有下拉刷新、有上拉加载
            [self setupRefresh:self.tableView option:ATRefreshDefault];
        }break;
        default:
            break;
    }
}
- (void)refreshData:(NSInteger)page
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"start"] = @(1+(page-1)*RefreshPageSize);
    params[@"end"] = @(RefreshPageSize);
    CGRect rect = [UIScreen mainScreen].bounds;
    NSInteger width = (int) (rect.size.width * 2);
    NSInteger height = (int) (rect.size.height * 2);
    params[@"imgSize"] = [NSString stringWithFormat:@"%lix%li",(long)width,(long)height];
    
    [BaseNetManager wallHot:params success:^(id  _Nonnull object) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([object isKindOfClass:NSArray.class]) {
                NSArray *datas = [NSArray yy_modelArrayWithClass:BaseModel.class json:object];
               
                if (datas) {
                    [self.listData addObjectsFromArray:datas];
                }
                [self.tableView reloadData];
                [self endRefresh:datas.count >= RefreshPageSize];
            }
        });
    } failure:^(NSString * _Nonnull error) {
        [self endRefreshFailure];
    }];
    
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
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [TableViewCell cellForTableView:tableView indexPath:indexPath];
    BaseModel *model = self.listData[indexPath.row];
    [cell.imaeV sd_setImageWithURL:[NSURL URLWithString:model.coverImgUrl]];
    cell.titleLab.text = model.gName ?:@"";
    cell.subTitleLab.text = [NSString stringWithFormat:@"观看次数:%@",model.voteGood ?:@"0"];
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
