//
//  CollectionController.m
//  RefreshController
//
//  Created by wangws1990 on 2019/6/3.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "CollectionController.h"
#import "CollectionViewCell.h"

@interface CollectionController ()
@property (strong, nonatomic) NSMutableArray *listData;
@property (assign, nonatomic) ATRefreshLoad refreshLoad;
@end

@implementation CollectionController
+ (instancetype)vcWithRefreshLoad:(ATRefreshLoad )refreshLoad
{
    CollectionController *vc = [[CollectionController alloc] init];
    vc.refreshLoad = refreshLoad;
    return vc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}
- (void)loadUI{
    self.listData = [@[] mutableCopy];
    switch (self.refreshLoad) {
        case ATRefreshLoadNone:
        {//无下拉刷新、无上拉加载
            [self setupEmpty:self.collectionView];
            [self setupRefresh:self.collectionView option:ATRefreshNone];
            [self headerRefreshing];
        }break;
        case ATRefreshLoadHead:
        {//有下拉刷新、无上拉加载
            [self setupEmpty:self.collectionView];
            [self setupRefresh:self.collectionView option:ATHeaderRefresh|ATHeaderAutoRefresh];
        }break;
        case ATRefreshLoadFoot:
        {//无下拉刷新、有上拉加载
            [self setupEmpty:self.collectionView];
            [self setupRefresh:self.collectionView option:ATFooterRefresh|ATFooterAutoRefresh];
        }break;
        case ATRefreshLoadDefault:
        {//有下拉刷新、有上拉加载
            [self setupEmpty:self.collectionView];
            [self setupRefresh:self.collectionView option:ATRefreshDefault];
        }break;
        default:
            break;
    }
}
- (void)refreshData:(NSInteger)page
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"start"] = @(1+(page-1)*RefreshPageSize);
    params[@"end"] = @(RefreshPageSize);
    CGRect rect = [UIScreen mainScreen].bounds;
    NSInteger width = (int) (rect.size.width * 2);
    NSInteger height = (int) (rect.size.height * 2);
    params[@"imgSize"] = [NSString stringWithFormat:@"%lix%li",(long)width,(long)height];
    
    [BaseNetManager wallHot:params success:^(id  _Nonnull object) {
        if ([object isKindOfClass:NSArray.class]) {
            NSArray *datas = [NSArray modelArrayWithClass:BaseModel.class json:object];
            if (datas) {
                [self.listData addObjectsFromArray:datas];
            }
            
            [self.collectionView reloadData];
            [self endRefresh:datas.count >= RefreshPageSize];
        }
    } failure:^(NSString * _Nonnull error) {
        [self endRefreshFailure];
    }];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listData.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1,1,1,1);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width, 80);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [CollectionViewCell cellForCollectionView:collectionView indexPath:indexPath];
    BaseModel *model = self.listData[indexPath.row];
    [cell.imageV setImageWithURL:[NSURL URLWithString:model.coverImgUrl] placeholder:[UIImage imageWithColor:[UIColor colorWithRGB:0xf6f6f6]]];
    cell.titleLab.text = model.gName ?:@"";
    cell.subTitleLab.text = [NSString stringWithFormat:@"观看次数:%@",model.voteGood ?:@"0"];
    return cell;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
@end
