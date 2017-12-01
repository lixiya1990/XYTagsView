//
//  XTagAttribute.m
//  ALW_App框架
//
//  Created by lxy on 2017/9/7.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "XTagAttribute.h"

@implementation XTagAttribute

- (instancetype)init {
    if (self == [super init]) {
        int r = arc4random() % 255;
        int g = arc4random() % 255;
        int b = arc4random() % 255;
        
        UIColor *normalColor = [UIColor colorWithRed:b/255.0 green:r/255.0 blue:g/255.0 alpha:1.0];
        UIColor *normalBackgroundColor = [UIColor whiteColor];
        //UIColor *selectedBackgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        
        _borderWidth = 1.0f;
        _borderColor = normalColor;
        _cornerRadius = 5.0;
        _normalBackgroundColor = normalBackgroundColor;
        //_selectedBackgroundColor = selectedBackgroundColor;
        _titleFont = [UIFont systemFontOfSize:14];
        _textColor = normalColor;
        _tagSpace = 20;
    }
    return self;
}

@end
