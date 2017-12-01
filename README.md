# XYTagsView
基于UICollectionView实现的 热门标签view 
<br> pod 'XTagsView'

![](https://github.com/lixiya1990/XYTagsView/edit/master/XYTagsView/未命名.gif)  

# 用法，内部实现 - (CGSize)intrinsicContentSize 只需设置好约束，可自适应高度
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
    
    

# 计算高度，用于cell布局提前获取高度

/**
 计算 XTagsView 的高度,注意需要提前计算高度时传入的 XYTagCollectionViewFlowLayout 要和初始化时的 XYTagCollectionViewFlowLayout 一样

 @param tags 数据源
 @param tagAttribute 标签属性 默认为nill
 @param layout 布局 默认为nill
 @param width XTagsView的宽度
 @return XTagsView的高度
 */
+ (CGFloat)heightForXYTagsViewWithTags:(NSMutableArray<NSString *> *)tags tagAttribute:(XTagAttribute *)tagAttribute layout:(XYTagCollectionViewFlowLayout *)layout width:(CGFloat)width;
