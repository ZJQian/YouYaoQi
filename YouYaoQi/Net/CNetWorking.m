//
//  CNetWorking.m
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import "CNetWorking.h"
#import "CServerConfig.h"
#import "CAppDotNetAPIClient.h"
#import <AFNetworkActivityIndicatorManager.h>
#import "TimeUtil.h"
#import "DeviceUtil.h"
#import <RealReachability/RealReachability.h>


/**
 *  是否开启接口打印信息
 */
static BOOL C_isEnableInterfaceDebug = YES;

/**
 *  保存所有网络请求的task
 */
static NSMutableArray *C_requestTasks;

/**
 *  基础URL
 */
static NSString *C_privateNetworkBaseUrl = nil;

/**
 *  是否开启自动转换URL里的中文
 */
static BOOL C_shouldAutoEncode = NO;

/**
 *  请求管理者
 */
static CAppDotNetAPIClient *C_sharedManager = nil;

/**
 *  基础url是否更改，默认为yes
 */
static BOOL C_isBaseURLChanged = YES;


/**
 *  设置的请求数据类型
 */
static CRequestType  C_requestType  = kRequestTypePlainText;

/**
 *  设置的返回数据类型
 */
static CResponseType C_responseType = kResponseTypeData;


/**
 *  设置请求头，默认为空
 */
static NSDictionary *C_httpHeaders = nil;

/**
 *  请求的超时时间
 */
static NSTimeInterval C_timeout = 15.0f;

/**
 *  是否开启取消请求
 */
static BOOL C_shouldCallbackOnCancelRequest = YES;


/**
 *  GET请求设置不缓存，Post请求不缓存
 */
static BOOL C_cacheGet  = NO;
static BOOL C_cachePost = NO;

/**
 *  是否从从本地提取数据
 */
static BOOL C_shoulObtainLocalWhenUnconnected = NO;

/**
 *  监测网络状态
 */
static CNetworkStatus C_networkStatus = kNetworkStatusUnknown;








@implementation CNetWorking

static inline NSString *cachePath() {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/CNetworkingCaches"];
}


+ (BOOL)isDebug {
    return C_isEnableInterfaceDebug;
}

+ (NSString *)baseUrl {
    return C_privateNetworkBaseUrl;
}

+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost {
    C_cacheGet = isCacheGet;
    C_cachePost = shouldCachePost;
}


#pragma mark - get

 + (CURLSessionTask *)getWithUrl:(NSString *)url
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed {
     
     return [self requestWithUrl:url
                    refreshCache:NO
                   requestMethod:1
                         showHUD:nil
                          params:nil
                         success:success
                          failed:failed];
 }

+ (CURLSessionTask *)getWithUrl:(NSString *)url
                        showHUD:(NSString *)hudText
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:1
                        showHUD:hudText
                         params:nil
                        success:success
                         failed:failed];
}

+ (CURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:1
                        showHUD:nil
                         params:params
                        success:success
                         failed:failed];
}

+ (CURLSessionTask *)getWithUrl:(NSString *)url
                        showHUD:(NSString *)hudText
                         params:(NSDictionary *)params
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:1
                        showHUD:hudText
                         params:params
                        success:success
                         failed:failed];
}


+ (CURLSessionTask *)getWithUrl:(NSString *)url
                   refreshCache:(BOOL)refreshCache
                        showHUD:(NSString *)hudText
                         params:(NSDictionary *)params
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:refreshCache
                  requestMethod:1
                        showHUD:hudText
                         params:params
                        success:success
                         failed:failed];
    
}


#pragma mark - post

+ (CURLSessionTask *)postWithUrl:(NSString *)url
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:2
                        showHUD:nil
                         params:nil
                        success:success
                         failed:failed];
}

+ (CURLSessionTask *)postWithUrl:(NSString *)url
                         showHUD:(NSString *)hudText
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:2
                        showHUD:hudText
                         params:nil
                        success:success
                         failed:failed];
}

+ (CURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:2
                        showHUD:nil
                         params:params
                        success:success
                         failed:failed];
}

+ (CURLSessionTask *)postWithUrl:(NSString *)url
                         showHUD:(NSString *)hudText
                          params:(NSDictionary *)params
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:NO
                  requestMethod:2
                        showHUD:hudText
                         params:params
                        success:success
                         failed:failed];
}

