//
//  STSeleGoodCollectionViewCell.m
//  SurfingTV
//
//  Created by 郭金涛 on 16/7/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "STSeleGoodCollectionViewCell.h"


@implementation STSeleGoodCollectionViewCell
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
    self.imageV.frame = CGRectMake(0, 0, 70, 70);
    [self addSubview:self.imageV];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.imageV.frame.size.width, 1)];
    label.backgroundColor = [UIColor redColor];
    [self.imageV addSubview:label];
}

- (void)setWithViewModel:(STGoodListCellViewModel *)viewModel
{
    self.imageV.image = [UIImage imageNamed:viewModel.imageString];
}
@end
