//
//  DetailMenuTableViewCell.m
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "DetailMenuTableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation DetailMenuTableViewCell
{
    
    NSString *title0;
  

}
-(void)fuzhi:(NSArray *)array
{
    title0=array[0][@"title"];
    
    
    self.rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    
    //    self.rootLayout.bottomPadding=10*SHIJI_HEIGHT;
    [ self.rootLayout averageMargin:NO];
    
    self.rootLayout.myWidth=SCREEN_WIDTH;
    self.rootLayout.myHeight=234*SHIJI_HEIGHT;
    
    self.rootLayout.gravity = MyMarginGravity_Horz_Fill;
    self.rootLayout.backgroundColor = [UIColor whiteColor];
    self.rootLayout.IntelligentBorderLine = [[MyBorderLineDraw alloc] initWithColor:[UIColor lightGrayColor]]; //智能边界线
    [self addSubview:self.rootLayout];
    // Initialization code
    
    
    /**
     *  第一部分
     */
    MyLinearLayout  *testLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    testLayout.myHeight = 100*SHIJI_HEIGHT;
    [self.rootLayout addSubview:testLayout];
    
    
    MyFloatLayout *second1 = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    second1.backgroundColor = [UIColor whiteColor];
    second1.myBottomMargin=0;
    second1.myLeftMargin=second1.myRightMargin=0;
    second1.myTopMargin = 0;
    second1.wrapContentHeight = YES;
    second1.IntelligentBorderLine = [[MyBorderLineDraw alloc] initWithColor:[UIColor lightGrayColor]];
    [testLayout addSubview:second1];
    
    
    MyFloatLayout *itemLayout=nil;
    
    
    itemLayout = [self createItemLayout1_1:title0 subTitlw:array[0][@"description"] imaegUrl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[0][@"img_url"]]];
    itemLayout.myHeight=testLayout.myHeight;
    itemLayout.widthDime.equalTo(second1.widthDime).multiply(0.5);
    [second1 addSubview:itemLayout];
    
    MyFloatLayout *secod2 = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    secod2.myHeight =testLayout.myHeight/2;
    secod2.widthDime.equalTo(second1.widthDime).multiply(0.5);
    [second1 addSubview:secod2];
    
    
    MyFloatLayout *secod3 = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    secod3.myHeight =testLayout.myHeight/2;
    secod3.widthDime.equalTo(second1.widthDime).multiply(0.5);
    [second1 addSubview:secod3];
    
    
    
    
    itemLayout = [self createItemLayout1_2:array[1][@"title"] subTitle:array[1][@"description"] Imageurl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[1][@"img_url"]]];
    
    itemLayout.myHeight=testLayout.myHeight;
    itemLayout.widthDime.equalTo(second1.widthDime).multiply(0.5);
    [secod2 addSubview:itemLayout];
    
    
    
    itemLayout = [self createItemLayout1_2:array[2][@"title"] subTitle:array[2][@"description"] Imageurl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[2][@"img_url"]]];
    itemLayout.myHeight=testLayout.myHeight;
    itemLayout.widthDime.equalTo(second1.widthDime).multiply(0.5);
    [secod3 addSubview:itemLayout];
    
    
    
    
    
    
    
    /**
     *  第二部分
     */
    MyLinearLayout  *testLayout2 = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    testLayout2.myHeight=124*SHIJI_HEIGHT;
    [self.rootLayout addSubview:testLayout2];
    
    MyFloatLayout *layout5 = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    layout5.backgroundColor = [UIColor whiteColor];
    layout5.myBottomMargin=0;
    layout5.myLeftMargin=layout5.myRightMargin=0;
    layout5.myTopMargin = 0;
    layout5.wrapContentHeight = YES;
    layout5.IntelligentBorderLine = [[MyBorderLineDraw alloc] initWithColor:[UIColor lightGrayColor]];
    [testLayout2 addSubview:layout5];
    
    
    
    
    
    
    
    itemLayout = [self createItemLayout5_1:array[3][@"title"] subTitle:array[3][@"description"] Imageurl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[3][@"img_url"]]];
    itemLayout.myHeight=testLayout2.myHeight;
    itemLayout.widthDime.equalTo(layout5.widthDime).multiply(0.33);
    [layout5 addSubview:itemLayout];
    
    itemLayout = [self createItemLayout5_1:array[4][@"title"] subTitle:array[4][@"description"] Imageurl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[4][@"img_url"]]];
    itemLayout.widthDime.equalTo(layout5.widthDime).multiply(0.33);
    
    itemLayout.myHeight=testLayout2.myHeight;
    
    [layout5 addSubview:itemLayout];
    
    itemLayout = [self createItemLayout5_1:array[5][@"title"] subTitle:array[5][@"description"] Imageurl:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",array[5][@"img_url"]]];    itemLayout.widthDime.equalTo(layout5.widthDime).multiply(0.33);
    
    itemLayout.myHeight=testLayout2.myHeight;
    
    [layout5 addSubview:itemLayout];
    

    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor=UIColorFromRGB(0xf4f4f4);
    



}



