//
//  BaseViewController.m
//  RefreshController
//
//  Created by 王炜圣 on 2021/8/5.
//  Copyright © 2021 王炜圣. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)dealloc{
    NSLog(@"%@",NSStringFromClass(self.class));
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}


@end