+ (CURLSessionTask *)postWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                         showHUD:(NSString *)hudText
                          params:(NSDictionary *)params
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed {
    
    return [self requestWithUrl:url
                   refreshCache:refreshCache
                  requestMethod:2
                        showHUD:hudText
                         params:params
                        success:success
                         failed:failed];
    
}

+ (CURLSessionTask *)uploadFileWithUrl:(NSString *)url
                         uploadingFile:(NSString *)uploadingFile
                              progress:(CUploadProgress)progress
                               success:(CResponseSuccess)success
                                  fail:(CResponseFailed)fail {
    if ([NSURL URLWithString:uploadingFile] == nil) {
        
        return nil;
    }
    
    NSURL *uploadURL = nil;
    if ([self baseUrl] == nil) {
        uploadURL = [NSURL URLWithString:url];
    } else {
        uploadURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]];
    }
    
    if (uploadURL == nil) {
        
        return nil;
    }
    
    CAppDotNetAPIClient *manager = [self manager];
    NSURLRequest *request = [NSURLRequest requestWithURL:uploadURL];
    CURLSessionTask *session = nil;
    
    [manager uploadTaskWithRequest:request fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        [self successResponse:responseObject callback:success];
        
        if (error) {
            [self handleCallbackWithError:error fail:fail];
            
            if ([self isDebug]) {
                [self logWithFailError:error url:response.URL.absoluteString params:nil];
            }
        } else {
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject
                                         url:response.URL.absoluteString
                                      params:nil];
            }
        }
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CURLSessionTask *)uploadWithImage:(UIImage *)image
                                 url:(NSString *)url
                            filename:(NSString *)filename
                                name:(NSString *)name
                            mimeType:(NSString *)mimeType
                          parameters:(NSDictionary *)parameters
                            progress:(CUploadProgress)progress
                             success:(CResponseSuccess)success
                                fail:(CResponseFailed)fail {
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            
            return nil;
        }
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    
    NSString *absolute = [self absoluteUrlWithPath:url];
    
    CAppDotNetAPIClient *manager = [self manager];
    CURLSessionTask *session = [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        NSString *imageFileName = filename;
        if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        
        // 上传图片，以文件流的格式
        [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[self allTasks] removeObject:task];
        [self successResponse:responseObject callback:success];
        
        if ([self isDebug]) {
            [self logWithSuccessResponse:responseObject
                                     url:absolute
                                  params:parameters];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[self allTasks] removeObject:task];
        
        [self handleCallbackWithError:error fail:fail];
        
        if ([self isDebug]) {
            [self logWithFailError:error url:absolute params:nil];
        }
    }];
    
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

+ (CURLSessionTask *)downloadWithUrl:(NSString *)url
                          saveToPath:(NSString *)saveToPath
                            progress:(CDownloadProgress)progressBlock
                             success:(CResponseSuccess)success
                             failure:(CResponseFailed)failure {
    if ([self baseUrl] == nil) {
        if ([NSURL URLWithString:url] == nil) {
            
            return nil;
        }
    } else {
        if ([NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], url]] == nil) {
            
            return nil;
        }
    }
    
    NSURLRequest *downloadRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    CAppDotNetAPIClient *manager = [self manager];
    
    CURLSessionTask *session = nil;
    
    session = [manager downloadTaskWithRequest:downloadRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        DLog(@"%lld ========  %lld",downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);
        if (progressBlock) {
            progressBlock(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:saveToPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[self allTasks] removeObject:session];
        
        if (error == nil) {
            if (success) {
                success(filePath.absoluteString);
            }
            
            if ([self isDebug]) {
                DLog(@"Download success for url %@",
                      [self absoluteUrlWithPath:url]);
            }
        } else {
            [self handleCallbackWithError:error fail:failure];
            
            if ([self isDebug]) {
                DLog(@"Download fail for url %@, reason : %@",
                      [self absoluteUrlWithPath:url],
                      [error description]);
            }
        }
    }];
    
    if (session) {
        [[self allTasks] addObject:session];
    }
    
    return session;
}

#pragma mark - request

