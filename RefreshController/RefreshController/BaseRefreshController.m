//
//  BaseRefreshController.m
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "BaseRefreshController.h"

@interface BaseRefreshController () {
    BOOL _isSetKVO;
    BOOL _needReload;
    __weak UIView *_emptyView;
}
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, copy) NSString *emptyTitle;
@property (nonatomic, strong) UIImage *emptyImage;
@property (nonatomic, strong) UIImage *noNetImage;

@end

@implementation BaseRefreshController
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)dealloc {
    _scrollView.delegate = nil;
}

#pragma mark - refresh 刷新处理
- (void)setupRefresh:(UIScrollView *)scrollView option:(ATRefreshOption)option {
    self.scrollView = scrollView;
    if (option & ATHeaderRefresh) {
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
        header.automaticallyChangeAlpha = YES;
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        NSMutableArray * images = [NSMutableArray array];
        for (int i = 1; i <= 35; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"下拉loading_%04d.png", i]];
            if (!image) {
                break;
            }
            [images addObject:image];
        }
        if (images.count > 0) {
            [header setImages:@[images.firstObject] forState:MJRefreshStateIdle];
            [header setImages:images duration:1 forState:MJRefreshStateRefreshing];
        }
        
        if (option & ATHeaderAutoRefresh) {
            [self headerRefreshing];
        }
        scrollView.mj_header = header;
    }
    
    if (option & ATFooterRefresh) {
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
        footer.triggerAutomaticallyRefreshPercent = -20.0f;
        footer.stateLabel.hidden = NO;
        footer.labelLeftInset = -22;
        
        NSMutableArray * images = [NSMutableArray array];
        for (int i = 1; i <= 35; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"上拉loading_%04d.png", i]];
            if (!image) {
                break;
            }
            [images addObject:image];
        }
        if (images.count > 0) {
            [footer setImages:@[images[0]] forState:MJRefreshStateIdle];
            [footer setImages:images duration:1.0f forState:MJRefreshStateRefreshing];
        }
        [footer setTitle:@"已经到底了" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStatePulling];
        [footer setTitle:@"" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        
        
        if (option & ATFooterAutoRefresh) {
            if (self.currentPage == 0) {
                self.isRefreshing = YES;
            }
            [self footerRefreshing];
        }
        else if (option & ATFooterDefaultHidden) {
            footer.hidden = YES;
        }
        scrollView.mj_footer = footer;
    }
}
- (void)scroolToTopBeginRefresh {
    if (!self.scrollView.mj_header.isRefreshing) {
        [self.scrollView.mj_header beginRefreshing];
        dispatch_async_on_main_queue(^{
            [self.scrollView scrollToTopAnimated:NO];
        });
    }
}
- (void)headerRefreshing {
    self.isRefreshing = YES;
    self.scrollView.mj_footer.hidden = YES;
    self.currentPage = RefreshPageStart;
    [self refreshData:self.currentPage];
    self.lastRefreshDate = [NSDate date];
}

- (void)footerRefreshing {
    self.currentPage++;
    [self refreshData:self.currentPage];
}

- (void)endRefreshFailure {
    if (self.currentPage > RefreshPageStart) {
        self.currentPage--;
    }
    [self baseEndRefreshing];
    if (self.scrollView.mj_footer.isRefreshing) {
        self.scrollView.mj_footer.state = MJRefreshStateIdle;
    }
}
- (void)baseEndRefreshing {
    if (self.scrollView.mj_header.isRefreshing) {
        [self.scrollView.mj_header endRefreshing];
    }
    self.isRefreshing = NO;
}
- (void)endRefresh:(BOOL)hasMore {
    [self baseEndRefreshing];
    
    if (hasMore) {
        self.scrollView.mj_footer.state = MJRefreshStateIdle;
        ((MJRefreshAutoStateFooter *)self.scrollView.mj_footer).stateLabel.textColor = [UIColor colorWithRGB:0x666666];
        self.scrollView.mj_footer.hidden = NO;
    }
    else {
        self.scrollView.mj_footer.state = MJRefreshStateNoMoreData;
        ((MJRefreshAutoStateFooter *)self.scrollView.mj_footer).stateLabel.textColor = [UIColor colorWithRGB:0x999999];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.scrollView.mj_footer.hidden = (self.currentPage == RefreshPageStart) || (self.scrollView.contentSize.height < self.scrollView.height);
        });
    }
}
- (void)endRefreshNeedHidden:(BOOL)hasMore {
    [self baseEndRefreshing];
    
    self.scrollView.mj_footer.state = hasMore ? MJRefreshStateIdle : MJRefreshStateNoMoreData;
    self.scrollView.mj_footer.hidden = !hasMore;
}

