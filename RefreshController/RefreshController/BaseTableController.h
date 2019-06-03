//
//  BaseTableController.h
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "BaseRefreshController.h"

@interface BaseTableController : BaseRefreshController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
}

@property (nonatomic, strong) UITableView *tableView;

@end
