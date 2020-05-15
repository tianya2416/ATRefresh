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
    [self yy_modelEncodeWithCoder:aCoder];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super yy_modelInitWithCoder:aDecoder];
    
    return self;
}
- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}
- (NSUInteger)hash {
    return [self yy_modelHash];
}
- (BOOL)isEqual:(id)object {
    return [self yy_modelIsEqual:object];
}
- (NSString *)description {
    return [self yy_modelDescription];
}
@end
