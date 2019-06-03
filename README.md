    基于MJRefresh、DZNEmptyDataSet的封装（UITableView、UICollectionView）加载时以及加载完成时无数据的UI
    有任何问题可以联系我wangws1990@163.com
    下载地址：https://github.com/tianya2416/RefreshController.git
    
    情况1:加载中UI
    情况2:加载完成无数据UI
    
    使用方式
    一、//无下拉刷新、无上拉加载
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATRefreshNone];
    [self headerRefreshing];
    二、//有下拉刷新、无上拉加载
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATHeaderRefresh|ATHeaderAutoRefresh];
    三、//无下拉刷新、有上拉加载
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATFooterRefresh|ATFooterAutoRefresh];
    四、////有下拉刷新、有上拉加载
    [self setupEmpty:self.tableView];
    [self setupRefresh:self.tableView option:ATRefreshDefault];
    
    - (void)refreshData:(NSInteger)page{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"cateId"]   = @"1";
    params[@"isNow"]    = @"1";
    params[@"start"]    = @(1+(page-1)*RefreshPageSize);
    params[@"end"]      = @(RefreshPageSize);
    CGRect rect     = [UIScreen mainScreen].bounds;
    NSInteger width = (int) (rect.size.width * 2);
    NSInteger height   = (int) (rect.size.height * 2);
    params[@"imgSize"] = [NSString stringWithFormat:@"%lix%li",(long)width,(long)height];
    [GKHomeNetManager wallCategoryItem:@"" params:params success:^(id  _Nonnull object) {
        if (page == 1) {
            [self.listData removeAllObjects];
        }
        NSArray *listData= [NSArray modelArrayWithClass:GKWallClassItemModel.class json:object[@"groupList"]];
        [self.listData addObjectsFromArray:listData];
        [self.tableView reloadData];
        [self endRefresh:listData.count >=RefreshPageSize];//YES表示有下一页数据NO表示无下一页数据
    } failure:^(NSString * _Nonnull error) {
        [self endRefreshFailure];//此处表示无网络时或者访问服务器失败时候 空数据
        }];
    }
    
    
