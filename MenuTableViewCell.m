//
//  MenuTableViewCell.m
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "MenuTableViewCell.h"
#import "JZMTBtnView.h"

@implementation MenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    //平台特卖模型布局。每个条目的高度为50
    //这里的所有条目布局都用浮动布局，是为了展示浮动布局的使用。但实际中可以使用其他的布局。
    CGFloat itemHeight = 72*SHIJI_HEIGHT;
    self.backgroundColor=[UIColor whiteColor];
    
    NSArray *array=@[@"icon",@"icon1",@"icon2",@"icon3"];
    NSArray *array2=@[@"怡会员",@"去度假",@"目的地",@"聚好玩"];

    for (int i = 0; i <array.count ; i++) {
        CGRect frame = CGRectMake(i*SCREEN_WIDTH/4, 0, SCREEN_WIDTH/4, itemHeight);
        NSString *title =array2[i];
        
        NSString *imageStr =array[i];
        JZMTBtnView *btnView = [[JZMTBtnView alloc] initWithFrame:frame title:title imageStr:imageStr];
        btnView.tag = 10+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
        [btnView addGestureRecognizer:tap];

        [self.contentView addSubview:btnView];
        
    }
    
    ALLOC(UIImageView , imageView);
    imageView.backgroundColor=UIColorFromRGB(0xf4f4f4);
    FRAME(imageView, 0, 130*SHIJI_HEIGHT-SHIJI_HEIGHT*10, SCREEN_WIDTH, 10*SHIJI_HEIGHT);
    [self.contentView addSubview:imageView];
    
    
    // Initialization code
}



-(void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
