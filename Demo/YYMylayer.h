//
//  YYMylayer.h
//  CustomLayerViewController
//
//  Created by 付晓强 on 16/4/18.
//  Copyright © 2016年 付晓强. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface YYMylayer : CALayer
@property(nonatomic,strong)NSMutableArray   *points;
@property(nonatomic,strong)NSArray          *point_all;
@property(nonatomic,assign)CGFloat          lineWidth;
@end
