//
//  STGoodBigCollectionViewCell.m
//  SurfingTV
//
//  Created by 郭金涛 on 16/7/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "STGoodBigCollectionViewCell.h"

@implementation STGoodBigCollectionViewCell
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
    self.imageV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 140, [UIScreen mainScreen].bounds.size.width - 140);
    [self addSubview:self.imageV];
    
    //商品名称
    self.goodsName = [[UILabel alloc] initWithFrame:CGRectMake(0, self.imageV.frame.origin.y + self.imageV.frame.size.height + 10, self.imageV.frame.size.width, 20)];
    self.goodsName.textColor = [UIColor grayColor];
    self.goodsName.textAlignment = NSTextAlignmentCenter;
    self.goodsName.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.goodsName];
    //商品价格
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.goodsName.frame.origin.y + self.goodsName.frame.size.height , self.goodsName.frame.size.width, 20)];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.textAlignment = NSTextAlignmentCenter;
    self.priceLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.priceLabel];
}
- (void)setWithViewModel:(STGoodListCellViewModel *)viewModel
{
    self.viewModel = viewModel;
    self.goodsName.text = viewModel.goodsName;
    self.priceLabel.text = viewModel.goodsPrice;
    self.imageV.image = [UIImage imageNamed:viewModel.imageString];
}
@end
