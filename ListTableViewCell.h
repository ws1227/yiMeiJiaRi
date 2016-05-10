//
//  ListTableViewCell.h
//  yiMeiJiaRi
//
//  Created by 王森 on 16/5/4.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *describe;
@property (weak, nonatomic) IBOutlet UIImageView *headerIng;
@property (weak, nonatomic) IBOutlet UILabel *tipLabe;
@end
