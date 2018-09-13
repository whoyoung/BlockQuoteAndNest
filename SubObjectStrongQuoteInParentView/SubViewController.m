//
//  SubViewController.m
//  SubObjectStrongQuoteInParentView
//
//  Created by 杨虎 on 2018/9/13.
//  Copyright © 2018年 Keep. All rights reserved.
//

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) weakSelf = self;
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (!strongSelf) {
//                NSLog(@"strongSelf 被系统回收了");
//                return;
//            }
//        });
//    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.view.backgroundColor = [UIColor orangeColor];
        sleep(3);
        sleep(3);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!strongSelf) {
                NSLog(@"strongSelf 被系统回收了");
                return;
            }
        });
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"dealloc ======");
}

@end
