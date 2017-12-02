//
//  ViewController.m
//  XYTagsView
//
//  Created by lxy on 2017/11/17.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tv;
@property (nonatomic ,strong) NSMutableArray *dataList;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"XTagsView使用";
    
    [self.view addSubview:self.tv];

 
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataList[indexPath.row][@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[NSClassFromString(self.dataList[indexPath.row][@"viewController"]) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getters
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[@{@"title":@"view上显示",@"viewController":@"OneViewController"}, @{@"title":@"表单上显示",@"viewController":@"TwoViewController"}].mutableCopy;
    }
    return _dataList;
}

- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tv.delegate = self;
        _tv.dataSource = self;
        [_tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        if (@available(iOS 11.0, *)) {
            _tv.estimatedRowHeight = 0;
            _tv.estimatedSectionFooterHeight = 0;
            _tv.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tv;
}

@end
