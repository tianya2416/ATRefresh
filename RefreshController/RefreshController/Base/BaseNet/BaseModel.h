//
//  BaseModel.h
//  RefreshController
//
//  Created by wangws1990 on 2019/6/4.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface BaseModel : NSObject<NSCoding, NSCopying,YYModel>
@property (nonatomic, copy) NSString * coverImgUrl;
@property (nonatomic, copy) NSString * gName;
@property (nonatomic, copy) NSString * cover;
@property (nonatomic, copy) NSString * editDate;
@property (nonatomic, copy) NSString * gId;
@property (nonatomic, assign) NSUInteger picNum;
@property (nonatomic, copy) NSString * subId;
@property (nonatomic, copy) NSString * voteGood;
@end

NS_ASSUME_NONNULL_END
