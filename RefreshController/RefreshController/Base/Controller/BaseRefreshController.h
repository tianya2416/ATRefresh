//
//  BaseRefreshController.h
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATRefreshController.h>

#define RefreshPageStart (1)
#define RefreshPageSize (20)
typedef NS_ENUM(NSUInteger, ATRefreshLoad) {
    ATRefreshLoadNone = 0,
    ATRefreshLoadHead,
    ATRefreshLoadFoot,
    ATRefreshLoadDefault,
};

@interface BaseRefreshController : ATRefreshController

@end
