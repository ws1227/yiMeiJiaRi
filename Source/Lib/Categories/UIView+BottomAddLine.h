//
//  UIView+BottomAddLine.h
//  Doctors
//
//  Created by 王森 on 16/4/22.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BottomAddLine)
/**
 *  UIView底部加1像素的横线
 *
 *  @param headint 头部空余距离
 *  @param tailInt 尾部空余距离
 *  @param color   颜色
 */
-(void)addBottomLine:(int )weight HeadIndent:(int )headint tailIndent:(int )tailInt color:(UIColor *)color;


@end
