//
//  BaseModel.m
//  RefreshController
//
//  Created by wangws1990 on 2019/6/4.
//  Copyright © 2019 王炜圣. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    return [self modelInitWithCoder:aDecoder];
}
- (id)copyWithZone:(NSZone *)zone {
    return [self modelCopy];
}
- (NSUInteger)hash {
    return [self modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self modelIsEqual:object];
}
- (NSString *)description {
    return [self modelDescription];
}
@end
