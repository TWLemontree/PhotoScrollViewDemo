//
//  TWLayout.h
//  横向滚动照片预览
//
//  Created by 抬头看见柠檬树 on 2017/2/22.
//  Copyright © 2017年 csip. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    * 由于系统的UICollectionViewFlowLayout无法实现我想要的效果，因此我重写下该类中的某些方法。
    * 在UICollectionViewLayout中有这样两句注释：
 
    * Methods in this class are meant to be overridden and will be called by its collection view to gather layout information.
      在这个类中的方法意味着被重写（overridden），并且将要被它的 collection view 调用，用于收集布局信息
 
    * To get the truth on the current state of the collection view, call methods on UICollectionView rather than these.
      要获取 collection view 的当前状态的真相，调用UICollectionView上的方法，而不是这些
 */

@interface TWLayout : UICollectionViewFlowLayout

@end
