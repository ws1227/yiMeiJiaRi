//
//  DetailMenuTableViewCell.h
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMenuTableViewCell : UITableViewCell
@property(nonatomic, strong) MyLinearLayout *rootLayout;
-(void)fuzhi:(NSArray *)array;

@end
