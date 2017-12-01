//
//  XTagAttribute.h
//  ALW_App框架
//
//  Created by lxy on 2017/9/7.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XTagAttribute : NSObject

/** 标签边框宽度 */
@property (nonatomic,assign) CGFloat borderWidth;
/** 标签边框颜色 */
@property (nonatomic,strong) UIColor *borderColor;
/** 标签圆角大小 */
@property (nonatomic,assign) CGFloat cornerRadius;
/** 标签默认背景颜色 */
@property (nonatomic,strong) UIColor *normalBackgroundColor;
/** 标签选中背景颜色 */
//@property (nonatomic,strong) UIColor *selectedBackgroundColor;
/** 标签字体大小 */
@property (nonatomic,strong) UIFont *titleFont;
/** 标签字体颜色 */
@property (nonatomic,strong) UIColor *textColor;
/** 标签内部左右间距(标题距离边框2边的距离和) */
@property (nonatomic,assign) CGFloat tagSpace;

@end
