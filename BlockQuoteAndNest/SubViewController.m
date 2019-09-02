//
//  SubViewController.m
//  BlockQuoteAndNest
//
//  Created by 杨虎 on 2018/9/13.
//  Copyright © 2018年 Keep. All rights reserved.
//

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define Padding 15.0
#define BtnWidth (ScreenWidth - 4 * Padding) / 3
#define BtnHeight 50

#import "SubViewController.h"

@interface SubViewController ()

@property (nonatomic, copy) void (^testBlock)(void);

@property (nonatomic, copy) NSString *testStr;

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
    [self debugBtnIndex:7];
    [self debugBtnIndex:8];
    [self debugBtnIndex:9];
    [self debugBtnIndex:10];
    [self debugBtnIndex:11];
}

- (void)debugBtnIndex:(NSUInteger)i {
    NSString *title = [NSString stringWithFormat:@"test%ld",i];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:NSSelectorFromString(title) forControlEvents:UIControlEventTouchUpInside];
    CGFloat x = ((3 - i % 3) + 1) * Padding + (i % 3) * BtnWidth;
    CGFloat y = 80 + i / 3 * (BtnHeight + Padding);
    btn.frame = CGRectMake(x, y, BtnWidth, BtnHeight);
    [self.view addSubview:btn];
}

- (void)test1 {
    self.testBlock = ^{
        self.view.backgroundColor = [UIColor lightGrayColor];
    };
    self.testBlock();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test2 {
    __weak typeof(self) weakSelf = self;
    self.testBlock = ^{
        weakSelf.view.backgroundColor = [UIColor lightGrayColor];
    };
    
//    self.testBlock = ^{
//        weakSelf.view.backgroundColor = [UIColor lightGrayColor];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!weakSelf) {
//                NSLog(@"test2 weakSelf 被系统回收了");
//            } else {
//                NSLog(@"test2 weakSelf 我是打不死的小强");
//            }
//        });
//    };
    
//    self.testBlock = ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.view.backgroundColor = [UIColor lightGrayColor];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            if (!strongSelf) {
//                NSLog(@"test2 strongSelf 被系统回收了");
//            } else {
//                NSLog(@"test2 strongSelf 我是打不死的小强");
//            }
//        });
//    };
    
    self.testBlock();
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test3 {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0,0), ^{
        if (!self) {
            NSLog(@"test3 self 被系统回收了");
        } else {
            NSLog(@"test3 self 我是打不死的小强");
        }
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test4 {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test4 strongSelf 被系统回收了");
        } else {
            NSLog(@"test4 strongSelf 我是打不死的小强");
        }
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test5 {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test5 strongSelf 被系统回收了");
        } else {
            NSLog(@"test5 strongSelf 我是打不死的小强");
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            if (!strongSelf) {
                NSLog(@"test6 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test6 dispatch_after strongSelf 我是打不死的小强");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
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

- (void)test7 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test7 strongSelf 被系统回收了");
        } else {
            NSLog(@"test7 strongSelf 我是打不死的小强");
        }
        
        __weak typeof(self) weakSelf = strongSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                NSLog(@"test7 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test7 dispatch_after strongSelf 我是打不死的小强");
            }
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

- (void)test8 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            NSLog(@"test8 strongSelf 被系统回收了");
        } else {
            NSLog(@"test8 strongSelf 我是打不死的小强");
        }
        
        __weak typeof(self) weakSelf = strongSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            __strong typeof(self) strongSelf = weakSelf;
            if (!strongSelf) {
                NSLog(@"test8 dispatch_after strongSelf 被系统回收了");
            } else {
                NSLog(@"test8 dispatch_after strongSelf 我是打不死的小强");
                
                __weak typeof(self) weakSelf = strongSelf;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    if (!strongSelf) {
                        NSLog(@"test8 dispatch_after dispatch_after strongSelf 被系统回收了");
                    } else {
                        NSLog(@"test8 dispatch_after dispatch_after strongSelf 我是打不死的小强");
                    }
                });
            }
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}


- (void)test9 {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) self = weakSelf;
        self.view.backgroundColor = [UIColor grayColor];
        [super dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)test10 {
    __weak typeof(self) weakSelf = self;
    self.testBlock = ^{
        __strong typeof(weakSelf) self = weakSelf;
        self.view.backgroundColor = [UIColor lightGrayColor];
        //       [super dismissViewControllerAnimated:YES completion:nil]; // warning: 会内存泄露
        [self dismissViewControllerAnimated:YES completion:nil]; // pass : 无内存泄露
    };
    self.testBlock();
}


- (void)test11 {
    self.testStr = @"aTestStr";
    __weak typeof(self) weakSelf = self;
    void (^testParamBlock)(NSString *str) = ^(NSString *str) {
        __strong typeof(weakSelf) self = weakSelf;
        self.title = str;
        [super dismissViewControllerAnimated:YES completion:nil]; // pass : 无内存泄露
//        [self dismissViewControllerAnimated:YES completion:nil]; // pass : 无内存泄露
    };
    testParamBlock(self.testStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"dealloc ======");
}

@end
