//
//  WSNetworkApi.m
//  封装网络请求
//
//  Created by 王森 on 16/4/6.
//  Copyright © 2016年 王森. All rights reserved.
//
/**
 *  使用demo
 */
//可以自由选择是否设置请求有效时间
//    [WSNetworkApi isSetTimeOut:NO andTimeSecond:20];

//[[WSNetworkApi shareManager]getCacheWithUrl:@"/city/queryCityList" option:RequestCenterCachePolicyCacheAndLocal parameters:nil sucess:^(id json) {
//    NSLog(@"GET:----%@",json);
//
//} failur:^(NSError *error) {
//    NSLog(@"GET%@",error);
//
//}];


#import "WSNetworkApi.h"
#import <AFNetworking/AFNetworking.h>
#import <YTKKeyValueStore/YTKKeyValueStore.h>
#import "CoreStatus.h"

static NSString *WS_privateNetworkBaseUrl = nil;
static NSString *WS_setNetworkBasePanth = nil;
static NSString *_tableName;
static BOOL _isSetTimeOut;
static double _timeOutSecond;

static YTKKeyValueStore *_store;
@interface WSNetworkApi()
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;

@end



@implementation WSNetworkApi
+ (WSNetworkApi *)shareManager {
    static WSNetworkApi *manger=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manger) {
            manger = [[WSNetworkApi alloc]init];
       
        }
    });
    return manger;

    }



+(void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _store = [[YTKKeyValueStore alloc] initDBWithName:@"WS_Cache.db"];
        _tableName = @"user_table";
        [_store createTableWithName:_tableName];
    });
}
+ (void)updateBaseUrl:(NSString *)baseUrl {
    WS_privateNetworkBaseUrl = baseUrl;
}
+ (void)BasePanth:(NSString *)Panth
{
    WS_setNetworkBasePanth=Panth;
    
}
+(void)isSetTimeOut:(BOOL )isSetTimeOut andTimeSecond:(double  )TimeSecond
{
    _isSetTimeOut=isSetTimeOut;
    _timeOutSecond=TimeSecond;
    NSLog(@"设置的超时时间：%f",_timeOutSecond);
    
    
}
+(NSString *)baseUrl
{
    
    return WS_privateNetworkBaseUrl;
    
}
+ (NSString *)absoluteUrlWithPath:(NSString *)path {
    if (path == nil || path.length == 0) {
        return @"";
    }
    
    if ([self baseUrl] == nil || [[self baseUrl] length] == 0) {
        return path;
    }
    
    NSString *absoluteUrl = path;
    
    if (![path hasPrefix:@"http://"] && ![path hasPrefix:@"https://"]) {
        
        if (WS_setNetworkBasePanth) {
            absoluteUrl= [NSString stringWithFormat:@"%@%@%@",
                          [self baseUrl], WS_setNetworkBasePanth,path];
        }
        else{
            absoluteUrl = [NSString stringWithFormat:@"%@%@",
                           [self baseUrl], path];
        }
    }
    
    return absoluteUrl;
}



-(AFHTTPRequestOperationManager *)manager
{
    
    
    if (!_manager) {
        
        if ([WSNetworkApi baseUrl] != nil) {
        
            _manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:[WSNetworkApi baseUrl]]];
        } else {
            _manager = [AFHTTPRequestOperationManager manager];
        }
        
        [_manager.requestSerializer setValue:@"accessToken" forHTTPHeaderField:@"Authorization"];
        [AFHTTPRequestSerializer serializer].timeoutInterval = 1;
          _manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/json",@"text/plain", @"application/json",nil];
       
        _manager.securityPolicy.allowInvalidCertificates = YES;

    }
    return _manager;
}

/**
 监控网络状态
 */
+ (BOOL)checkNetworkStatus {
    
    BOOL reachable;
    
    if (!CoreStatus.isNetworkEnable) {
        reachable=NO;
        
    }else{
        reachable=YES;
        
    }
    
    
    
    return reachable;
}





