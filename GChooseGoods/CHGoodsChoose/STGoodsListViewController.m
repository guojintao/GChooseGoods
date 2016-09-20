//
//  STGoodsListViewController.m
//  SurfingTV
//
//  Created by 郭金涛 on 16/6/17.
//  Copyright © 2016年 Chausson. All rights reserved.
//

#import "STGoodsListViewController.h"
#import "STGoodsCollectionViewCell.h"
#import "STSeleGoodCollectionViewCell.h"
#import "STGoodBigCollectionViewCell.h"
#import "STGoodListViewModel.h"
#define IPHONE [UIScreen mainScreen].bounds.size.width
#define HEIGHTBILI [UIScreen mainScreen].bounds.size.height / 667

@interface STGoodsListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)UICollectionView *bigCollectionView;

@property (nonatomic, strong)STGoodListViewModel *viewModel;

@property (nonatomic, strong)NSString *productId;

@end

@implementation STGoodsListViewController
- (instancetype)initWithProductId:(NSString *)productId{
    if (self = [super init]) {
        self.productId = productId;
        self.view.backgroundColor = [UIColor clearColor];
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[STGoodListViewModel alloc] init];
    self.viewModel.productId = self.productId;
    [self.viewModel requestData];
    [self creatSubView];
    // Do any additional setup after loading the view.
}

