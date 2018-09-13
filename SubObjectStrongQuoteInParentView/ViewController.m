//
//  ViewController.m
//  SubObjectStrongQuoteInParentView
//
//  Created by 杨虎 on 2018/9/13.
//  Copyright © 2018年 Keep. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentViewController:[[SubViewController alloc] init] animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
