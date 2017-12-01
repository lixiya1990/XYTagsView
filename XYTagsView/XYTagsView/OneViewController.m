//
//  OneViewController.m
//  XYTagsView
//
//  Created by lxy on 2017/11/30.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "OneViewController.h"
#import "XTagsView.h"
#import <Masonry/Masonry.h>

@interface OneViewController ()<XTagsViewDelegate> {
    
    XTagsView *_v;
    
}
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"在View上的使用";

    // 情况一 自适应高度
    _v = [[XTagsView alloc] init];
    
    _v.delegate = self;
    //_v.allowsMultipleSelection = YES;//是否可多选，默认NO
    //_v.userInteractionEnabled = NO;//只做展示功能，不可交互
    _v.backgroundColor = [UIColor lightGrayColor];
    _v.tags = @[@"你好",@"你好01",@"你好002",@"你好003",@"你好0004",@"你好00000005",@"好",@"你好ds都看时间佛第三方",@"你好大幅度",@"你的首付多少好",@"看电视发你"].mutableCopy;
    [self.view addSubview:_v];
    [_v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.top.equalTo(@100);
    }];
    
    
    
    // 情况二 指定高度
    // 超过高度默认可滚动
    XTagsView *v_1 = [[XTagsView alloc] init];
    v_1.delegate = self;
    v_1.backgroundColor = [UIColor lightGrayColor];
    v_1.tags = @[@"你好",@"你好01",@"你好002",@"你好003",@"你好0004",@"你好00000005",@"好",@"你好ds都看时间佛第三方",@"你好大幅度",@"你的首付多少好",@"看电视发你"].mutableCopy;
    [self.view addSubview:v_1];
    [v_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.top.equalTo(_v.mas_bottom).offset(50);
        make.height.equalTo(@100);
    }];
    
    
    // 情况三  自定义
    XTagAttribute *attribute = [[XTagAttribute alloc] init];
    attribute.borderWidth = 1.0f;
    attribute.borderColor =  [UIColor lightGrayColor];
    attribute.cornerRadius = 5.0;
    attribute.normalBackgroundColor = [UIColor whiteColor];
    attribute.titleFont = [UIFont systemFontOfSize:14];
    attribute.textColor = [UIColor lightGrayColor];
    attribute.tagSpace = 30;
    
    XYTagCollectionViewFlowLayout *layout = [[XYTagCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100.0f, 40.0f);//这里设置高度，设置宽度没用
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f,10.0f, 10.0f);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    
    XTagsView *v_2 = [[XTagsView alloc] init];
    v_2.layout = layout;
    v_2.tagAttribute = attribute;
    v_2.delegate = self;
    v_2.backgroundColor = [UIColor whiteColor];
    v_2.tags = @[@"你好",@"你好01",@"你好002",@"你好003",@"你好0004",@"你好00000005",@"好",@"你好ds都看时间佛第三方",@"你好大幅度",@"你的首付多少好",@"看电视发你"].mutableCopy;
    [self.view addSubview:v_2];
    [v_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.top.equalTo(v_1.mas_bottom).offset(50);
        make.height.equalTo(@100);
    }];
    
    
}


// 动态添加选中的标签
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   // _v.selectTags = @[@"你的首付多少好",@"看电视发你"].mutableCopy;
   // [_v reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - XTagsViewDelegate
- (void)tagsView:(XTagsView *)tagsView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"-- 点击了%ld个---",index);
}



@end
