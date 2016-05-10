//
//  ENAlert.m
//  CustomENAlert
//
//  Created by juziwl on 15/11/25.
//  Copyright © 2015年 李长恩. All rights reserved.
//

#import "ENAlert.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@implementation ENAlert
static const char cancelBlockkey;


#define EN_IOS9  [[[UIDevice currentDevice] systemVersion] floatValue]>=9.0f

+ (ENAlert *) sharedInstance{
    static ENAlert *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ENAlert alloc] init];
    });
    return instance;
}
+(void)alertShowTitle:(nullable NSString *)title 
              message:(nullable NSString *)message  
    cancelButtonTitle:(nullable NSString *)cancelButtonTitle  
    otherButtonTitles:(nullable NSString *)otherButtonTitles
                block:(nullable AlertDecideBlock)alertBlock
{
    [[ENAlert sharedInstance] alertShowTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles block:^(NSInteger buttonIndex) {
        if (alertBlock) {
            alertBlock(buttonIndex);
        }
    }];
}
-(void)alertShowTitle:(nullable NSString *)title 
              message:(nullable NSString *)message  
    cancelButtonTitle:(nullable NSString *)cancelButtonTitle  
    otherButtonTitles:(nullable NSString *)otherButtonTitles
                block:(nullable AlertDecideBlock)alertBlock
{
    
    if (EN_IOS9) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                       message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                style:UIAlertActionStyleCancel
                                                              handler:^(UIAlertAction * action) {
                                                                  alertBlock(0);
                                                              }];
        [alert addAction:defaultAction];
        if (![self isBlankString:otherButtonTitles]) {
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:otherButtonTitles
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {
                                                                      alertBlock(1);
                                                                  }];
            [alert addAction:defaultAction];
        }
//        [[self getCurrentVC].navigationController showViewController:alert sender:nil];
        
        
        [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }else
    {   
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title 
                                                            message:message 
                                                           delegate:self 
                                                  cancelButtonTitle:cancelButtonTitle 
                                                  otherButtonTitles:otherButtonTitles, nil];
        objc_removeAssociatedObjects(alertView);
        alertView.delegate=self;
        objc_setAssociatedObject(alertView, &cancelBlockkey, alertBlock, OBJC_ASSOCIATION_COPY);
        [alertView show];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AlertDecideBlock alertBlock =(AlertDecideBlock)objc_getAssociatedObject(alertView, &cancelBlockkey);
    if (alertBlock) {
        alertBlock(buttonIndex);
    }
}
/*!
 @brief 空返回YES
 @string string
 */
- (BOOL)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL){
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]){
        return YES;
    }
    if (string.length == 0){
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return YES;
    }
    if ([string isEqualToString:@""]){
        return YES;
    }
    if ([string isEqualToString:@"(null)"]){
        return YES;
    }
    return NO;
}
- (UIViewController *)getCurrentVC  
{  
    UIViewController *result = nil;  
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];  
    if (window.windowLevel != UIWindowLevelNormal)  
    {  
        NSArray *windows = [[UIApplication sharedApplication] windows];  
        for(UIWindow * tmpWin in windows)  
        {  
            if (tmpWin.windowLevel == UIWindowLevelNormal)  
            {  
                window = tmpWin;  
                break;  
            }  
        }  
    }  
    
    UIView *frontView = [[window subviews] objectAtIndex:0];  
    id nextResponder = [frontView nextResponder];  
    
    if ([nextResponder isKindOfClass:[UIViewController class]])  
        result = nextResponder;  
    else  
        result = window.rootViewController;  
    
    return result;  
}  

@end
