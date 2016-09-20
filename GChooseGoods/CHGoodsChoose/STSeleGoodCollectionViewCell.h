//
//  STSeleGoodCollectionViewCell.h
//  SurfingTV
//
//  Created by 郭金涛 on 16/7/1.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STGoodListCellViewModel.h"
@interface STSeleGoodCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIImageView *imageV;
- (void)setWithViewModel:(STGoodListCellViewModel *)viewModel;
@property (nonatomic, strong)STGoodListCellViewModel *viewModel;

@end
