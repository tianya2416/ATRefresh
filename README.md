1、基本介绍          
   
    基于MJRefresh、DZNEmptyDataSet的封装（UITableView、UICollectionView）加载时以及加载完成时无数据的UI
    有任何问题可以联系我wangws1990@163.com
        
2、集成方式
    
    pod 'ATRefresh_ObjectC'
    pod 'ATRefresh_Swift'   
    
    若无法更新下来
    
    pod 'ATRefresh_ObjectC',:git => 'https://github.com/tianya2416/ATRefresh_ObjectC.git' 
    pod 'ATRefresh_Swift',:git => 'https://github.com/tianya2416/ATRefresh_Swift.git'  
    
3、Objc 使用情况
    
    情况1:加载中UI
![image](https://github.com/tianya2416/RefreshController/blob/master/RefreshController/RefreshController/Resources/2.png)

    情况2:加载完成有数据UI
![image](https://github.com/tianya2416/RefreshController/blob/master/RefreshController/RefreshController/Resources/1.png)

    情况3:加载中没有数据UI
![image](https://github.com/tianya2416/RefreshController/blob/master/RefreshController/RefreshController/Resources/3.png)

    情况4:加载中网络异常UI
![image](https://github.com/tianya2416/RefreshController/blob/master/RefreshController/RefreshController/Resources/4.png)
    
    使用方式
    一、//无下拉刷新、无上拉加载
    [self setupRefresh:self.tableView option:ATRefreshNone];
    二、//有下拉刷新、无上拉加载
    [self setupRefresh:self.tableView option:ATHeaderRefresh|ATHeaderAutoRefresh];
    三、//无下拉刷新、有上拉加载
    [self setupRefresh:self.tableView option:ATFooterRefresh|ATFooterAutoRefresh];
    四、////有下拉刷新、有上拉加载
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
[Objc版本](https://github.com/tianya2416/ATRefresh_ObjectC.git)


4、Swift 使用情况

[Swift版本](https://github.com/tianya2416/ATRefresh_Swift.git)
