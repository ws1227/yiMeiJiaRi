//
//  AdTableViewCell.h
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"

@interface AdTableViewCell : UITableViewCell<SDCycleScrollViewDelegate>
{
    SDCycleScrollView *_cycleScrollView;
    
}

-(void)loadLunboData:(NSArray *)array;

@end
