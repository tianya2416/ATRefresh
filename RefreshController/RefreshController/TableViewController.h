//
//  TableViewController.h
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
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