- (void)refreshData:(NSInteger)page {
    self.currentPage = page;
    
    if ([self.className isEqualToString:[BaseRefreshController className]]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.scrollView.mj_header.isRefreshing || self.scrollView.mj_footer.isRefreshing) {
                [self endRefreshFailure];
            }
        });
    }
}

- (void)setIsRefreshing:(BOOL)isRefreshing {
    _isRefreshing = isRefreshing;
    
    if (self.scrollView.emptyDataSetVisible) {
        [self.scrollView reloadEmptyDataSet];
    }
}


#pragma mark - DZNEmptyData 空数据界面处理
- (void)setupEmpty:(UIScrollView *)scrollView {
    [self setupEmpty:scrollView image:[UIImage imageNamed:@"ic_dingdan_kongtai"] title:FDMSG_Home_DataEmpty];
}
- (void)setupEmpty:(UIScrollView *)scrollView image:(UIImage *)image title:(NSString *)title {
    scrollView.emptyDataSetSource = self;
    scrollView.emptyDataSetDelegate = self;
    self.emptyImage = image;
    self.emptyTitle = title;
    
    if (_isSetKVO) {
        return;
    }
    _isSetKVO = YES;
    [self.KVOController observe:scrollView keyPaths:@[FBKVOKeyPath(scrollView.contentSize), FBKVOKeyPath(scrollView.contentInset)] options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, UIScrollView * _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        if (object.contentOffset.y >= -object.mj_inset.top && object.emptyDataSetVisible) {
            [NSObject cancelPreviousPerformRequestsWithTarget:object selector:@selector(reloadEmptyDataSet) object:nil];
            [object performSelector:@selector(reloadEmptyDataSet) afterDelay:0.01f];
        }
    }];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary* attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName : [UIColor colorWithRGB:0x999999],
                                 NSParagraphStyleAttributeName : paragraph};
    NSString *text = self.isRefreshing ? FDMSG_Home_DataRefresh : self.emptyTitle;
    if (![self reachable]) {
        text = FDNoNetworkMsg;
    }
    return [[NSMutableAttributedString alloc] initWithString:(text ? [NSString stringWithFormat:@"\r\n%@", text] : @"")
                                                  attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    UIImage *title = self.isRefreshing ? [UIImage imageNamed:@"MGLoading_1"] : self.emptyImage;
    if (![self reachable]) {
        title = [UIImage imageNamed:@"ic_wifi_error"];
    }
    return title;
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}
- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    return nil;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return nil;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    UIEdgeInsets inset = scrollView.mj_header ? scrollView.mj_header.scrollViewOriginalInset : scrollView.contentInset;
    CGFloat contentSizeHeight = [scrollView.className isEqualToString:@"WKScrollView"] ? 0 : scrollView.contentSize.height;
    if (!_emptyView || _emptyView.superview != scrollView) {
        _emptyView = nil;
        [scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.className isEqualToString:@"DZNEmptyDataSetView"]) {
                self->_emptyView = obj;
                *stop = YES;
            }
        }];
        if (_emptyView.clipsToBounds) {
            _emptyView.clipsToBounds = NO;
        }
    }
    CGFloat offset = inset.top + contentSizeHeight + (scrollView.height - inset.top - contentSizeHeight - inset.bottom) * 0.4f - scrollView.height * 0.5f - ((CGPoint)([_emptyView convertPoint:CGPointZero toView:self.scrollView.superview])).y;
    if (scrollView.mj_header.isRefreshing) {
        offset += MJRefreshHeaderHeight;
    }
    return offset;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 1;
}

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return NO;
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (!self.isRefreshing) {
        [self headerRefreshing];
    }
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    
}
- (BOOL)reachable
{
  return  [YYReachability reachability].status != YYReachabilityStatusNone;
}

@end