//品牌特卖主条目布局
-(MyFloatLayout*)createItemLayout1_1:(NSString *)dataModel subTitlw:(NSString *)subTitle imaegUrl:(NSString *)url
{
    MyFloatLayout *itemLayout = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = dataModel;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.myLeftMargin = 34*SHIJI_WIDTH;
    titleLabel.myTopMargin =SHIJI_HEIGHT*16;
    [titleLabel sizeToFit];
    [itemLayout addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = subTitle;
    subTitleLabel.font = [UIFont systemFontOfSize:11];
    subTitleLabel.textColor = [UIColor redColor];
    subTitleLabel.textAlignment=NSTextAlignmentCenter;
    subTitleLabel.myLeftMargin=titleLabel.myLeftMargin;
    subTitleLabel.myTopMargin =9*SHIJI_HEIGHT;
    [subTitleLabel sizeToFit];
    [itemLayout addSubview:subTitleLabel];
    

    
    //占用剩余的高度，宽度和父布局相等。
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dui"]];
    imageView.weight = 1;
    imageView.widthDime.equalTo(itemLayout.widthDime);
    [imageView sizeToFit];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [itemLayout addSubview:imageView];

    return itemLayout;
}

/**
 *  两个相同条目
 *
 
 */
-(MyFloatLayout*)createItemLayout1_2:(NSString *)dataModel subTitle:(NSString *)subTitle Imageurl:(NSString *)url
{
    MyFloatLayout *itemLayout = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    
    UILabel *titleLabel = [UILabel new];
    
    titleLabel.text = dataModel;
    titleLabel.font = [UIFont boldSystemFontOfSize:14];
    titleLabel.myLeftMargin = 16*SHIJI_WIDTH;
    titleLabel.myTopMargin =SHIJI_HEIGHT*13;
    [titleLabel sizeToFit];
    [itemLayout addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = subTitle;
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.textColor = [UIColor redColor];
    subTitleLabel.textAlignment=NSTextAlignmentCenter;
    subTitleLabel.myLeftMargin=titleLabel.myLeftMargin;
    subTitleLabel.myTopMargin =4*SHIJI_HEIGHT;
    [subTitleLabel sizeToFit];
    [itemLayout addSubview:subTitleLabel];
    
    
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.useFrame=YES;

    FRAME(imageView, 90, 0, 80, 53);
//    [imageView sizeToFit];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                                placeholderImage:[UIImage imageNamed:@"placeholder"]];

    imageView.backgroundColor=[UIColor lightGrayColor];
      [itemLayout addSubview:imageView];

    
    return itemLayout;
}






/**
 *  最后三个
 *
 */
-(MyFloatLayout*)createItemLayout5_1:(NSString*)dataModel subTitle:(NSString *)subTitle Imageurl:(NSString *)url

{ MyFloatLayout *itemLayout = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];

    UILabel *titleLabel = [UILabel new];
    titleLabel.text =dataModel;
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.widthDime.equalTo(itemLayout.widthDime);

    titleLabel.textAlignment=NSTextAlignmentCenter;
    titleLabel.myTopMargin =11*SHIJI_HEIGHT;
    [titleLabel sizeToFit];
    [itemLayout addSubview:titleLabel];
    
    UILabel *subTitleLabel = [UILabel new];
    subTitleLabel.text = subTitle;
    subTitleLabel.font = [UIFont systemFontOfSize:11];
    subTitleLabel.textColor = [UIColor redColor];
    subTitleLabel.textAlignment=NSTextAlignmentCenter;
    subTitleLabel.widthDime.equalTo(itemLayout.widthDime);
    subTitleLabel.myTopMargin =9*SHIJI_HEIGHT;
    [subTitleLabel sizeToFit];
    [itemLayout addSubview:subTitleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_tuichudenglu"]];
    imageView.widthDime.equalTo(itemLayout.widthDime);
    imageView.weight = 1;   //图片占用剩余的全部高度
    [imageView sizeToFit];
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder"]];

    [itemLayout addSubview:imageView];
    
    return itemLayout;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
