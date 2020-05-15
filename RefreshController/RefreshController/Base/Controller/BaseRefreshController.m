//
//  BaseRefreshController.m
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "BaseRefreshController.h"

#define defaultDataEmpty [UIImage imageNamed:@"icon_data_empty"]//空数据图片
#define defaultDataLoad [UIImage imageNamed:@"icon_data_load"]//加载中图片
#define defaultNetError [UIImage imageNamed:@"icon_net_error"]//无网络图片

@interface BaseRefreshController ()<ATRefreshDataSource>
@property (strong, nonatomic) NSMutableArray *loadDatas;
@property (strong, nonatomic) NSMutableArray *footDatas;
@property (strong, nonatomic) NSMutableArray *headDatas;
@end

@implementation BaseRefreshController
- (void)dealloc{
    NSLog(@"%@",NSStringFromClass(self.class));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.dataSource = self;
    self.loadDatas = @[].mutableCopy;
    self.footDatas = @[].mutableCopy;
    self.headDatas = @[].mutableCopy;
    [self loadData];
    [self footData];
    [self headData];
}
- (void)loadData{
    for (int i = 1; i< 6 ; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"episode_loading_0%@",@(i)]];
        if (!image) {
            break;
        }
        [self.loadDatas addObject:image];
    }
    for (int i = 5; i >= 0; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"episode_loading_0%@",@(i)]];
        if (!image) {
            break;
        }
        [self.loadDatas addObject:image];
    }
}
- (void)headData{
    for (int i = 1; i <= 35; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉loading_%04d.png", i]];
        if (!image) {
            break;
        }
        [self.headDatas addObject:image];
    }

}
- (void)footData{
    for (int i = 1; i <= 35; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"上拉loading_%04d.png", i]];
        if (!image) {
            break;
        }
        [self.footDatas addObject:image];
    }

}
- (NSArray <UIImage *>*)refreshFooterData{
    return self.footDatas;
}
- (NSArray <UIImage *>*)refreshHeaderData{
    return self.headDatas;
}
- (NSArray <UIImage *>*)refreshLoaderData{
    return self.loadDatas;
}
- (UIImage *)refreshEmptyData{
    return [UIImage imageNamed:@"icon_data_empty"];
}
- (UIImage *)refreshErrorData{
    return [UIImage imageNamed:@"icon_net_error"];
}

- (NSString *)refreshLoaderToast{
    return @"Data loading...";
}
- (NSString *)refreshErrorToast{
    return @"Net Error...";
}
- (NSString *)refreshEmptyToast{
    return @"Data Empty...";
}
@end
