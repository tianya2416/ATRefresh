//
//  ViewController.m
//  RefreshController
//
//  Created by tianya on 2018/8/24.
//  Copyright © 2018年 tianya. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "CollectionController.h"
@interface ViewController ()
@property (strong, nonatomic) NSArray *listData;
@property (strong, nonatomic) UISegmentedControl *segmentedControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.titleView = self.segmentedControl;
    [self setupRefresh:self.tableView option:ATRefreshNone];
}

- (void)refreshData:(NSInteger)page{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.listData = @[@"普通请求",@"集成下拉刷新",@"集成上拉加载",@"集成上拉加载/下拉刷新"];
        [self.tableView reloadData];
        [self endRefresh:NO];
    });
}
- (void)segmentAction:(UISegmentedControl *)sender{
    
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
    return 60;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc  = self.segmentedControl.selectedSegmentIndex == 0 ? [TableViewController vcWithRefreshLoad:indexPath.row] : [CollectionController vcWithRefreshLoad:indexPath.row];
    [vc showNavTitle:self.listData[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}
- (UISegmentedControl *)segmentedControl{
    if (!_segmentedControl) {
        _segmentedControl= [[UISegmentedControl alloc] initWithItems:@[@"UITableView",@"UICollectionView"]];
        [_segmentedControl setFrame:CGRectMake(0, 0, 150, 30)];
        
        [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    return _segmentedControl;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
