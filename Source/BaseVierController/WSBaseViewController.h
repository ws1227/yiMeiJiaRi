//
//  WSBaseViewController.h
//  Doctors
//
//  Created by 王森 on 16/4/5.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRBButton.h"
#import "WRBQuickControl.h"
typedef void (^RequestSuccessBlock)(id responseObject);
typedef void (^RequestFailureBlock)(NSError *error);
typedef void(^TableViewHeaderFresh)(void);
typedef void(^TableViewFooterFresh)(void);
/**
 *  选中UICollectionViewCell的Block
 */
typedef void (^DidSelectCellBlock)(NSIndexPath *indexPath) ;


@interface WSBaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
/**
 *  刷新用
 */
@property(assign,nonatomic)int page;

@property(nonatomic,retain)UITableView *tableview;
@property (nonatomic, copy) DidSelectCellBlock  didSelectCellBlock ;

/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)BOOL isSetFooterFresh;

/**
 *  重写标题
 *
 *  @param customTableView 标题文字
 */
-(void)setTitle:(NSString *)title;


-(void)customTableView;
/**
 *  下拉刷新
 *
 *  @param fresh 刷新Block
 */
-(void)setTableHeaderRefresh:(TableViewHeaderFresh)fresh;

/**
 *  设置上拉加载控件
 *
 *  @param block 回调的block
 */
-(void)setFooterfresh:(TableViewFooterFresh )block;



/**
 *  结束刷新
 */
-(void)endReFresh;

/**
 *  注册Nib文件
 *
 *  @param nibStr nib名字
 */
-(void)registerNib:(NSString *)nibStr;

/**
 *  初始化一个自定义xib的tableView
 *
 *  @param nibString nib名字
 */
-(void)initWithTableViewNib:(NSString *)nibString didSelectCellBlock:(DidSelectCellBlock)block;




-(void)pushNextViewController:(UIViewController *)controller;

/**
 *  添加返回按钮
 *
 *  @param btnImg 按钮图片
 */
-(void)addLeftBackBtn:(NSString *)btnImg;
/**
 *  返回按钮事件
 *
 *  @param btn 按钮事件
 */
-(void)backBtn:(WRBButton *)btn;

//添加默认提示框
- (void)addProgressHUD;


/**
 *  显示加载框
 *
 *  @param statusLable 显示加载的文字 不写为空
 */
-(void)showWithStatus:(NSString *)statusLable;

//删除提示文字
-(void)removeStatuslable;

/**
 *  显示成功的提示框
 *
 *  @param success 提示文字
 */
-(void)showSuccess:(NSString *)success;
/**
 *  网络请求失败提示框
 *
 *  @param failed 请求失败的提示文字
 */
-(void)showFailed:(NSString *)failed;


/**
 
 ************************ ************************
 
 
  以下内容转为本项目专用
 
 ************************ ************************
 
 */

/**
 *  获取大师的ID
 *
 *  @return 大师ID
 */
-(NSString *)getArtisanId;

/**
 *  获取老师名字
 *
 *  @return 名字
 */
-(NSString *)getArtisanName;



/**
 *  tableView界面以post方式快速定义一个请求 (考虑到上拉加载不是每个界面都要用就另外设置了 方法)
 *
 *  @param url             请求的url
 *  @param dic             请求字典
 *  @param iscache         是否缓存
 *  @param fresh           table上下拉刷新
 *  @param successResponse 请求成功
 *  @param faildError      请求失败
 */

-(void)requestApiWithUrl:(NSString *)url dictionary:(NSDictionary *)dic isCache:(BOOL )iscache success:(RequestSuccessBlock)successResponse faild:(RequestFailureBlock)faildError;


-(void)requestGetUrl:(NSString *)url  success:(RequestSuccessBlock)successResponse faild:(RequestFailureBlock)faildError;


@end
