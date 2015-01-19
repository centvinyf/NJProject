//
//  HttpJsonManager.h
//  123123
//
//  Created by 范宇 on 14-9-4.
//  Copyright (c) 2014年 XiaoMi. All rights reserved.
//

#import "AFNetworking.h"
@class XMProgressHUD;

@interface HttpJsonManager : AFHTTPRequestOperationManager
{
//    UIAlertView *alertView;
    XMProgressHUD *hud;
}
/**
 *  类方法Json Post
 *
 *  @param params     Json字典
 *  @param porn       接口后缀
 *  @param completion 网络请求完成后执行的block
 */

+(void)postWithParameters:(NSDictionary *)params
                     sender:(UIViewController *)viewController
                      url:(NSString *)url
        completionHandler:(void (^)(BOOL sucess, id content))completion;

+(AFHTTPRequestOperation *)getWithParameters:(NSDictionary *)params
                  sender:(UIViewController *)viewController
                      url:(NSString *)url
        completionHandler:(void (^)(BOOL sucess, id content))completion;

+(void)postWithParameters:(NSDictionary *)params
                   sender:(UIViewController *)viewController
                      url:(NSString *)url
constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
        completionHandler:(void (^)(BOOL sucess, id content))completion;
@end
