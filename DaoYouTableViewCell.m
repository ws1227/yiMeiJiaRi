//
//  DaoYouTableViewCell.m
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "DaoYouTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DaoYouTableViewCell
-(void)fuzhi:(NSArray *)array
{
    MyFlowLayout *layout5 = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:3];
    layout5.averageArrange = YES;
    
    layout5.backgroundColor = [UIColor whiteColor];
    layout5.myWidth=SCREEN_WIDTH;
    layout5.myHeight=146*SHIJI_HEIGHT;
    layout5.leftPadding=layout5.rightPadding=16*SHIJI_WIDTH;
    layout5.myBottomMargin=0;
    
    //    layout5.IntelligentBorderLine = [[MyBorderLineDraw alloc] initWithColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:layout5];
    MyFloatLayout *itemLayout=nil;
    NSString *sexStr0=StringWithFormat(array[0][@"gender"]);
    
    if ([sexStr0 isEqualToString:@"2"]) {
        sexStr0=@"男";
    }
    else{
        sexStr0=@"女";
        
    }

    itemLayout = [self createItemLayout5_1:array[0][@"nickname"] subtitle:[NSString stringWithFormat:@"%@/来自%@",sexStr0,array[0][@"province"]] imageUrl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[0][@"avatar"]]];
    itemLayout.myHeight=layout5.myHeight;
    
    [layout5 addSubview:itemLayout];
    
   
    
    NSString *sexStr=StringWithFormat(array[1][@"gender"]);
    
    if ([sexStr isEqualToString:@"2"]) {
        sexStr=@"男";
    }
    else{
        sexStr=@"女";

    }
    itemLayout =  [self createItemLayout5_1:array[1][@"nickname"] subtitle:[NSString stringWithFormat:@"%@/来自%@",sexStr,array[1][@"province"]] imageUrl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[1][@"avatar"]]];
    itemLayout.myHeight=layout5.myHeight;
    
    [layout5 addSubview:itemLayout];
    
    NSString *sexStr2=StringWithFormat(array[2][@"gender"]);

    if ([sexStr2 isEqualToString:@"2"]) {
        sexStr2=@"男";
    }
    else{
        sexStr2=@"女";
        
    }
    itemLayout =  [self createItemLayout5_1:array[2][@"nickname"] subtitle:[NSString stringWithFormat:@"%@/来自%@",sexStr2,array[2][@"province"]] imageUrl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[2][@"avatar"]]];;
    
    itemLayout.myHeight=layout5.myHeight;
    
    [layout5 addSubview:itemLayout];
    
    
    UIImageView *imageDi=[UIImageView new];
    imageDi.backgroundColor=UIColorFromRGB(0xf4f4f4);
    imageDi.useFrame=YES;
    imageDi.frame=CGRectMake(0, 146*SHIJI_HEIGHT, SCREEN_WIDTH, 10);
    
    [self.contentView addSubview:imageDi];
    
    

    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    // Initialization code
}


-(MyFloatLayout*)createItemLayout5_1:(NSString*)dataModel subtitle:(NSString *)subtitle imageUrl:(NSString *)url
{
    MyFloatLayout *itemLayout = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    itemLayout.myLeftMargin=itemLayout.myRightMargin=0;
//    itemLayout.gravity=MyMarginGravity_Horz_Fill;
    itemLayout.backgroundColor=[UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_tuichudenglu"]];
    imageView.myTopMargin=10;
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
    imageView.myWidth=imageView.myHeight=70*SHIJI_WIDTH;
//  imageView.myRightMargin=2*SHIJI_WIDTH;
    imageView.layer.cornerRadius=70*SHIJI_HEIGHT/2;
    imageView.myLeftMargin=12*SHIJI_WIDTH;
//    imageView.myCenterXOffset=0;
//    [imageView sizeToFit];
    
    [itemLayout addSubview:imageView];
    

    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text =dataModel;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.widthDime.equalTo(itemLayout.widthDime);
    titleLabel.textColor=UIColorFromRGB(0x333333);
    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.myTopMargin =9*SHIJI_HEIGHT;
    [titleLabel sizeToFit];
    [itemLayout addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = subtitle;
    subTitleLabel.font = [UIFont systemFontOfSize:11];
    subTitleLabel.textColor =UIColorFromRGB(0x666666);
    subTitleLabel.textAlignment=NSTextAlignmentCenter;
    subTitleLabel.widthDime.equalTo(itemLayout.widthDime);
    subTitleLabel.myTopMargin =11*SHIJI_HEIGHT;
    [subTitleLabel sizeToFit];
    [itemLayout addSubview:subTitleLabel];
    
    
     return itemLayout;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
