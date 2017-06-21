//
//  CLLoadingView.h
//  CALayer
//
//  Created by chunlen on 16/1/9.
//  Copyright © 2016年 chunlen. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CJLTLoadingView : UIView

+ (CJLTLoadingView *)showLoadingViewInView:(UIView *)sView;


//- (void)startLoading;
- (void)stopLoading;
@end
