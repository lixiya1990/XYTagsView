//
//  TestTableViewCell.m
//  XYTagsView
//
//  Created by lxy on 2017/11/30.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "TestTableViewCell.h"
#import <Masonry/Masonry.h>


@implementation TestTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _v_1 = [[XTagsView alloc] init];
        _v_1.scrollEnabled = NO;
        _v_1.userInteractionEnabled = NO;
        _v_1.tagAttribute = [[self class] attribute];
        _v_1.layout = [[self class] layout];
        _v_1.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_v_1];
        
        [_v_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@20);
            make.right.equalTo(@-20);
            make.top.equalTo(@20);
            make.bottom.equalTo(@-20);
        }];
        
        
    }
    return self;
}

#pragma mark - Setters
- (void)setDataList:(NSMutableArray *)dataList {
    _dataList = dataList;
    
    _v_1.tags = dataList;
    [_v_1 reloadData];
}

#pragma mark - XTagsView相关配置
+ (XYTagCollectionViewFlowLayout *)layout {
    
    XYTagCollectionViewFlowLayout *layout = [[XYTagCollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake(100.0f, 40.0f);//这里设置高度，设置宽度没用
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f,10.0f, 10.0f);
    layout.minimumLineSpacing = 10.0f;
    layout.minimumInteritemSpacing = 10.0f;
    
    return layout;
}

+ (XTagAttribute *)attribute {
    
    XTagAttribute *attribute = [[XTagAttribute alloc] init];
    attribute.borderWidth = 1.0f;
    attribute.borderColor =  [UIColor redColor];
    attribute.cornerRadius = 5.0;
    attribute.normalBackgroundColor = [UIColor whiteColor];
    attribute.titleFont = [UIFont systemFontOfSize:14];
    attribute.textColor = [UIColor redColor];
    attribute.tagSpace = 30;
    
    return attribute;
}

+ (CGFloat)heightWithTags:(NSMutableArray *)tags {
    CGFloat height = [XTagsView heightForXYTagsViewWithTags:tags tagAttribute:[[self class] attribute] layout:[[self class] layout] width:[UIScreen mainScreen].bounds.size.width - 20*2] + 20*2;
    return height;
}

@end
