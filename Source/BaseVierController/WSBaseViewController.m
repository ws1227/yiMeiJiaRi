//
//  WSBaseViewController.m
//  Doctors
//
//  Created by 王森 on 16/4/5.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "WSBaseViewController.h"
#import "CoreStatus.h"
#import "MBProgressHUD+LJ.h"
#import "MJRefresh.h"

@interface WSBaseViewController ()<CoreStatusProtocol>

@end

@implementation WSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //改变导航栏头部标题和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       
       NSForegroundColorAttributeName:UIColorFromRGB(0x53cac3)}];
    self.view.backgroundColor=UIColorFromRGB(0xf6f6f6);
    self.page=1;
    
    self.dataArray=[[NSMutableArray alloc]init];

    //监测当前网络
    [CoreStatus beginNotiNetwork:self];
    
    
    if (!CoreStatus.isNetworkEnable) {
        [MBProgressHUD showError:@"当前无网络"];
    }
    

    // Do any additional setup after loading the view.
}


-(void)setTitle:(NSString *)title
{
    [self setTextTitleViewWithFrame:CGRectMake(0, 0, 60, 20) title:title fontSize:18];
}
//监测当前网络状态
-(void)coreNetworkChangeNoti:(NSNotification *)noti{
    
    NSString * statusString = [CoreStatus currentNetWorkStatusString];
    
    NSLog(@"当前网络类型：%@\n\n\n\n====\n\n\n\n%@",noti,statusString);
    if ([statusString isEqualToString:@"无网络"]) {
        //提示成功
        MBProgressHUD *newhud = [[MBProgressHUD alloc] initWithView:self.view];
        newhud.userInteractionEnabled = NO;
        [self.view addSubview:newhud];
        newhud.labelText =[NSString stringWithFormat:@"无网络"] ;
        newhud.mode = MBProgressHUDModeText;
        
        [newhud showAnimated:YES whileExecutingBlock:^{
            sleep(1.1);
        } completionBlock:^{
            [newhud removeFromSuperview];
        }];
        
        
    }
    
}

-(void)addLeftBackBtn:(NSString *)btnImg
{
    __weak typeof(self) weakSelf = self;
    NSString *btnName;
    
    if (btnImg==nil) {
        btnName=@"btn_back";
    }
    else{
        btnName=btnImg;
    }
    
    [self setLeftImageBarButtonItemWithFrame:CGRectMake(5, 5, 30, 30) image:btnName selectImage:nil action:^(WRBButton *button) {
        
        [weakSelf backBtn:button];
        
    }];
    
    
}
-(void)customTableView
{
    if(!_tableview){
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor= [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_"]];
        [self setExtraCellLineHidden:_tableview];
        
        [self.view addSubview:_tableview];
    }
}


-(void)registerNib:(NSString *)nibStr
{
    UINib *ordernib=[UIView loadNibNamed:nibStr bundle:nil];
    [self.tableview registerNib:ordernib forCellReuseIdentifier:nibStr];//注册cell
    

}

/**
 *  初始化一个自定义xib的tableView
 *
 *  @param nibString nib名字
 */
-(void)initWithTableViewNib:(NSString *)nibString didSelectCellBlock:(DidSelectCellBlock)block{
    
    [self customTableView];
    [self registerNib:nibString];

    self.didSelectCellBlock=block;
    
    
}

-(void)setTableHeaderRefresh:(TableViewHeaderFresh)fresh{

    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        /**
         *  用于重新请求数据用
         */
        fresh();
        
        
    }];

}

-(void)endReFresh{
    
    [self.tableview.mj_header endRefreshing];
    
    [self.tableview.mj_footer endRefreshing];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableCell"];
        //        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"基类里输出请重写方法");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(indexPath) ;

    }
}

//隐藏多余线条
-(void)setExtraCellLineHidden: (UITableView *)tableView

{
    
    UIView *view = [UIView new];
    
//    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
    
}



/**
 *  页面跳转
 *
 *  @param controller 跳转下一页
 */
-(void)pushNextViewController:(UIViewController *)controller;
{
    controller.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:controller animated:YES];
    
    
}


