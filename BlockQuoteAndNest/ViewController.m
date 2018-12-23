//
//  ViewController.m
//  BlockQuoteAndNest
//
//  Created by 杨虎 on 2018/9/13.
//  Copyright © 2018年 Keep. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"Hello World!" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showTestVC) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, ScreenWidth, 30);
    btn.center = CGPointMake(ScreenWidth / 2.0, ScreenHeight / 2.0);
    [self.view addSubview:btn];
}

- (void)showTestVC{
    [self presentViewController:[[SubViewController alloc] init] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
