//
//  STGoodListViewModel.m
//  SurfingTV
//
//  Created by 郭金涛 on 16/6/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "STGoodListViewModel.h"
@implementation STGoodListViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellViewModel = [NSMutableArray array];
        self.index = 0;
    }
    return self;
}
- (void)requestData
{  
    NSArray *imageStrArray = [NSArray arrayWithObjects:@"watch", @"sofa",@"shose",@"phone",@"food",@"watch", @"sofa",@"shose",@"phone",@"food",@"watch", @"sofa",@"shose",@"phone",@"food",nil];
    NSArray *nameArray = [NSArray arrayWithObjects:@"手表", @"沙发", @"鞋子", @"手机", @"食物", @"手表", @"沙发", @"鞋子", @"手机", @"食物", @"手表", @"沙发", @"鞋子", @"手机", @"食物",nil];
     NSArray *priceArray = [NSArray arrayWithObjects:@"￥23",@"￥223",@"￥43",@"￥55",@"￥66",@"￥23",@"￥223",@"￥43",@"￥55",@"￥66",@"￥23",@"￥223",@"￥43",@"￥55",@"￥66", nil];
    for (int i = 0; i < 12; i ++) {
        STGoodListCellViewModel *cellViewModel = [[STGoodListCellViewModel alloc] init];
        cellViewModel.goodsName = nameArray[i];
        cellViewModel.goodsPrice = priceArray[i];
        cellViewModel.imageString = imageStrArray[i];
        [self.cellViewModel addObject:cellViewModel];
    }
}

@end
