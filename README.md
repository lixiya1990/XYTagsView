# XYTagsView
基于UICollectionView实现的 热门标签view 
<br> pod 'XTagsView'

# 用法
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
