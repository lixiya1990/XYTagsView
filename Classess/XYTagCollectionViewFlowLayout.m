//
//  XYTagCollectionViewFlowLayout.m
//  ALW_App框架
//
//  Created by lxy on 2017/9/7.
//  Copyright © 2017年 lxy. All rights reserved.
//

#import "XYTagCollectionViewFlowLayout.h"

@class XYTagCollectionViewFlowLayout;
@protocol XYTagCollectionViewFlowLayoutDelegate <NSObject>

/**获取item大小*/
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(XYTagCollectionViewFlowLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface XYTagCollectionViewFlowLayout ()
@property (nonatomic ,weak) id<XYTagCollectionViewFlowLayoutDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *itemAttributes;
@property (nonatomic, assign) CGFloat contentHeight;
@property (nonatomic, assign) CGFloat contentWidth;

@end

@implementation XYTagCollectionViewFlowLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self == [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    if (self == [super init]) {
        [self setUp];
    }
    return self;
}

/* 默认值设置 */
- (void)setUp {
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.itemSize = CGSizeMake(100.0f, 34.0f);
    self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f,10.0f, 10.0f);
    self.minimumLineSpacing = 10.0f;
    self.minimumInteritemSpacing = 10.0f;
}

#pragma mark - 
/* 布局 */
- (void)prepareLayout {
    [super prepareLayout];

    [self.itemAttributes removeAllObjects];
    self.contentWidth = 0;
    self.contentHeight = 0;
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger item = 0; item<itemCount; item++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
        CGSize size = [self itemSizeForIndexPath:indexPath];

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            if (originX + size.width + self.sectionInset.right > self.collectionView.frame.size.width) {
                originX = self.sectionInset.left;
                originY += size.height + self.minimumLineSpacing;
                
                self.contentHeight += self.minimumLineSpacing + size.height;
            }else{
                self.contentHeight = originY + size.height;
            }

        }else{
            self.contentWidth = originX + size.width;
        }
        

        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attr.frame = CGRectMake(originX, originY, size.width, size.height);
        [self.itemAttributes addObject:attr];
        
        
        originX += size.width + self.minimumInteritemSpacing;

    }
    
    if (itemCount>0) {
        self.contentWidth += self.sectionInset.right;
        self.contentHeight += self.sectionInset.bottom;
    }

}

- (CGSize)collectionViewContentSize {
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
        
    }else{
        return CGSizeMake(self.contentWidth, self.collectionView.frame.size.height);
    }
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self.itemAttributes objectAtIndex:indexPath.row];
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray *attrs = [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings) {
        return CGRectIntersectsRect(rect, evaluatedObject.frame);
    }]];
    return attrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    return NO;
}


#pragma mark - Private
- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
    return self.itemSize;
}


#pragma mark - Getters
- (NSMutableArray *)itemAttributes {
    if (!_itemAttributes) {
        _itemAttributes = [NSMutableArray array];
    }
    return _itemAttributes;
}

- (id<XYTagCollectionViewFlowLayoutDelegate>)delegate {
    if (!_delegate) {
        _delegate = (id<XYTagCollectionViewFlowLayoutDelegate>)self.collectionView.delegate;
    }
    return _delegate;
}

@end
