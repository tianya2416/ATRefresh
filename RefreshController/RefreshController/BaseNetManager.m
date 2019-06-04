//
//  BaseNetManager.m
//  RefreshController
//
//  Created by wangws1990 on 2019/6/3.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseNetManager.h"
#define URL_Wall       @"http://sj.zol.com.cn/"
#define kUrlWall(url)       [NSString stringWithFormat:@"%@%@", URL_Wall, url]
@implementation BaseNetManager
+ (NSURLSessionDataTask *)wallHot:(NSDictionary *)params
                          success:(void(^)(id object))success
                          failure:(void(^)(NSString *error))failure{
    //宝贝
    return [AFRequestTool method:HttpMethodPost serializer:HttpSerializeDefault urlString:kUrlWall(@"corp/bizhiClient/getGroupInfo.php?isAttion=1") params:params timeOut:10 success:success failure:^(NSError * _Nonnull error) {
        !failure ?: failure(error.description);
    }]

}
@end
