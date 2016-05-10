//
//  UIView+BottomAddLine.m
//  Doctors
//
//  Created by 王森 on 16/4/22.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "UIView+BottomAddLine.h"

@implementation UIView (BottomAddLine)

-(void)addBottomLine:(int )weight HeadIndent:(int )headint tailIndent:(int )tailInt color:(UIColor *)color
{

    UIImageView *image=[[UIImageView alloc ]init];
//    NSLog(@"==%f",self.width);
//    image.frame=CGRectMake(headint, self.height, weight-headint-tailInt, 1);
    if (color==nil) {
        color=UIColorFromRGB(0xe5e5e5);
    }
    image.backgroundColor=color;
    
    [self addSubview:image];
    
}

@end