+ (CURLSessionTask *)requestWithUrl:(NSString *)url
                       refreshCache:(BOOL)refreshCache
                      requestMethod:(NSUInteger)method
                            showHUD:(NSString *)HudText
                             params:(NSDictionary *)params
                            success:(CResponseSuccess)success
                             failed:(CResponseFailed)failed {
    
    if (url) {
        
        if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
            
        }else{
            
            NSString *serverAddress = [CServerConfig getServerAddr];
            url = [serverAddress stringByAppendingString:url];
        }
        
    }else{
        return nil;
    }
    
    if ([self shouldEncode]) {
        url = [self encodeUrl:url];
    }
    NSString *absolute = [self absoluteUrlWithPath:url];
    CURLSessionTask *session = nil;
    CAppDotNetAPIClient *manager = [self manager];
    NSMutableDictionary *dic = [self defaultParams];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [dic setObject:obj forKey:key];
    }];
    if (method == 1) {//Get
        
        
        if (C_cacheGet) {
            if (C_shoulObtainLocalWhenUnconnected) {
                if (C_networkStatus == kNetworkStatusNotReachable ||  C_networkStatus == kNetworkStatusUnknown ) {
                    id response = [CNetWorking cahceResponseWithURL:absolute
                                                          parameters:params];
                    if (response) {
                        if (success) {
                            [self successResponse:response callback:success];
                            
                            if ([self isDebug]) {
                                [self logWithSuccessResponse:response
                                                         url:absolute
                                                      params:params];
                            }
                        }
                        return nil;
                    }
                }
            }
            if (!refreshCache) {
                id response = [CNetWorking cahceResponseWithURL:absolute
                                                      parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        
        session = [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (HudText != nil) {
                
            }
            [[self allTasks] removeObject:task];
            [self successResponse:responseObject callback:success];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject url:url params:dic];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (HudText != nil) {
                
            }
            [[self allTasks] removeObject:task];
            [self handleCallbackWithError:error fail:failed];
            if ([self isDebug]) {
                [self logWithFailError:error url:url params:params];
            }
        }];
    }else if (method == 2) {
        
        
        if (C_cachePost) {
            if (C_shoulObtainLocalWhenUnconnected) {
                if (C_networkStatus == kNetworkStatusNotReachable ||  C_networkStatus == kNetworkStatusUnknown ) {
                    id response = [CNetWorking cahceResponseWithURL:absolute
                                                         parameters:params];
                    if (response) {
                        if (success) {
                            [self successResponse:response callback:success];
                            
                            if ([self isDebug]) {
                                [self logWithSuccessResponse:response
                                                         url:absolute
                                                      params:params];
                            }
                        }
                        return nil;
                    }
                }
            }
            if (!refreshCache) {
                id response = [CNetWorking cahceResponseWithURL:absolute
                                                     parameters:params];
                if (response) {
                    if (success) {
                        [self successResponse:response callback:success];
                        
                        if ([self isDebug]) {
                            [self logWithSuccessResponse:response
                                                     url:absolute
                                                  params:params];
                        }
                    }
                    return nil;
                }
            }
        }
        
        session = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (HudText != nil) {
                
            }
            [[self allTasks] removeObject:task];
            [self successResponse:responseObject callback:success];
            
            if ([self isDebug]) {
                [self logWithSuccessResponse:responseObject url:url params:params];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (HudText != nil) {
                
            }
            [[self allTasks] removeObject:task];
            [self handleCallbackWithError:error fail:failed];
            if ([self isDebug]) {
                [self logWithFailError:error url:url params:params];
            }
        }];
    }
    
    return session;
}


+ (void)cancelAllRequest {
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(CURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[CURLSessionTask class]]) {
                [task cancel];
            }
        }];
        
        [[self allTasks] removeAllObjects];
    };
}

+ (void)cancelRequestWithURL:(NSString *)url {
    if (url == nil) {
        return;
    }
    
    @synchronized(self) {
        [[self allTasks] enumerateObjectsUsingBlock:^(CURLSessionTask * _Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task isKindOfClass:[CURLSessionTask class]]
                && [task.currentRequest.URL.absoluteString hasSuffix:url]) {
                [task cancel];
                [[self allTasks] removeObject:task];
                return;
            }
        }];
    };
}


+ (BOOL)shouldEncode {
    return C_shouldAutoEncode;
}

+ (NSString *)encodeUrl:(NSString *)url {
    return [self C_URLEncode:url];
}