- (void)creatSubView
{
    //底部透明黑色view
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    blackView.backgroundColor = [UIColor blackColor];
    blackView.alpha = 0.6;
    [self.view addSubview:blackView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [blackView addGestureRecognizer:tap];
    
    //白色view
    UIView *whitView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, self.view.frame.size.width + 35)];
    whitView.backgroundColor = [UIColor whiteColor];
    whitView.layer.masksToBounds = YES;
    whitView.layer.cornerRadius = 3;
    whitView.center = self.view.center;
    [self.view addSubview:whitView];
    //下方滑块
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    self.collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, whitView.frame.size.height - 65, whitView.frame.size.width ,70) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    //self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[STGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.collectionView registerClass:[STSeleGoodCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell1"];

    [whitView addSubview:self.collectionView];

    //大的图片
    UICollectionViewFlowLayout *bigFlowLayout=[[UICollectionViewFlowLayout alloc]init];
    bigFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    bigFlowLayout.minimumLineSpacing = 0;
    self.bigCollectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(60,60, whitView.frame.size.width - 120 ,whitView.frame.size.width - 70) collectionViewLayout:bigFlowLayout];
    self.bigCollectionView.dataSource=self;
    self.bigCollectionView.delegate=self;
    self.bigCollectionView.pagingEnabled = YES;
    self.bigCollectionView.backgroundColor = [UIColor whiteColor];
    [self.bigCollectionView registerClass:[STGoodBigCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell2"];
    self.bigCollectionView.showsHorizontalScrollIndicator = NO;
    [whitView addSubview:self.bigCollectionView];


    //上边 全部商品图标
    UIImageView *allGoodsImage = [[UIImageView alloc] initWithFrame:CGRectMake(whitView.frame.size.width / 2 - 150, 20, 300, 14)];
    [allGoodsImage setImage:[UIImage imageNamed:@"allgoodsLabel"]];
    [whitView addSubview:allGoodsImage];
    //叉的图标
    UIButton *chaBUtton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    chaBUtton.frame = CGRectMake(whitView.frame.size.width - 40, 10, 40, 40);
    [chaBUtton setImage:[UIImage imageNamed:@"dismiss"] forState:(UIControlStateNormal)];
    [chaBUtton addTarget:self action:@selector(dismissView) forControlEvents:(UIControlEventTouchUpInside)];
    [whitView addSubview:chaBUtton];
    //右边按钮
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    rightButton.frame = CGRectMake(whitView.frame.size.width - 45, self.bigCollectionView.frame.origin.y + (whitView.frame.size.width - 120) / 2, 40, 40);
    [rightButton setImage:[UIImage imageNamed:@"rightArrow"] forState:(UIControlStateNormal)];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
    [whitView addSubview:rightButton];
    //左边按钮
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    leftButton.frame = CGRectMake(20, self.bigCollectionView.frame.origin.y + (whitView.frame.size.width - 120) / 2, 40, 40);
    [leftButton setImage:[UIImage imageNamed:@"leftArrow"] forState:(UIControlStateNormal)];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:(UIControlEventTouchUpInside)];
    [whitView addSubview:leftButton];
    

}
//向右侧滑动
- (void)rightAction
{
    NSInteger index = self.viewModel.index + 1;
    if (index != self.viewModel.cellViewModel.count) {
         [self.bigCollectionView setContentOffset:CGPointMake(self.bigCollectionView.frame.size.width *index, 0)];
        self.viewModel.index = index;
        if ([self judgmentModel]) {
            CGFloat xPosition = [self calculateItemXOffsetWithIndex: index];
            
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                [self.collectionView setContentOffset:CGPointMake(xPosition, 0)];
                
            } completion:nil];
        }
        [self.collectionView reloadData];
    
    }
 
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.bigCollectionView == scrollView) {
        self.viewModel.index = self.bigCollectionView.contentOffset.x / self.bigCollectionView.frame.size.width;
        [self.collectionView reloadData];
    }
}
//向左侧滑动
- (void)leftAction
{
    if (self.viewModel.index != 0) {
        NSInteger index = self.viewModel.index - 1;
        [self.bigCollectionView setContentOffset:CGPointMake(self.bigCollectionView.frame.size.width *index, 0)];
        self.viewModel.index = index;
        if ([self judgmentModel]) {
            CGFloat xPosition = [self calculateItemXOffsetWithIndex: index];
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                [self.collectionView setContentOffset:CGPointMake(xPosition, 0)];
                
            } completion:nil];
        }
        [self.collectionView reloadData];
   
    }
  
}
- (void)dismissView
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//进入detail页面
- (void)goodDetailView
{
 

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.cellViewModel.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"UICollectionViewCell";
    static NSString * cellIdentifier1 = @"UICollectionViewCell1";
    static NSString * cellIdentifier2 = @"UICollectionViewCell2";
    if (self.bigCollectionView == collectionView) {
        STGoodBigCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier2 forIndexPath:indexPath];
        STGoodListCellViewModel *model = self.viewModel.cellViewModel[indexPath.row];
        [cell setWithViewModel:model];
        return cell;
    }
    if (self.viewModel.index == indexPath.row) {
        STSeleGoodCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier1 forIndexPath:indexPath];
        STGoodListCellViewModel *model = self.viewModel.cellViewModel[indexPath.row];
        [cell setWithViewModel:model];
        return cell;
    
    }else{
        STGoodsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        STGoodListCellViewModel *model = self.viewModel.cellViewModel[indexPath.row];
        [cell setWithViewModel:model];
        return cell;
    }
 
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bigCollectionView == collectionView) {
        
    }else{
        [self.bigCollectionView setContentOffset:CGPointMake(self.bigCollectionView.frame.size.width *indexPath.row, 0)];
        self.viewModel.index = indexPath.row;
        if ([self judgmentModel]) {
            CGFloat xPosition = [self calculateItemXOffsetWithIndex: indexPath.row];
            
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                [self.collectionView setContentOffset:CGPointMake(xPosition, 0)];
                
            } completion:nil];
        }
        [self.collectionView reloadData];
    }
}
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.bigCollectionView == collectionView) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width - 140, [UIScreen mainScreen].bounds.size.width - 90);
    }
    if (self.viewModel.index == indexPath.row) {
        return CGSizeMake(70, 70);

    }else{
        return CGSizeMake(60, 60);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)calculateItemXOffsetWithIndex:(NSUInteger)index {
    UIView *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    UIImageView *imageView =  [cell viewWithTag:1000];
    
    if (imageView) {
        
    }
    CGPoint center = cell.center;
    
    CGFloat xPosition = center.x - self.collectionView.frame.size.width/2;
    
    if (xPosition < 0) {
        xPosition = 0;
    } else if (xPosition + self.collectionView.frame.size.width > self.collectionView.contentSize.width) {
        xPosition = self.collectionView.contentSize.width - self.collectionView.frame.size.width;
    }
    
    return xPosition;
}
- (BOOL)judgmentModel
{
    if (IPHONE < 375) {
        if (self.viewModel.cellViewModel.count > 5) {
            return YES;
        }
    }
    if (IPHONE == 375) {
        if (self.viewModel.cellViewModel.count > 6) {
            return YES;
        }
    }else{
        if (self.viewModel.cellViewModel.count >= 7) {
            return YES;
        }
    }
    return NO;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
