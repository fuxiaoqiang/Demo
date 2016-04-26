//
//  YYMylayer.m
//  CustomLayerViewController
//
//  Created by 付晓强 on 16/4/18.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import "YYMylayer.h"

@implementation YYMylayer
{
    CGContextRef    context;        //上下文
}



 -(void)drawInContext:(CGContextRef)ctx
{
         //1.绘制图形
        //画一个圆
        CGContextAddEllipseInRect(ctx, CGRectMake(50, 50, 100, 100));
        //设置属性（颜色）
     //    [[UIColor yellowColor]set];
        CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);

        //2.渲染
        CGContextFillPath(ctx);
}

@end