+ (NSString *)C_URLEncode:(NSString *)url {
    if ([url respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        
        static NSString * const kAFCharacterHTeneralDelimitersToEncode = @":#[]@";
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharacterHTeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < url.length) {
            NSUInteger length = MIN(url.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            range = [url rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [url substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)url,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}


#pragma mark - Private
+ (CAppDotNetAPIClient *)manager {
    
    @synchronized (self) {
        
        if (C_sharedManager == nil || C_isBaseURLChanged) {
            // 开启转圈圈
            [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
            
            CAppDotNetAPIClient *manager = nil;;
            if ([self baseUrl] != nil) {
                manager = [[CAppDotNetAPIClient sharedClient] initWithBaseURL:[NSURL URLWithString:[self baseUrl]]];
            } else {
                manager = [CAppDotNetAPIClient sharedClient];
            }
            
            switch (C_requestType) {
                case kRequestTypeJSON: {
                    manager.requestSerializer = [AFJSONRequestSerializer serializer];
                    break;
                }
                case kRequestTypePlainText: {
                    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
                    break;
                }
                default: {
                    break;
                }
            }
            
            switch (C_responseType) {
                case kResponseTypeJSON: {
                    manager.responseSerializer = [AFJSONResponseSerializer serializer];
                    break;
                }
                case kResponseTypeXML: {
                    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
                    break;
                }
                case kResponseTypeData: {
                    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
                    break;
                }
                default: {
                    break;
                }
            }
            
            manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
            
            
            for (NSString *key in C_httpHeaders.allKeys) {
                if (C_httpHeaders[key] != nil) {
                    [manager.requestSerializer setValue:C_httpHeaders[key] forHTTPHeaderField:key];
                }
            }
            
            manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                      @"text/html",
                                                                                      @"text/json",
                                                                                      @"text/plain",
                                                                                      @"text/javascript",
                                                                                      @"text/xml",
                                                                                      @"image/*"]];
            manager.requestSerializer.timeoutInterval = C_timeout;
            manager.operationQueue.maxConcurrentOperationCount = 3;
            C_sharedManager = manager;
        }
    }
    
    return C_sharedManager;
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
        if ([[self baseUrl] hasSuffix:@"/"]) {
            if ([path hasPrefix:@"/"]) {
                NSMutableString * mutablePath = [NSMutableString stringWithString:path];
                [mutablePath deleteCharactersInRange:NSMakeRange(0, 1)];
                absoluteUrl = [NSString stringWithFormat:@"%@%@",
                               [self baseUrl], mutablePath];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }
        }else {
            if ([path hasPrefix:@"/"]) {
                absoluteUrl = [NSString stringWithFormat:@"%@%@",[self baseUrl], path];
            }else {
                absoluteUrl = [NSString stringWithFormat:@"%@/%@",
                               [self baseUrl], path];
            }
        }
    }
    
    
    return absoluteUrl;
}


+ (NSMutableArray *)allTasks {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (C_requestTasks == nil) {
            C_requestTasks = @[].mutableCopy;
        }
    });
    
    return C_requestTasks;
}



+ (void)successResponse:(id)responseData callback:(CResponseSuccess)success {
    if (success) {
        success([self tryToParseData:responseData]);
    }
}

+ (void)handleCallbackWithError:(NSError *)error fail:(CResponseFailed)fail {
    if ([error code] == NSURLErrorCancelled) {
        if (C_shouldCallbackOnCancelRequest) {
            if (fail) {
                fail(error);
            }
        }
    } else {
        if (fail) {
            fail(error);
        }
    }
}

