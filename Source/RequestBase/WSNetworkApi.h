//
//  WSNetworkApi.h
//  封装网络请求
//
//  Created by 王森 on 16/4/6.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RequestSuccessBlock)(id responseObject);
typedef void (^RequestFailureBlock)(NSError *error);

typedef NS_ENUM(NSUInteger, RequestCenterCachePolicy) {
    /**
     *  普通网络请求,不会有缓存
     */
    RequestCenterCachePolicyNormal,
    
    /**
     *  优先读取本地，不管有没有网络，优先读取本地
     */
    RequestCenterCachePolicyCacheAndLocal
    
};



@interface WSNetworkApi : NSObject



+ (WSNetworkApi *)shareManager ;


/**
 *  设置超时时间
 *
 *  @param isSetTimeOut      是否启动设置缓存时间
 *  @param TimeSecond 设置缓存时间 (秒)
 */
+(void)isSetTimeOut:(BOOL )isSetTimeOut andTimeSecond:(double  )TimeSecond;


/**

 *  @return  @param baseUrl 网络接口的基础url
 */

+ (void)updateBaseUrl:(NSString *)baseUrl;
/**
 *  设置基础的Panth
 *
 *  @param Panth 返回Panth  比如@"http://api.91lds.com/lds-app"中的lds-app
 */
+ (void)BasePanth:(NSString *)Panth;

+(NSString *)baseUrl;

/**
 *  带缓存的 post 请求  可以使用RequestCenterCachePolicyNormal不使用缓存策略
 *
 *  @param url        接口地址 Url
 *  @param parameters 请求参数
 *  @param option     枚举,选择缓存策略
 *  @param sucess     成功后的回调
 *  @param failur     失败后的回调
 */
-(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters option:(RequestCenterCachePolicy)option sucess:(RequestSuccessBlock)sucess failur:(RequestFailureBlock)failur;


/**
 *  带缓存的 get 请求
 *
 *  @param url        接口地址 Url
 *  @param option     枚举,选择缓存策略
 *  @param parameters 请求参数
 *  @param sucess     成功后的回调
 *  @param failur     失败后的回调
 */
-(void)getCacheWithUrl:(NSString *)url option:(RequestCenterCachePolicy)option parameters:(NSDictionary *)parameters sucess:(RequestSuccessBlock)sucess failur:(RequestFailureBlock)failur;

/**
 *  PUT
 *
 *  @param url    请求的 url
 *  @param parm   请求的参数
 *  @param sucess 请求成功后的回调
 *  @param failur 请求失败后的回调
 */
-(void)putWithUrl:(NSString *)url parm:(id)parm sucess:(void (^)(id json))sucess failur:(void (^)(NSError *error))failur;

/**
 *  DELETE
 *
 *  @param url    请求的 url
 *  @param parm   请求的参数
 *  @param sucess 请求成功后的回调
 *  @param failur 请求失败后的回调
 */
-(void)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters sucess:(void (^)(id json))sucess failur:(void (^)(NSError *error))failur;


@end
