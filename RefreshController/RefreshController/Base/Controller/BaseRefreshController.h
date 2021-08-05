//
//  BaseRefreshController.h
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATRefreshData.h"
#import "BaseViewController.h"


#define RefreshPageStart (1)
#define RefreshPageSize (20)

typedef NS_ENUM(NSUInteger, ATRefreshLoad) {
    ATRefreshLoadNone = 0,
    ATRefreshLoadHead,
    ATRefreshLoadFoot,
    ATRefreshLoadDefault,
};

@interface BaseRefreshController : BaseViewController{
    ATRefreshData *_refreshData;
}
@property (strong, nonatomic)ATRefreshData *refreshData;
//default
- (void)setupRefresh:(UIScrollView *)scrollView option:(ATRefreshOption)option;
//custom
- (void)setupRefresh:(UIScrollView *)scrollView option:(ATRefreshOption)option image:(NSString *)image title:(NSString *)title;
- (void)endRefresh:(BOOL)hasMore;

- (void)endRefreshFailure;
- (void)endRefreshFailure:(NSString *)error;
@end