// 解析json数据
+ (id)tryToParseData:(id)json {
    if (!json || json == (id)kCFNull) return nil;
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([json isKindOfClass:[NSDictionary class]]) {
        dic = json;
    } else if ([json isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)json dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([json isKindOfClass:[NSData class]]) {
        jsonData = json;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

+ (NSString *)descriptionWithLocale:(NSDictionary *)locale{
    
    NSString *tempStr1 =
    [[self description] stringByReplacingOccurrencesOfString:@"\\u"
                                                  withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    
    [NSPropertyListSerialization propertyListWithData:tempData
                                              options:NSPropertyListImmutable
                                               format:NULL
                                                error:NULL];
    return str;
}

  


+ (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params {
    DLog(@"\n请求成功 ======> URL: %@\n params:%@\n response:%@\n\n ********************************华**丽**的**分**割**线************************************",
          [self generateGETAbsoluteURL:url params:params],
          params,
          [self tryToParseData:response]);
}

+ (void)logWithFailError:(NSError *)error url:(NSString *)url params:(id)params {
    NSString *format = @" params: ";
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        format = @"";
        params = @"";
    }
    
    if ([error code] == NSURLErrorCancelled) {
        DLog(@"\n请求取消 ======> URL: %@ %@%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params);
    } else {
        DLog(@"\n请求失败 ======> URL: %@ %@%@\n errorInfos:%@\n\n",
              [self generateGETAbsoluteURL:url params:params],
              format,
              params,
              [error localizedDescription]);
    }
}

+ (NSString *)generateGETAbsoluteURL:(NSString *)url params:(NSDictionary *)params {
    if (params == nil || ![params isKindOfClass:[NSDictionary class]] || [params count] == 0) {
        return url;
    }
    
    NSString *queries = @"";
    for (NSString *key in params) {
        id value = [params objectForKey:key];
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            continue;
        } else if ([value isKindOfClass:[NSArray class]]) {
            continue;
        } else if ([value isKindOfClass:[NSSet class]]) {
            continue;
        } else {
            queries = [NSString stringWithFormat:@"%@%@=%@&",
                       (queries.length == 0 ? @"&" : queries),
                       key,
                       value];
        }
    }
    
    if (queries.length > 1) {
        queries = [queries substringToIndex:queries.length - 1];
    }
    
    if (([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) && queries.length > 1) {
        if ([url rangeOfString:@"?"].location != NSNotFound
            || [url rangeOfString:@"#"].location != NSNotFound) {
            url = [NSString stringWithFormat:@"%@%@", url, queries];
        } else {
            queries = [queries substringFromIndex:1];
            url = [NSString stringWithFormat:@"%@?%@", url, queries];
        }
    }
    
    return url.length == 0 ? queries : url;
}

+ (id)cahceResponseWithURL:(NSString *)url parameters:params {
    id cacheData = nil;
    
    if (url) {
        
        NSString *directoryPath = cachePath();
        NSString *absoluteURL = [self generateGETAbsoluteURL:url params:params];
        NSString *key = [absoluteURL md5String];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        
        NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
        if (data) {
            cacheData = data;
            DLog(@"Read data from cache for url: %@\n", url);
        }
    }
    
    return cacheData;
}

+ (void)cacheResponseObject:(id)responseObject request:(NSURLRequest *)request parameters:params {
    if (request && responseObject && ![responseObject isKindOfClass:[NSNull class]]) {
        NSString *directoryPath = cachePath();
        
        NSError *error = nil;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            if (error) {
                DLog(@"create cache dir error: %@\n", error);
                return;
            }
        }
        
        NSString *absoluteURL = [self generateGETAbsoluteURL:request.URL.absoluteString params:params];
        NSString *key = [absoluteURL md5String];
        NSString *path = [directoryPath stringByAppendingPathComponent:key];
        NSDictionary *dict = (NSDictionary *)responseObject;
        
        NSData *data = nil;
        if ([dict isKindOfClass:[NSData class]]) {
            data = responseObject;
        } else {
            data = [NSJSONSerialization dataWithJSONObject:dict
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:&error];
        }
        
        if (data && error == nil) {
            BOOL isOk = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
            if (isOk) {
                DLog(@"cache file ok for request: %@\n", absoluteURL);
            } else {
                DLog(@"cache file error for request: %@\n", absoluteURL);
            }
        }
    }
}

+ (NSMutableDictionary *)defaultParams {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"FFF9922C-473A-4AF7-9784-A81022401647" forKey:@"device_id"];
    [dic setObject:[DeviceUtil deviceModelName] forKey:@"model"];
    [dic setObject:[DeviceUtil systemVersion] forKey:@"systemVersion"];
    [dic setObject:[DeviceUtil appVersion] forKey:@"version"];
    [dic setObject:[TimeUtil currentTimeStamp] forKey:@"time"];
    [dic setObject:@"U17_3.0" forKey:@"target"];
    [dic setObject:@"iphone" forKey:@"android_id"];
    
    return dic;
}

@end