/**判断一个缓存是否有效，是否超时*/
- (BOOL)isOnTimeForURL:(NSString *)url
{
    
    //返回某条记录，距现在时间
    NSString *timeCache=[_store getStringById:[NSString stringWithFormat:@"time_%@",url] fromTable:_tableName];
    
    NSLog(@"现在时间：%@----缓存时间：%@ 相差时间：%.0f",[WSNetworkApi getTimeStamp],timeCache,[[WSNetworkApi getTimeStamp]doubleValue]-[timeCache doubleValue]);
    
    
    double timeInterval=[[WSNetworkApi getTimeStamp]doubleValue]-[timeCache doubleValue];
    
    BOOL isOnTime ;

    if (timeInterval<_timeOutSecond) {
        
        isOnTime=YES;
        NSLog( @"缓存时间没有超过-------%f秒",_timeOutSecond);
    }
    else{

        isOnTime=NO;
        NSLog( @"缓存时间已经超过%f秒",timeInterval);

    }

    
 
    return isOnTime;
}

// POST
-(void)postWithUrl:(NSString *)url parameters:(NSDictionary *)parameters option:(RequestCenterCachePolicy)option sucess:(RequestSuccessBlock)sucess failur:(RequestFailureBlock)failur
{
    // 2.发送请求
    NSString *absolute = [WSNetworkApi absoluteUrlWithPath:url];

   
    if (![WSNetworkApi checkNetworkStatus]) {
        
        NSLog(@"网络请求失败");
        NSDictionary *queryUser = [_store getObjectById:absolute fromTable:_tableName];
        if (queryUser) {
            sucess(queryUser);
            //                NSLog(@"系统有缓存 %@",queryUser);
        }else {
            NSLog(@"无缓存记录");
            
        }
        
        return;
    }

    
    /**
     *  是否设置了缓存有效时间
     */
    if (_isSetTimeOut) {
        
        
        if ([self isOnTimeForURL:absolute]) {
            
            
            NSDictionary *queryUser = [_store getObjectById:absolute fromTable:_tableName];
            if (queryUser) {
                NSLog(@"从缓存获取数据");
                sucess(queryUser);
                //                NSLog(@"系统有缓存 %@",queryUser);
            }else {
                NSLog(@"无缓存记录");
                
            }
            
            return;
            
        }
        else
        {
            NSLog(@"已经超时");
        }
        
        
    }
    else
    {
        NSLog(@"不设置缓存时间");
    }
    
    
    switch (option) {
        case RequestCenterCachePolicyNormal:{ // 普通的网络请求
            
            [self.manager POST:absolute parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (sucess) {
                    sucess(responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failur) {
                    
                    failur(error);
                }
            }];
            
        }
            break;
        case RequestCenterCachePolicyCacheAndLocal:{ //优先读取本地，不管有没有网络，优先读取本地
            
            NSDictionary *queryUser = [_store getObjectById:absolute fromTable:_tableName];
            if (queryUser) {
                sucess(queryUser);
                //                NSLog(@"系统有缓存 %@",queryUser);
            }
            
            [self.manager POST:absolute parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (sucess) {
                    if (!queryUser) {
                        sucess(responseObject);
                        //                        NSLog(@"第一次进入系统没有缓存");
                    }
                    
                    [_store putString:[WSNetworkApi getTimeStamp] withId:[NSString stringWithFormat:@"time_%@",absolute] intoTable:_tableName];
                    

                    [_store putObject:responseObject withId:absolute intoTable:_tableName];
//                    sucess(responseObject);

                    
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failur) {
                    failur(error);
                }
            }];
        }
            break;
    }

    
}

