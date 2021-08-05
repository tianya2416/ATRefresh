//
//  BaseRefreshController.m
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "BaseRefreshController.h"

NSString *loadTitle  = @"Data loading...";
NSString *emptyTitle = @"Data Empty...";
NSString *errorTitle = @"Net Error...";
NSString *emptyData = @"icon_data_empty";
NSString *errorData = @"icon_net_error";
@interface BaseRefreshController ()<ATRefreshDataSource,ATRefreshDelegate>
@property (strong, nonatomic) NSMutableArray *loadDatas;
@property (strong, nonatomic) NSMutableArray *footDatas;
@property (strong, nonatomic) NSMutableArray *headDatas;
@end

@implementation BaseRefreshController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupRefresh:(UIScrollView *)scrollView option:(ATRefreshOption)option{
    [self setupRefresh:scrollView option:option image:nil title:nil];
}
- (void)setupRefresh:(UIScrollView *)scrollView
              option:(ATRefreshOption)option
               image:(NSString *)image
               title:(NSString *)title{
    if (title.length > 0) {
        emptyTitle = title;
    }
    if (image) {
        emptyData = image;
    }
    if ([self.refreshData respondsToSelector:@selector(setupRefresh:option:)]) {
        [self.refreshData setupRefresh:scrollView option:option];
    }
}
- (void)endRefresh:(BOOL)hasMore{
    if ([self.refreshData respondsToSelector:@selector(endRefresh:)]) {
        [self.refreshData endRefresh:hasMore];
    }
}
- (void)endRefreshFailure{
    [self endRefreshFailure:nil];
}
- (void)endRefreshFailure:(NSString *)error{
    if (error.length > 0) {
        errorTitle = error;
    }
    if ([self.refreshData respondsToSelector:@selector(endRefreshFailure)]) {
        [self.refreshData endRefreshFailure];
    }
}
- (BOOL)refreshNetAvailable {
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus != AFNetworkReachabilityStatusNotReachable;
}
#pragma mark ATRefreshDelegate
- (void)refreshData:(NSInteger)page {
    
}
#pragma mark ATRefreshDataSource
- (NSArray <UIImage *>*)refreshHeaderData{
    return self.headDatas;
}
- (NSArray <UIImage *>*)refreshFooterData{
    return self.footDatas;
}
- (UIImage *)refreshLogoData{
    return self.refreshData.refreshing ? [UIImage animatedImageWithImages:self.loadDatas duration:0.4] : [UIImage imageNamed:[self refreshNetAvailable]? emptyData:errorData];
}
- (NSAttributedString *)refreshTitle{
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSString *text = self.refreshData.refreshing ? loadTitle : ([self refreshNetAvailable] ? emptyTitle : errorTitle);
    NSDictionary* attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName :[ATRefresh colorWithRGB:0x333333],
                                 NSParagraphStyleAttributeName : paragraph};
    return [[NSMutableAttributedString alloc] initWithString:text
                                                  attributes:attributes];
}
- (NSAttributedString *)refreshSubtitle{
    return nil;
}
- (UIButton *)refreshButton{
    return nil;
}
- (ATRefreshData *)refreshData{
    if (!_refreshData) {
        _refreshData = [[ATRefreshData alloc] init];
        _refreshData.dataSource = self;
        _refreshData.delegate = self;
    }
    return _refreshData;
}
- (NSMutableArray *)loadDatas{
    if (!_loadDatas) {
        _loadDatas = @[].mutableCopy;
        for (int i = 1; i< 6 ; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"episode_loading_0%@",@(i)]];
            if (!image) {
                break;
            }
            [_loadDatas addObject:image];
        }
        for (int i = 5; i >= 0; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"episode_loading_0%@",@(i)]];
            if (!image) {
                break;
            }
            [_loadDatas addObject:image];
        }
    }
    return _loadDatas;
}
- (NSMutableArray *)headDatas{
    if (!_headDatas) {
        _headDatas = @[].mutableCopy;
        for (int i = 1; i <= 35; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉loading_%04d.png", i]];
            if (!image) {
                break;
            }
            [_headDatas addObject:image];
        }
    }
    return _headDatas;
}
- (NSMutableArray *)footDatas{
    if (!_footDatas) {
        _footDatas = @[].mutableCopy;
        for (int i = 1; i <= 35; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"上拉loading_%04d.png", i]];
            if (!image) {
                break;
            }
            [_footDatas addObject:image];
        }
    }
    return _footDatas;
}
@end
