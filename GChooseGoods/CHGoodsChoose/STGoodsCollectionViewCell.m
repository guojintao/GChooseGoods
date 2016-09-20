//
//  STGoodsCollectionViewCell.m
//  SurfingTV
//
//  Created by 郭金涛 on 16/7/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "STGoodsCollectionViewCell.h"

@implementation STGoodsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}
- (void)prepareUI
{
    self.imageV = [[UIImageView alloc] init];
    self.imageV.frame = CGRectMake(0, 0, 60, 60);
    [self addSubview:self.imageV];
}

- (void)setWithViewModel:(STGoodListCellViewModel *)viewModel
{
    self.imageV.image = [UIImage imageNamed:viewModel.imageString];
}
@end
