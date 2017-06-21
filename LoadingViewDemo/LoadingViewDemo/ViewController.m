//
//  ViewController.m
//  LoadingViewDemo
//
//  Created by Chunlen Jay on 2017/6/21.
//  Copyright © 2017年 Chunlen Jay. All rights reserved.
//
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#import "ViewController.h"
#import "CJLTLoadingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CJLTLoadingView *loadingView = [CJLTLoadingView showLoadingViewInView:self.view];
//    WS(weakSelf)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loadingView stopLoading];
    });
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