-(void)backBtn:(WRBButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - 添加加载等待效果
- (void)addProgressHUD
{
    [MBProgressHUD showMessage:@"正在加载"];
    
}

/**
 *  加载显示文字
 *
 *  @param statusLable 网络请求时显示文字不会自动隐藏需要手动删除
 */
-(void)showWithStatus:(NSString *)statusLable
{
    if (statusLable==nil) {
        [MBProgressHUD showMessage:nil];
    }else
        [MBProgressHUD showMessage:statusLable];
    
      
    
}
//请求成功的提示文字
-(void)showSuccess:(NSString *)success
{
    if (success==nil) {

    [MBProgressHUD showSuccess:nil];
    }
    else
        [MBProgressHUD showSuccess:success];

}

//请求失败的文字
-(void)showFailed:(NSString *)failed;
{
    if (failed==nil) {
        [MBProgressHUD showError:@"加载失败"];
        
    }
    [MBProgressHUD showError:failed];
    
}
//删除提示文字
-(void)removeStatuslable
{
    [MBProgressHUD hideHUD];
    
    
}


-(NSString *)getArtisanName
{
    NSString *ArtisanName=[[TMCache sharedCache]objectForKey:@"artisanName"];
    
    return ArtisanName;
    
}
-(NSString *)getArtisanId
{
    NSString *ArtisanId=[[TMCache sharedCache]objectForKey:@"artisanId"];

    return ArtisanId;
    
}



-(void)setFooterfresh:(TableViewFooterFresh )block{
    self.tableview.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        /**
         *  添加上拉加载控件
         */
        
        block();
        
    }];

    
}

-(void)requestGetUrl:(NSString *)url  success:(RequestSuccessBlock)successResponse faild:(RequestFailureBlock)faildError

{
    
    [[WSNetworkApi  shareManager]getCacheWithUrl:url option:RequestCenterCachePolicyNormal parameters:nil sucess:^(id responseObject) {
        
        if ([StringWithFormat(responseObject[@"stat"][@"code"]) isEqualToString:@"0"]) {
            
            successResponse(responseObject);

        }
        else{
            
            [MBProgressHUD showError:@"错误"];
            
        }

    } failur:^(NSError *error) {
        
        faildError(error);

    }];
    
    
    
}

-(void)requestApiWithUrl:(NSString *)url dictionary:(NSDictionary *)dic isCache:(BOOL )iscache  success:(RequestSuccessBlock)successResponse faild:(RequestFailureBlock)faildError;
{
    
    NSLog(@"请求URL：%@\n参数：%@",url,dic);

   
    
    
    
    if (iscache) {
        

        [[WSNetworkApi shareManager]postWithUrl:url parameters:dic option:RequestCenterCachePolicyCacheAndLocal sucess:^(id responseObject) {
            [self endReFresh];

            if ([responseObject[@"status"] isEqualToString:@"ok"]) {

                successResponse(responseObject);
                
            }
            else{
                NSLog(@"请求失败：%@",responseObject);
                
                
                [MBProgressHUD showError:responseObject[@"message"] toView:KeyWindow];
                
            }
            
            
//            [MBProgressHUD hideHUDForView:KeyWindow animated:YES];
            
            
        } failur:^(NSError *error) {
            [self endReFresh];
            NSLog(@"请求出错%@",error);
            faildError(error);
            
            
        }];
     
        
        
    }
    
    else{
        [[WSNetworkApi shareManager]postWithUrl:url parameters:dic option:RequestCenterCachePolicyNormal sucess:^(id responseObject) {
            [self endReFresh];

            if ([responseObject[@"status"] isEqualToString:@"ok"]) {
                

                successResponse(responseObject);
                
            }
            else{
        [MBProgressHUD showError:responseObject[@"message"] toView:KeyWindow];                
            }
            
        } failur:^(NSError *error) {
            [self endReFresh];
            NSLog(@"%@",error);
            [MBProgressHUD showError:@"请求出错" toView:KeyWindow];

            faildError(error);
            
            
        }];
        
      
        
    }
    
    
}


@end
