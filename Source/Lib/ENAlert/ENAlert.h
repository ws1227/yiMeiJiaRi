//
//  ENAlert.h
//  CustomENAlert
//
//  Created by juziwl on 15/11/25.
//  Copyright © 2015年 李长恩. All rights reserved.
//
/*
 
 这个其实还是系统的提示框，只是适配了ios9
 */

#import <Foundation/Foundation.h>

typedef void (^AlertDecideBlock)(NSInteger buttonIndex);//

@interface ENAlert : NSObject

+ (nullable ENAlert *) sharedInstance;

+(void)alertShowTitle:(nullable NSString *)title 
              message:(nullable NSString *)message  
    cancelButtonTitle:(nullable NSString *)cancelButtonTitle  
    otherButtonTitles:(nullable NSString *)otherButtonTitles
                block:(nullable AlertDecideBlock)alertBlock;


@end
