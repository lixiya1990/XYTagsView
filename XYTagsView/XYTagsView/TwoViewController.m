
//
//  TwoViewController.m
//  XYTagsView
//
//  Created by lxy on 2017/11/30.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "TwoViewController.h"
#import "TestTableViewCell.h"
#import <Masonry/Masonry.h>


@interface TwoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tv;
@property (nonatomic ,strong) NSMutableArray *dataList;

@end

@implementation TwoViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"在表上的使用";
    
    [self.view addSubview:self.tv];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TestTableViewCell heightWithTags:self.dataList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestTableViewCell"];
    cell.dataList = self.dataList;
    return cell;
}


#pragma mark - Getters
- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = @[@"你好",@"你好01",@"你好002",@"你好003",@"你好0004",@"你好00000005",@"好",@"你好ds都看时间佛第三方",@"你好大幅度",@"你的首付多少好",@"看电视发你"].mutableCopy;
    }
    return _dataList;
}

- (UITableView *)tv {
    if (!_tv) {
        _tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tv.delegate = self;
        _tv.dataSource = self;
        [_tv registerClass:[TestTableViewCell class] forCellReuseIdentifier:@"TestTableViewCell"];
        if (@available(iOS 11.0, *)) {
            _tv.estimatedRowHeight = 0;
            _tv.estimatedSectionFooterHeight = 0;
            _tv.estimatedSectionHeaderHeight = 0;
        }
    }
    return _tv;
}

@end
