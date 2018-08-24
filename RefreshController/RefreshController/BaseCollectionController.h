//
//  BaseCollectionController.h
//  RefreshController
//
//  Created by 王炜圣 on 2018/8/24.
//  Copyright © 2018年 王炜圣. All rights reserved.
//

#import "BaseRefreshController.h"

@interface BaseCollectionController : BaseRefreshController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end
