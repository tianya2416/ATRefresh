//
//  BaseTableController.h
//  RefreshController
//
//  Created by 王炜圣 on 2018/8/24.
//  Copyright © 2018年 王炜圣. All rights reserved.
//

#import "BaseRefreshController.h"

@interface BaseTableController : BaseRefreshController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) UITableView *tableView;

@end
