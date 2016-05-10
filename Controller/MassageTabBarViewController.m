//
//  MassageViewController.m
//  Doctors
//
//  Created by 王森 on 16/4/7.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "MassageTabBarViewController.h"

#import "HomeViewController.h"
#import "ActivatyViewController.h"
#import "xingChengViewController.h"


@interface MassageTabBarViewController ()

@end

@implementation MassageTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    ALLOC(HomeViewController, homeView);
    
    ALLOC(ActivatyViewController, orderView);
    
    ALLOC(xingChengViewController, myView);
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:UIColorFromRGB(0x999999)} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:UIColorFromRGB(0x00ccc2)} forState:UIControlStateSelected];
    
    
    UINavigationController *homeViewController = [[UINavigationController alloc]
                                                    initWithRootViewController:homeView];
    [homeViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    UINavigationController *myViewController = [[UINavigationController alloc]
                                                initWithRootViewController:myView];
    
    
    [myViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    UINavigationController *OrderViewController = [[UINavigationController alloc]
                                                  initWithRootViewController:orderView];
    
    
    [OrderViewController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -2)];
    
    
    homeViewController.tabBarItem.title = @"首页";
    myViewController.tabBarItem.title = @"活动";
    OrderViewController.tabBarItem.title=@"行程";

    
    //首页
    homeViewController.tabBarItem.image =[UIImage imageNamed:@"tab_shouye"];
    UIImage *imgx = [UIImage imageNamed:@"tab_shouye_pre"];
    imgx = [imgx imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeViewController.tabBarItem.selectedImage=imgx;
    
    OrderViewController.tabBarItem.image =[UIImage imageNamed:@"tab_dingdan@2x"];
    UIImage * shopViewControllerimg = [UIImage imageNamed:@"tab_dingdan_pre"];
    shopViewControllerimg = [shopViewControllerimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    OrderViewController.tabBarItem.selectedImage=shopViewControllerimg;
    
    
    myViewController.tabBarItem.image =[UIImage imageNamed:@"tab_wode_pre"];
    UIImage * myViewControllerimg = [UIImage imageNamed:@"tab_wode_pre"];
    myViewControllerimg = [myViewControllerimg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    myViewController.tabBarItem.selectedImage=myViewControllerimg;
    
    NSArray *vcArr = @[homeViewController,OrderViewController,myViewController];
    
    
    self.viewControllers = vcArr;

    // Do any additional setup after loading the view.
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