// GET
-(void)getCacheWithUrl:(NSString *)url option:(RequestCenterCachePolicy)option parameters:(NSDictionary *)parameters sucess:(RequestSuccessBlock)sucess failur:(RequestFailureBlock)failur
{
    // 2.发送请求
    NSString *absolute = [WSNetworkApi absoluteUrlWithPath:url];
    
      /**
     *  网络请求失败取缓存
     */
    
    if (![WSNetworkApi checkNetworkStatus]) {
        
        NSLog(@"网络请求失败");
        NSDictionary *queryUser = [_store getObjectById:absolute fromTable:_tableName];
        if (queryUser) {
            sucess(queryUser);
            //                NSLog(@"系统有缓存 %@",queryUser);
        }else {
            NSLog(@"无缓存记录");
            
        }

        return;
    }
    
    
    
    /**
     *  是否设置了缓存有效时间
     */
    if (_isSetTimeOut) {
        
        
        if ([self isOnTimeForURL:absolute]) {
            
            
            NSDictionary *queryUser = [_store getObjectById:absolute fromTable:_tableName];
            if (queryUser) {
                NSLog(@"从缓存获取数据");
                sucess(queryUser);
                //                NSLog(@"系统有缓存 %@",queryUser);
            }else {
                NSLog(@"无缓存记录");
                
            }
            
            return;
            
        }
        else
        {
            NSLog(@"已经超时");
        }
        
        
    }
    else
    {
        NSLog(@"不设置缓存时间");
    }
   

    
    
    switch (option) {
            
            
        case RequestCenterCachePolicyNormal:{ // 普通的网络请求
            
            [self.manager GET:absolute parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (sucess) {
                    sucess(responseObject);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failur) {
                    failur(error);
                }
            }];
            
        }
            break;
        case RequestCenterCachePolicyCacheAndLocal:{ //优先读取本地，不管有没有网络，优先读取本地
            
            /**
             *  虽然设置了缓存有效时间 如果超过缓存时间仍然先从缓存获取数据然后再请求数据
             */
            NSDictionary *queryUser = [_store getObjectById:absolute fromTable:_tableName];
            
            if (queryUser) {
                sucess(queryUser);
                //                NSLog(@"系统有缓存 %@",queryUser);
            }
       
            
            [self.manager GET:absolute parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (sucess) {
                   
                    if (!queryUser) {
                        sucess(responseObject);
                        //                        NSLog(@"第一次进入系统没有缓存");
                    }
               [_store putObject:responseObject withId:absolute intoTable:_tableName];
                   
                    [_store putString:[WSNetworkApi getTimeStamp] withId:[NSString stringWithFormat:@"time_%@",absolute] intoTable:_tableName];
                    

                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failur) {
                    
                    failur(error);
                }
            }];
        }
            break;
    }
}
/**
 *  PUT
 *
 *  @param url    请求的 url
 *  @param parm   请求的参数
 *  @param sucess 请求成功后的回调
 *  @param failur 请求失败后的回调
 */
-(void)putWithUrl:(NSString *)url parm:(id)parm sucess:(void (^)(id json))sucess failur:(void (^)(NSError *error))failur
{
    NSString *absolute = [WSNetworkApi absoluteUrlWithPath:url];
    
    [[AFHTTPSessionManager manager] PUT:absolute parameters:parm success:^(NSURLSessionDataTask *task, id responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failur) {
            failur(error);
        }
    }];
}

/**
 *  DELETE
 *
 *  @param url    请求的 url
 *  @param parm   请求的参数
 *  @param sucess 请求成功后的回调
 *  @param failur 请求失败后的回调
 */
-(void)DELETE:(NSString *)URLString parameters:(NSDictionary *)parameters sucess:(void (^)(id json))sucess failur:(void (^)(NSError *error))failur
{
    
    [self.manager DELETE:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failur) {
            failur(error);
            
            
        }
    }];
}

#pragma mark 时间转换时间戳
+ (nullable NSString *)getTimeStamp
{
    NSDate *datenow = [NSDate date];
    // 时间转时间戳的方法:
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

@end
