//
//  ViewController.m
//  Demo
//
//  Created by 刘绍殚 on 16/4/17.
//  Copyright © 2016年 刘绍殚. All rights reserved.
//

#import "ViewController.h"
#import "YYMylayer.h"
#import "TXTouchView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    UILabel *myTest1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"测试动画";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    self.view.userInteractionEnabled = YES;
    
    self.touchView = [[TXTouchView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.touchView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.touchView];
    //闪烁效果。
    //[self.touchView.layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
}


#pragma mark === 永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(float)time
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];//必须写opacity才行。
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];//这是透明度。
    animation.autoreverses = YES;
    animation.duration = time;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];///没有的话是均匀的动画。
    return animation;
}

    
    
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
