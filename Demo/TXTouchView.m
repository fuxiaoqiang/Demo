//
//  TXTouchView.m
//  Demo
//
//  Created by 刘绍殚 on 16/4/17.
//  Copyright © 2016年 刘绍殚. All rights reserved.
//

#import "TXTouchView.h"
#import "YYMylayer.h"
//asdasdasd
@interface TXTouchView ()
{
    CGContextRef    context;        //上下文
}

@property(nonatomic,strong)NSMutableArray   *points;
@property(nonatomic,strong)NSArray          *point_all;

@end

@implementation TXTouchView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    
    return self;
}

-(void)setPaintColor:(UIColor *)paintColor
{
    _paintColor = paintColor;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    YYMylayer *layer=[YYMylayer layer];
    //2.设置layer的属性
    layer.backgroundColor=[UIColor brownColor].CGColor;
    layer.bounds=CGRectMake(0, 0, 200, 150);
    layer.anchorPoint=CGPointZero;
    layer.position=CGPointMake(100, 100);
    layer.cornerRadius=20;
    layer.shadowColor=[UIColor blackColor].CGColor;
    layer.shadowOffset=CGSizeMake(10, 20);
    layer.shadowOpacity=1;
    
    [layer setNeedsDisplay];
    [self.layer addSublayer:layer];
    [layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    
    if (!self.points || self.points.count < 2) {
        return;
    }
    
    //获取上下文
    context = UIGraphicsGetCurrentContext();
    //设置画笔粗细
    if (self.lineWidth == 0) {
        self.lineWidth = 5.0f;
    }
    CGContextSetLineWidth(context, self.lineWidth);
    
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, self.paintColor.CGColor);
    
    //画以前的轨迹
    for (int i = 0 ; i < [self.point_all count]; i++) {
        NSMutableArray *point_temp = [self.point_all objectAtIndex:i];
        
        for (int j = 0; j < [point_temp count] - 1; j++) {
            CGPoint point1 = [[point_temp objectAtIndex:j] CGPointValue];
            CGPoint point2 = [[point_temp objectAtIndex:(j + 1)] CGPointValue];
            
            CGContextMoveToPoint(context, point1.x, point1.y);
            CGContextAddLineToPoint(context, point2.x, point2.y);
            CGContextStrokePath(context);
            
        }
    }
    
    //画这次
    for (int i = 0; i < [self.points count] - 1; i++) {
        CGPoint point1 = [[self.points objectAtIndex:i] CGPointValue];
        CGPoint point2 = [[self.points objectAtIndex:(i + 1)] CGPointValue];
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }
    
    
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:5.0];
    
    //CGContextSetLineWidth(context, 0.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    
    [UIView commitAnimations];
    
//    [UIView beginAnimations:nil context:context];
//    [UIView setAnimationDuration:1.0];
//    
//    CGContextSetAlpha(context, 1);
//    
//    [UIView commitAnimations];
//
    //[self.layer addAnimation:[self opacityForever_Animation:1] forKey:nil];
}

//不支持多点触摸
-(BOOL)isMultipleTouchEnabled
{
    return NO;
}

//创建一个array，并且记录初始point

#pragma UITouch方法

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.points = [NSMutableArray array];
//    CGPoint pt = [[touches anyObject] locationInView:self];
//    [self.points addObject:[NSValue valueWithCGPoint:pt]];
}

//移动过程中记录这些points
//调用setNeedsDisplay，会触发drawRect方法的调用
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    [self.points addObject:[NSValue valueWithCGPoint:pt]];
    [self setNeedsDisplay];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSMutableArray *point_tmp = [[NSMutableArray alloc] initWithArray:self.points];
    if (self.point_all == nil) {
        self.point_all = [[NSArray alloc] initWithObjects:point_tmp, nil];
    }
    else
    {
        self.point_all = [self.point_all arrayByAddingObject:point_tmp];
    }
    
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


@end
