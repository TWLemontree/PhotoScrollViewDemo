//
//  PhotoCell.m
//  横向滚动照片预览
//
//  Created by 抬头看见柠檬树 on 2017/2/22.
//  Copyright © 2017年 csip. All rights reserved.
//

#import "PhotoCell.h"

@interface PhotoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    
    self.imageView.image = [UIImage imageNamed:imageName];
}


@end
