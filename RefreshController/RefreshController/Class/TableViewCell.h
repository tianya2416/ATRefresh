//
//  TableViewCell.h
//  RefreshController
//
//  Created by wangws1990 on 2019/6/3.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UIImageView *imaeV;

@end

NS_ASSUME_NONNULL_END
