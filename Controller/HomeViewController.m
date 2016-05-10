//
//  HomeViewController.m
//  yiMeiJiaRi
//
//  Created by 王森 on 16/4/27.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "HomeViewController.h"
#import "TuiJIanTableViewCell.h"
#import "AdTableViewCell.h"
#import "MenuTableViewCell.h"
#import "DetailMenuTableViewCell.h"
#import "DaoYouTableViewCell.h"
#import "ListTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeViewController ()

{
    
    NSArray *adArray;
    NSArray *menuDetilrray;
    NSArray *daoYouArray;
    NSArray *homeListArray;
    
    NSArray *tempArray;

}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"首页";
    menuDetilrray=@[].mutableCopy;
    
    [self customTableView];
    [self registerNib:@"AdTableViewCell"];
    [self registerNib:@"MenuTableViewCell"];
    [self registerNib:@"DetailMenuTableViewCell"];
    [self registerNib:@"DaoYouTableViewCell"];
    [self registerNib:@"TuiJIanTableViewCell"];
    [self registerNib:@"ListTableViewCell"];

    
    self.tableview.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.navigationController.navigationBar.barTintColor=RGBA(255, 255, 255, 0);
    
    
//    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];

    
    
    NSLog(@"%f",SHIJI_HEIGHT*145);
    [self requestAdData];
    [self DetailMenu];
    
    [self requesttuiJIan];
    
    // Do any additional setup after loading the view.
}


-(void)requestAdData
{
    [self requestGetUrl:@"http://api.yimayholiday.com/m.api?_did=586060312342&_vc=1&_ft=json&_sm=rsa&boothCode=MAIN_PAGE&_sig=lpMV%2B9HQV76%2B5uBvkx9rHoZeN9A%3D&_mt=resourcecenter.getBooth&_aid=2&" success:^(id responseObject) {
        
        NSArray *array=responseObject[@"content"];
        
        NSDictionary *array2=array.firstObject;
     
        adArray=array2[@"showcases"];
        
//        NSLog(@"%@",adArray);
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } faild:^(NSError *error) {
        
    }];
    
    
    
}



-(void)DetailMenu
{
    [self requestGetUrl:@"http://api.yimayholiday.com/m.api?_did=586060312342&_ft=json&_vc=1&_sm=rsa&_sig=47BUplxSLedu8dKUD9nmx34Gg6o%3D&pageCodes=%5B%22TRAVE_MASTER%22%2C%22HOME_RECOMMENT%22%5D&_aid=2&_mt=resourcecenter.getMainPageContent&" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSLog(@"目录详情：%@",responseObject);

        tempArray =responseObject[@"content"];
        
        NSDictionary *dic=tempArray.firstObject;
        menuDetilrray=dic[@"recommendList"];
        daoYouArray=dic[@"travelMasterColumn"][@"travelMasterInfoList"];
        
        
        NSLog(@"----------%@",dic);
        
       
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSIndexSet *indexSet3=[[NSIndexSet alloc]initWithIndex:3];
        [self.tableview reloadSections:indexSet3 withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } faild:^(NSError *error) {
        
    }];
    
    
    
}


-(void)requesttuiJIan
{
    
    
    [self requestGetUrl:@"http://api.yimayholiday.com/m.api?_did=586060312342&pageInfo=%7B%22pageSize%22%3A5%2C%22pageNo%22%3A1%7D&_vc=1&_ft=json&_sm=rsa&_sig=Y2KTs3q%2F0fzvfiGGu1lf9JQqlRQ%3D&_mt=resourcecenter.getGreatRecomment&_aid=2&" success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSArray *array=responseObject[@"content"];
        
        NSDictionary *array2=array.firstObject;
        homeListArray=array2[@"greatRecommendList"];
        
        
        //        NSLog(@"%@",adArray);
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:4                     ];
        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } faild:^(NSError *error) {
        
    }];
    
    
    
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
    return 5;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 1;
 
    }
    
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return menuDetilrray.count-5;
    }
    if (section==3) {
//        if (daoYouArray.count>0) {
            return 1;
//        }else
//        return 0;
    }
    if (section==4) {
        return homeListArray.count;
    }
    else
    {
        return 2;
  
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {

    return 145*SHIJI_HEIGHT;
}
    
    if (indexPath.section==1) {
        
        return 130*SHIJI_HEIGHT;
    }

    if (indexPath.section==2) {
        
        return 234*SHIJI_HEIGHT;
    }
    
    if (indexPath.section==3) {
        return 156*SHIJI_HEIGHT;
    }

    if (indexPath.section==4) {
        return 268;
    }
    
    else{
        
        return 44;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.section==0) {
        AdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell loadLunboData:adArray];
        
        
        return cell;
    }
    
    
    if (indexPath.section==1) {
        MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
        
    }

   
    if (indexPath.section==2) {
        DetailMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailMenuTableViewCell" forIndexPath:indexPath];
        [cell fuzhi:menuDetilrray];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }
    if (indexPath.section==3) {
        DaoYouTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DaoYouTableViewCell" forIndexPath:indexPath];
        [cell fuzhi:daoYouArray];

        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        
        return cell;
        
    }
    if (indexPath.section==4) {
        ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
//        cell.label.text=homeListArray[indexPath.row][@"title"];
//        NSLog(@"========%@",homeListArray[indexPath.row][@"imgUrl"]);
        [cell.bgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",homeListArray[indexPath.row][@"imgUrl"]]]];
        NSString *title=[NSString stringWithFormat:@"%@",homeListArray[indexPath.row][@"memberPrice"]];
        cell.titleLable.text=[NSString stringWithFormat:@"   %d 起/会员",[title intValue]/100];
        cell.titleLable.backgroundColor=RGBA(0, 0, 0, 0.6);
        NSDictionary *ownDic=homeListArray[indexPath.row][@"ownerInfo"];
        
        cell.name.text=ownDic[@"ownerName"];
        cell.describe.text=ownDic[@"ownerDesc"];
        [cell.headerIng sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://img.yimayholiday.com/v1/tfs/%@",ownDic[@"ownerLogo"]]]];

        cell.title.text=homeListArray[indexPath.row][@"title"];
        cell.headerIng.layer.cornerRadius=24;
        cell.tipLabe.text=homeListArray[indexPath.row][@"comTagList"][0][@"name"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=[UIColor whiteColor];
        
        return cell;
        
    }
    

    


    else
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


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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

@end
