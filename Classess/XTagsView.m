//
//  XTagsView.m
//  ALW_App框架
//
//  Created by lxy on 2017/9/7.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "XTagsView.h"
#import "XTagCell.h"

static NSString * const KCellIdentifier = @"XTagCell";

@interface XTagsView ()
@property (nonatomic ,assign) CGSize contentSize;
@end

@implementation XTagsView

#pragma mark - Init
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithLayout:(XYTagCollectionViewFlowLayout *)layout {
    self = [super init];
    if (self) {
        self.layout = layout;
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    
    _contentSize = CGSizeMake(0, 0);
}

- (void)dealloc {
    NSLog(@"--释放了---");
}

#pragma mark - Override
/* 系统首次调用 intrinsicContentSize 的时机可能比 layoutSubviews 要早，即在 view 的布局之前调用
    
   -invalidateIntrinsicContentSize 通知外界改 view 内容大小发生变化，继而系统调用 intrinsicContentSize 改变自身 size，从而 view 的 frame 发生改变，系统接着调用 layoutSubviews 更新其子 view 的布局
 */
- (CGSize)intrinsicContentSize {
    NSLog(@"-- intrinsicContentSize --");
    NSLog(@"---%@",NSStringFromCGSize(_contentSize));
    return _contentSize;
}


/* layoutSubviews 会调用2次
  1.自身添加到其他view上时触发一次
  2.自身初始化时，“[self addSubview:self.collectionView]”会触发一次（不添加不触发）

  * layoutSubviews 执行时机，首先自身添加到其他view上，系统执行 intrinsicContentSize--->layoutSubviews--->layoutSubviews(执行 addSubview 时)
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"-- layoutSubviews --");

    if (!CGRectEqualToRect(self.bounds, self.collectionView.frame)) {
        self.collectionView.frame = self.bounds;
        [self _updateTagsViewLayout];
    }
}

#pragma mark - Private
/* 根据数据源 计算高度 更新布局 */
- (void)_updateTagsViewLayout {
    if (self.tags && self.bounds.size.width != 0) {
        CGFloat height = [[self class] heightForXYTagsViewWithTags:self.tags tagAttribute:self.tagAttribute layout:self.layout width:self.bounds.size.width];
        _contentSize = CGSizeMake(self.bounds.size.width, height);
        if (!CGSizeEqualToSize(_contentSize, self.bounds.size)) {
            [self invalidateIntrinsicContentSize];
        }
    }
}

#pragma mark - Public
- (void)reloadData {
    [self.collectionView reloadData];
    
    // 1.标记为需要重新布局（后续会异步刷新布局）  2.立即刷新布局
    //[self setNeedsLayout];
    //[self layoutIfNeeded];
    
    [self _updateTagsViewLayout];
}


#pragma mark - XYTagCollectionViewFlowLayoutDelegate && UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.tags.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(XYTagCollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize maxSize = CGSizeMake(self.frame.size.width - collectionViewLayout.sectionInset.left - collectionViewLayout.sectionInset.right, collectionViewLayout.itemSize.height);
    CGRect frame = [self.tags[indexPath.item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.tagAttribute.titleFont} context:nil];

    return CGSizeMake(frame.size.width + self.tagAttribute.tagSpace, collectionViewLayout.itemSize.height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCellIdentifier forIndexPath:indexPath];
    
    cell.layer.cornerRadius = self.tagAttribute.cornerRadius;
    cell.layer.borderWidth = self.tagAttribute.borderWidth;
    cell.titleLab.font = self.tagAttribute.titleFont;
    
    cell.titleLab.text = self.tags[indexPath.item];
    
    if ([self.selectTags containsObject:self.tags[indexPath.item]]) {
        cell.backgroundColor = self.tagAttribute.textColor;
        cell.layer.borderColor = self.tagAttribute.borderColor.CGColor;
        cell.titleLab.textColor = [UIColor whiteColor];

    }else{
        cell.backgroundColor = self.tagAttribute.normalBackgroundColor;
        cell.layer.borderColor = self.tagAttribute.borderColor.CGColor;
        cell.titleLab.textColor = self.tagAttribute.textColor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
    XTagCell *cell = (XTagCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([self.selectTags containsObject:self.tags[indexPath.item]]) {
        cell.backgroundColor = self.tagAttribute.normalBackgroundColor;
        cell.layer.borderColor = self.tagAttribute.borderColor.CGColor;
        cell.titleLab.textColor = self.tagAttribute.textColor;
        
        [self.selectTags removeObject:self.tags[indexPath.item]];
    }else{
        if (!self.allowsMultipleSelection) {
            [self.selectTags removeAllObjects];
        }
        
        [self.selectTags addObject:self.tags[indexPath.item]];
        [self.collectionView reloadData];
    }


    if (self.delegate && [self.delegate respondsToSelector:@selector(tagsView:didSelectItemAtIndex:)]) {
        [self.delegate tagsView:self didSelectItemAtIndex:indexPath.item];
    }
    
}

#pragma mark - Setters
- (void)setTags:(NSMutableArray<NSString *> *)tags {
    _tags = tags;
    
    [self reloadData];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    self.collectionView.scrollEnabled = scrollEnabled;
}

#pragma mark - Getters
/* 初始化时，可不设置尺寸大小，在 layoutSubviews 中设置的才是最终的大小 */
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[XTagCell class] forCellWithReuseIdentifier:KCellIdentifier];
    }
    _collectionView.collectionViewLayout = self.layout;
    return _collectionView;
}

