//
//  BaseNetManager.h
//  RefreshController
//
//  Created by wangws1990 on 2019/6/3.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetTool.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseNetManager : NSObject
+ (NSURLSessionDataTask *)wallHot:(NSDictionary *)params
                          success:(void(^)(id object))success
                          failure:(void(^)(NSString *error))failure;
@end

NS_ASSUME_NONNULL_END
