//
//  XTagsView.h
//  ALW_App框架
//
//  Created by lxy on 2017/9/7.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTagCollectionViewFlowLayout.h"
#import "XTagAttribute.h"

@class XTagsView;
@protocol XTagsViewDelegate <NSObject>
- (void)tagsView:(XTagsView *)tagsView didSelectItemAtIndex:(NSInteger)index;
@end

@interface XTagsView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic ,weak) id<XTagsViewDelegate> delegate;
@property (nonatomic ,strong) NSMutableArray<NSString *> *tags;

@property (nonatomic ,strong) NSMutableArray<NSString *> *selectTags;
/** 是否允许多选 默认为否 */
@property (nonatomic ,assign) BOOL allowsMultipleSelection;
/** 是否可滚动 */
@property (nonatomic ,assign) BOOL scrollEnabled;

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) XYTagCollectionViewFlowLayout *layout;
@property (nonatomic ,strong) XTagAttribute *tagAttribute;

/** 指定 XYTagCollectionViewFlowLayout 初始化 */
- (instancetype)initWithLayout:(XYTagCollectionViewFlowLayout *)layout;

/** 刷新 */
- (void)reloadData;

/**
 计算 XTagsView 的高度,注意需要提前计算高度时传入的 XYTagCollectionViewFlowLayout 要和初始化时的 XYTagCollectionViewFlowLayout 一样

 @param tags 数据源
 @param tagAttribute 标签属性 默认为nill
 @param layout 布局 默认为nill
 @param width XTagsView的宽度
 @return XTagsView的高度
 */
+ (CGFloat)heightForXYTagsViewWithTags:(NSMutableArray<NSString *> *)tags tagAttribute:(XTagAttribute *)tagAttribute layout:(XYTagCollectionViewFlowLayout *)layout width:(CGFloat)width;

@end

