//
//  STGoodListViewModel.h
//  SurfingTV
//
//  Created by 郭金涛 on 16/6/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STGoodListCellViewModel.h"


@interface STGoodListViewModel : NSObject
@property (nonatomic, strong)NSMutableArray <STGoodListCellViewModel *>*cellViewModel;
@property (nonatomic, assign)NSInteger index;
@property (nonatomic, assign)BOOL isFinish;
@property (nonatomic, strong)NSString *productId;
- (void)requestData;
@end
