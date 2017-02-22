//
//  TWLayout.m
//  横向滚动照片预览
//
//  Created by 抬头看见柠檬树 on 2017/2/22.
//  Copyright © 2017年 csip. All rights reserved.
//

#import "TWLayout.h"

@implementation TWLayout

/**
    * The default implementation of this method returns NO. Subclasses can override it and return an appropriate value based on whether changes in the bounds of the collection view require changes to the layout of cells and supplementary views.
      此方法的默认实现返回NO。 子类可以覆盖它，并根据 collection view 的 bounds 中的更改是否需要更改 cells 和 supplementary views(补充视图) 的布局返回适当的值。
 
    * If the bounds of the collection view change and this method returns YES, the collection view invalidates the layout by calling the invalidateLayoutWithContext: method.
      如果 collection view 的 bounds 更改并且此方法返回YES，则 collection view 通过调用invalidateLayoutWithContext：方法使布局无效。

 @param newBounds The new bounds of the collection view.
 @return YES if the collection view requires a layout update or NO if the layout does not need to change.
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


/**
 * Returns the layout attributes for all of the cells and views in the specified rectangle.
   返回指定矩形中所有cells和views的布局属性。

 @param rect * The rectangle (specified in the collection view’s coordinate system) containing the target views.
               包含目标视图的矩形（在集合视图的坐标系中指定）。

 @return * An array of UICollectionViewLayoutAttributes objects representing the layout information for the cells and views. The default implementation returns nil.
           UICollectionViewLayoutAttributes对象数组，表示cell和view的布局信息。默认实现返回nil。
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    CGFloat collectionW = self.collectionView.bounds.size.width;
    
    NSArray<UICollectionViewLayoutAttributes *> *attrs = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    for (int i = 0; i < attrs.count; i++) {
        UICollectionViewLayoutAttributes *attr = attrs[i];
        
        //距离中心距离
        CGFloat margin = fabs((attr.center.x - self.collectionView.contentOffset.x) - collectionW * 0.5);
        
        // 缩放比例
        CGFloat scale = 1 - (margin / (collectionW * 0.5)) * 0.35;
        
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    
    return attrs;
}


/**
 * Returns the point at which to stop scrolling.
 * 关于这个方法，最终的偏移量，并不是由手指滑动过的偏移量决定的。如果手指滑动比较快，手指滑动过后，视图还会多滚动一段距离；如果手指滑动缓慢，手指滑到何处，就停到何处。

 @param proposedContentOffset 建议的点（在集合视图的内容视图的坐标空间中）用于可见内容的左上角。 这表示集合视图计算为在动画结束时最可能使用的值。
 @param velocity 沿着水平轴和垂直轴的当前滚动速度。 该值以每秒点数为单位。
 @return 要使用的内容偏移量。 此方法的默认实现返回proposedContentOffset参数中的值。
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat collectionW = self.collectionView.bounds.size.width;
    CGPoint targetP = proposedContentOffset;
    
    // 横向滚动，所以只用考虑横向的x和width，纵向不用考虑
    NSArray *attrs = [super layoutAttributesForElementsInRect:CGRectMake(targetP.x, 0, collectionW, MAXFLOAT)];
    
    // 距离中心点的最小间距
    CGFloat minSpacing = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        // 距离中心点的偏移量
        CGFloat centerOffsetX = attr.center.x - targetP.x - collectionW * 0.5;
        if (fabs(centerOffsetX) < fabs(minSpacing)) {
            minSpacing = centerOffsetX;
        }
    }
    targetP.x += minSpacing;
    
    return targetP;
}

@end
