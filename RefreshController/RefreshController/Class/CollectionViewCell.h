//
//  CollectionViewCell.h
//  RefreshController
//
//  Created by wangws1990 on 2019/6/3.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@end

NS_ASSUME_NONNULL_END
