//
//  ListTableViewCell.m
//  yiMeiJiaRi
//
//  Created by 王森 on 16/5/4.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "ListTableViewCell.h"

@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.tipLabe.layer.borderColor=UIColorFromRGB(0xfdc7ba).CGColor;
    self.tipLabe.layer.borderWidth=1;
    self.tipLabe.layer.cornerRadius=10;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