- (XYTagCollectionViewFlowLayout *)layout {
    if (!_layout) {
        _layout = [[XYTagCollectionViewFlowLayout alloc] init];
    }
    return _layout;
}

- (XTagAttribute *)tagAttribute {
    if (!_tagAttribute) {
        _tagAttribute = [[XTagAttribute alloc] init];
    }
    return _tagAttribute;
}

- (NSMutableArray<NSString *> *)selectTags {
    if (!_selectTags) {
        _selectTags = [NSMutableArray array];
    }
    return _selectTags;
}


#pragma mark - 
+ (CGFloat)heightForXYTagsViewWithTags:(NSMutableArray<NSString *> *)tags tagAttribute:(XTagAttribute *)tagAttribute layout:(XYTagCollectionViewFlowLayout *)layout width:(CGFloat)width{
    
    if (tags.count == 0) {
        return 0;
    }
    
    if (!tagAttribute) {
        tagAttribute = [[XTagAttribute alloc] init];
    }
    
    if (!layout) {
        layout = [[XYTagCollectionViewFlowLayout alloc] init];
    }
    
    
    CGFloat contentHeight = 0;
    
    CGFloat originX = layout.sectionInset.left;
    CGFloat originY = layout.sectionInset.top;
    
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        CGSize maxSize = CGSizeMake(width - layout.sectionInset.left - layout.sectionInset.right, layout.itemSize.height);
        for (NSInteger item = 0; item<tags.count; item++) {
            
            CGRect frame = [tags[item] boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: tagAttribute.titleFont} context:nil];
            CGSize itemSize = CGSizeMake(frame.size.width + tagAttribute.tagSpace, layout.itemSize.height);
            
            if (originX + itemSize.width + layout.sectionInset.right > width) {
                originX = layout.sectionInset.left;
                originY += itemSize.height + layout.minimumLineSpacing;
                
                contentHeight += layout.minimumLineSpacing + itemSize.height;
            }else{
                contentHeight = originY + itemSize.height;
            }
            
            originX += itemSize.width + layout.minimumInteritemSpacing;
        }

    }else if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        contentHeight += originY + layout.itemSize.height;
    }
    
    contentHeight += layout.sectionInset.bottom;
    return contentHeight;
}



@end
