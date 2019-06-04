//
//  BaseCollectionController.h
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "BaseRefreshController.h"

@interface BaseCollectionController : BaseRefreshController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end
