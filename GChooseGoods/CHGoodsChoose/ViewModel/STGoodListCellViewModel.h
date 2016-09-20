//
//  STGoodListCellViewModel.h
//  SurfingTV
//
//  Created by 郭金涛 on 16/6/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STGoodListCellViewModel : NSObject
@property (nonatomic, strong)NSString *imageString;
@property (nonatomic, strong)NSString *goodsId;
@property (nonatomic, strong)NSString *goodsName;
@property (nonatomic, strong)NSString *goodsPrice;
@property (nonatomic, strong)NSString *detailUrl;
@property (nonatomic, strong)NSString *buyUrl;
@property (nonatomic, strong)NSString *productFrom;
@property (nonatomic, strong)NSString *priceStr;

@end
