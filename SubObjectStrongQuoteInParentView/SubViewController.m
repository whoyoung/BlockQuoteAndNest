//
//  SubViewController.m
//  SubObjectStrongQuoteInParentView
//
//  Created by 杨虎 on 2018/9/13.
//  Copyright © 2018年 Keep. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define BtnHeight 30

#import "SubViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self debugBtnIndex:1];
    [self debugBtnIndex:2];
    [self debugBtnIndex:3];
    [self debugBtnIndex:4];
    [self debugBtnIndex:5];
    [self debugBtnIndex:6];

}

- (void)debugBtnIndex:(NSUInteger)i {
    NSString *title = [NSString stringWithFormat:@"test%ld",i];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:NSSelectorFromString(title) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 80 + BtnHeight * (i-1) * 2, ScreenWidth, BtnHeight);
    [self.view addSubview:btn];
}

- (void)test1 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0,0), ^{
        if (!self) {
            NSLog(@"test1 self 被系统回收了");
        } else {
            NSLog(@"test1 self 我是打不死的小强");
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test2 {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test2 dispatch_get_main_queue strongSelf 被系统回收了");
        } else {
            NSLog(@"test2 dispatch_get_main_queue strongSelf 我是打不死的小强");
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test3 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test3 strongSelf 被系统回收了");
        } else {
            NSLog(@"test3 strongSelf 我是打不死的小强");
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            if (!strongSelf) {
                NSLog(@"test3 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test3 dispatch_after strongSelf 我是打不死的小强");
            }
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test4 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test4 strongSelf 被系统回收了");
        } else {
            NSLog(@"test4 strongSelf 我是打不死的小强");
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            if (!strongSelf) {
                NSLog(@"test4 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test4 dispatch_after strongSelf 我是打不死的小强");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                    if (!strongSelf) {
                        NSLog(@"test4 dispatch_after dispatch_after strongSelf 被系统回收了");
                    } else {
                        NSLog(@"test4 dispatch_after dispatch_after strongSelf 我是打不死的小强");
                    }
                });
            }
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test5 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test5 strongSelf 被系统回收了");
        } else {
            NSLog(@"test5 strongSelf 我是打不死的小强");
        }
        
        __weak typeof(self) weakSelf = strongSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                NSLog(@"test5 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test5 dispatch_after strongSelf 我是打不死的小强");
            }
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test6 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test6 strongSelf 被系统回收了");
        } else {
            NSLog(@"test6 strongSelf 我是打不死的小强");
        }
        
        __weak typeof(self) weakSelf = strongSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                NSLog(@"test6 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test6 dispatch_after strongSelf 我是打不死的小强");
                
                __weak typeof(self) weakSelf = strongSelf;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    if (!strongSelf) {
                        NSLog(@"test6 dispatch_after dispatch_after strongSelf 被系统回收了");
                    } else {
                        NSLog(@"test6 dispatch_after dispatch_after strongSelf 我是打不死的小强");
                    }
                });
            }
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
