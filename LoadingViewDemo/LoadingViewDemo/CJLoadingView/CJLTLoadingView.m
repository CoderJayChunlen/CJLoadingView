//
//  CLLoadingView.m
//  CALayer
//
//  Created by chunlen on 16/1/9.
//  Copyright © 2016年 chunlen. All rights reserved.
//


#import "CJLTLoadingView.h"
@interface CJLTLoadingView ()

@property (nonatomic , weak) UIImageView *imageView;
@property (nonatomic , weak) UIImageView *loadingImageView;

@property (nonatomic , weak) CAReplicatorLayer *replicatorLayer;
@property (nonatomic , weak) NSTimer *timeoutTimer; //心跳定时器

@end
@implementation CJLTLoadingView
- (instancetype)initWithFrame:(CGRect)frame InSView:(UIView *)sView{
    if (self = [super initWithFrame:frame]) {
        [sView addSubview:self];
        _timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(loadingTimeout) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timeoutTimer forMode:NSRunLoopCommonModes];

        [self startLoading];
    }
    return self;
}

+ (CJLTLoadingView *)showLoadingViewInView:(UIView *)sView;
{
    
    return  [[self alloc] initWithFrame:[UIScreen mainScreen].bounds InSView:sView];
}
- (void)loadingTimeout{
    [self stopLoading];
}
- (void)showLoadingImage{
    UIImageView *loadiingImageV = [[UIImageView alloc] init];
    loadiingImageV.frame = CGRectMake(0, 0, 60, 60);
    loadiingImageV.center = self.center;
    
    loadiingImageV.animationImages = @[
                                       [UIImage imageNamed:@"1"],
                                       [UIImage imageNamed:@"2"],
                                       [UIImage imageNamed:@"3"],
                                       [UIImage imageNamed:@"4"],
                                       [UIImage imageNamed:@"5"],
                                       [UIImage imageNamed:@"6"],
                                       [UIImage imageNamed:@"7"],
                                       [UIImage imageNamed:@"8"]];
    loadiingImageV.animationDuration = 1.8;
    [loadiingImageV startAnimating];
    _loadingImageView =loadiingImageV;
    [self addSubview:_loadingImageView];
    
}
- (void)startLoading{
//    [self animationImageStart];
    [self animationCycleStart];
}
- (void)animationImageStart{
    [self showLoadingImage];
}
- (void)animationCycleStart{
    [self addReplicatorLayer];
    [_imageView.layer removeAllAnimations];
    [_replicatorLayer removeAllAnimations];
    [_replicatorLayer removeFromSuperlayer];
    [_imageView removeFromSuperview];
    [self addImageView];
    [self addReplicatorLayer];
    [self animation2];

}
- (void)addImageView {
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView = imageView;
}

- (void)addReplicatorLayer {
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    
    replicatorLayer.bounds = CGRectMake(0, 0, 350, 350);//控制半径大小
    replicatorLayer.position = self.center;
    
    
    replicatorLayer.preservesDepth = YES;    
    [replicatorLayer addSublayer:_imageView.layer];
    [self.layer addSublayer:replicatorLayer];
    _replicatorLayer = replicatorLayer;
    
}

- (void)animation2{
    
    _imageView.frame = CGRectMake(172, 200, 20, 20);
    _imageView.backgroundColor = [UIColor colorWithRed:237.0/255.0 green:198.0/255.0 blue:107.0/255.0 alpha:1.0];
    _imageView.layer.cornerRadius = 10;
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
    
    CGFloat count = 10.0;
    _replicatorLayer.instanceDelay = 1.0 / count;
    _replicatorLayer.instanceCount = count;
    //相对于_replicatorLayer.position旋转
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation((2 * M_PI) / count, 0, 0, 1.0);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1;
    animation.repeatCount = MAXFLOAT;
    //    animation.autoreverses = YES;
    //从原大小变小时,动画 回到原状时不要动画
    animation.fromValue = @(1);
    animation.toValue = @(0.01);
    [_imageView.layer addAnimation:animation forKey:nil];
}

- (void)stopLoading{
    [_timeoutTimer invalidate];
    _timeoutTimer = nil;
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        
        [self animationImageStop];
//        [self animationCycleStop];
        [self removeFromSuperview];
    }];
    
}
- (void)animationImageStop{
    [_loadingImageView stopAnimating];
    [_loadingImageView removeFromSuperview];
}
- (void)animationCycleStop{
    [_imageView.layer removeAllAnimations];
    [_replicatorLayer removeAllAnimations];
    [_replicatorLayer removeFromSuperlayer];
    [_imageView removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
