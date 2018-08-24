//
//  ViewController.m
//  RefreshController
//
//  Created by 王炜圣 on 2018/8/24.
//  Copyright © 2018年 王炜圣. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
@interface ViewController ()
@property (strong, nonatomic) NSMutableArray *listData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.listData = @[@"普通请求",@"下拉刷新",@"上拉加载",@"上下加载"].mutableCopy;
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identy =@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewController * vc =[TableViewController vcWithRefreshLoad:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
