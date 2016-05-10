//
//  AdTableViewCell.m
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "AdTableViewCell.h"

@implementation AdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadLunboData:(NSArray *)array
{
    NSMutableArray *imageArr = [NSMutableArray array];
    
    
    for (NSDictionary *dic in array) {
        NSLog(@"广告图片地址：%@",dic[@"image"]);
        
        [imageArr addObject:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",dic[@"imgUrl"]]];
        
    }

    
    
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145*SHIJI_HEIGHT) imageURLStringsGroup:imageArr];
    _cycleScrollView.infiniteLoop = YES;
    _cycleScrollView.delegate=self;            //shouyeplace
    _cycleScrollView.currentPageDotColor=UIColorFromRGB(0x53cac3);
    _cycleScrollView.placeholderImage=[UIImage imageNamed:@"shouyeplace"];
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    _cycleScrollView.autoScrollTimeInterval = 3.0;
    _cycleScrollView.pageControlDotSize=CGSizeMake(5, 5);
    
    [self addSubview:_cycleScrollView];
    
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
  
}



@end
