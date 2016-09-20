//
//  ViewController.m
//  GChooseGoods
//
//  Created by 郭金涛 on 16/9/20.
//  Copyright © 2016年 Gjt. All rights reserved.
//

#import "ViewController.h"
#import "STGoodsListViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushChoose:(id)sender {
    STGoodsListViewController *vc = [[STGoodsListViewController alloc] initWithProductId:@"16053"];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

@end
