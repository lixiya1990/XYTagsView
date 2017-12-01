//
//  XTagCell.m
//  ALW_App框架
//
//  Created by lxy on 2017/9/7.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "XTagCell.h"

@implementation XTagCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLab];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLab.frame = self.contentView.bounds;
}


- (void)setSelected:(BOOL)selected {

}

#pragma mark - Getters
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLab;
}

@end
