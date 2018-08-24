//
//  TableViewController.h
//  RefreshController
//
//  Created by 王炜圣 on 2018/8/24.
//  Copyright © 2018年 王炜圣. All rights reserved.
//

#import "BaseTableController.h"

typedef NS_ENUM(NSUInteger, ATRefreshLoad) {
    ATRefreshLoadNone = 0,
    ATRefreshLoadHead,
    ATRefreshLoadFoot,
    ATRefreshLoadDefault,
};

@interface TableViewController : BaseTableController

+ (instancetype)vcWithRefreshLoad:(ATRefreshLoad )refreshLoad;

@end
