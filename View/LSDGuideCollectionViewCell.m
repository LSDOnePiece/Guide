//
//  LSDGuideCollectionViewCell.m
//  CloodForSafeHomeSecurity
//
//  Created by yosemite on 16/7/21.
//  Copyright © 2016年 刘帅. All rights reserved.
//

#import "LSDGuideCollectionViewCell.h"

@interface LSDGuideCollectionViewCell ()


@property (weak, nonatomic) UIImageView* imageView;


@end

@implementation LSDGuideCollectionViewCell


- (UIImageView*)imageView
{
    if (!_imageView) {
        UIImageView* imageView = [[UIImageView alloc] init];
        imageView.frame = [UIScreen mainScreen].bounds;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (void)setImage:(UIImage*)image
{
    _image = image;
    
    // 把数据放到空间上
    self.imageView.image = image;
}

@end
