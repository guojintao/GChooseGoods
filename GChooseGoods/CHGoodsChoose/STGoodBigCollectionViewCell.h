//
//  STGoodBigCollectionViewCell.h
//  SurfingTV
//
//  Created by 郭金涛 on 16/7/29.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STGoodListCellViewModel.h"
@interface STGoodBigCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *goodsName;
@property (nonatomic, strong)UILabel *priceLabel;
- (void)setWithViewModel:(STGoodListCellViewModel *)viewModel;
@property (nonatomic, strong)STGoodListCellViewModel *viewModel;
@end
