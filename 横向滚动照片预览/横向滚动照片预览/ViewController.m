//
//  ViewController.m
//  横向滚动照片预览
//
//  Created by 抬头看见柠檬树 on 2017/2/22.
//  Copyright © 2017年 csip. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCell.h"
#import "TWLayout.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

static NSString *const cellID = @"cellID";

@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置collectionView
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    // 使用系统自带的流布局（继承自UICollectionViewLayout）
    TWLayout *layout = ({
        TWLayout *layout = [[TWLayout alloc] init];
        layout.itemSize                    = CGSizeMake(180, 180);
        layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing          = 40;
        
        
        //第一个cell和最后一个cell居中显示
        CGFloat margin = (ScreenW - 160) * 0.5;
        layout.sectionInset                = UIEdgeInsetsMake(0, margin, 0, margin);
        
        layout;
    });
    
    // 使用UICollectionView必须设置UICollectionViewLayout属性
    UICollectionView *collectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.center            = self.view.center;
        collectionView.bounds            = CGRectMake(0, 0, ScreenW, 200);
        collectionView.backgroundColor   = [UIColor brownColor];
        collectionView.dataSource        = self;
        [collectionView setShowsHorizontalScrollIndicator:NO];
        
        [self.view addSubview:collectionView];
        
        collectionView;
    });
    
    UINib *collectionNib = [UINib nibWithNibName:NSStringFromClass([PhotoCell class])
                                          bundle:nil];
    [collectionView registerNib:collectionNib
     forCellWithReuseIdentifier:cellID];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID
                                                                           forIndexPath:indexPath];
    
    cell.imageName = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
