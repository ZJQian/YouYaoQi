//
//  CNetWorking.h
//  OC_Cloud
//
//  Created by ZJQian on 2018/11/28.
//  Copyright © 2018 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, CRequestType) {
    kRequestTypeJSON = 1,       // 默认
    kRequestTypePlainText  = 2  // 普通text/html
};

typedef NS_ENUM(NSUInteger, CResponseType) {
    kResponseTypeJSON = 1, // 默认
    kResponseTypeXML  = 2, // XML
    kResponseTypeData = 3  //
};

typedef NS_ENUM(NSInteger, CNetworkStatus) {
    kNetworkStatusUnknown          = -1,  //未知网络
    kNetworkStatusNotReachable     = 0,   //网络无连接
    kNetworkStatusReachableViaWWAN = 1,   //2，3，4G网络
    kNetworkStatusReachableViaWiFi = 2,   //WIFI网络
};


/**
 *  所有的接口返回值均为NSURLSessionTask
 */
typedef NSURLSessionTask CURLSessionTask;

/**
 成功回调
 */
typedef void(^CResponseSuccess)(id response);


/**
 失败回调
 */
typedef void(^CResponseFailed)(id error);

/*!
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 */
typedef void (^CDownloadProgress)(int64_t bytesRead,int64_t totalBytesRead);

typedef CDownloadProgress GetProgress;
typedef CDownloadProgress PostProgress;

/*!
 *
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^CUploadProgress)(int64_t bytesWritten,int64_t totalBytesWritten);

@interface CNetWorking : NSObject


#pragma mark - GET
/**
 get请求
 
 */
+ (CURLSessionTask *)getWithUrl:(NSString *)url
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed;



/**
 get请求(有提示框)

 */
+ (CURLSessionTask *)getWithUrl:(NSString *)url
                        showHUD:(NSString *)hudText
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed;


/**
 get请求(带参数,无提示框)

 */
+ (CURLSessionTask *)getWithUrl:(NSString *)url
                         params:(NSDictionary *)params
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed;



/**
 get 请求(带参数,带提示框)

 */
+ (CURLSessionTask *)getWithUrl:(NSString *)url
                        showHUD:(NSString *)hudText
                         params:(NSDictionary *)params
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed;



/**
 get 请求(是否刷新缓存,带参数,带提示框)
 
 */
+ (CURLSessionTask *)getWithUrl:(NSString *)url
                   refreshCache:(BOOL)refreshCache
                        showHUD:(NSString *)hudText
                         params:(NSDictionary *)params
                        success:(CResponseSuccess)success
                         failed:(CResponseFailed)failed;


#pragma mark - POST

/**
 post请求
 
 */
+ (CURLSessionTask *)postWithUrl:(NSString *)url
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed;



/**
 post请求(有提示框)
 
 */
+ (CURLSessionTask *)postWithUrl:(NSString *)url
                         showHUD:(NSString *)hudText
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed;


/**
 post请求(带参数,无提示框)
 
 */
+ (CURLSessionTask *)postWithUrl:(NSString *)url
                          params:(NSDictionary *)params
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed;



/**
 post 请求(带参数,带提示框)
 
 */
+ (CURLSessionTask *)postWithUrl:(NSString *)url
                         showHUD:(NSString *)hudText
                          params:(NSDictionary *)params
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed;


/**
 post 请求(是否刷新缓存,带参数,带提示框)
 
 */
+ (CURLSessionTask *)postWithUrl:(NSString *)url
                    refreshCache:(BOOL)refreshCache
                         showHUD:(NSString *)hudText
                          params:(NSDictionary *)params
                         success:(CResponseSuccess)success
                          failed:(CResponseFailed)failed;



#pragma mark - FILE

/**
 *
 *    图片上传接口，若不指定baseurl，可传完整的url
 *
 *    @param image           图片对象
 *    @param url             上传图片的接口路径，如/path/images/
 *    @param filename        给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *    @param name            与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *    @param mimeType        默认为image/jpeg
 *    @param parameters      参数
 *    @param progress        上传进度
 *    @param success         上传成功回调
 *    @param fail            上传失败回调
 *
 */
+ (CURLSessionTask *)uploadWithImage:(UIImage *)image
                                  url:(NSString *)url
                             filename:(NSString *)filename
                                 name:(NSString *)name
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary *)parameters
                             progress:(CUploadProgress)progress
                              success:(CResponseSuccess)success
                                 fail:(CResponseFailed)fail;

/**
 *
 *    上传文件操作
 *
 *    @param url                 上传路径
 *    @param uploadingFile       待上传文件的路径
 *    @param progress            上传进度
 *    @param success             上传成功回调
 *    @param fail                上传失败回调
 *
 */
+ (CURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                               progress:(CUploadProgress)progress
                                success:(CResponseSuccess)success
                                   fail:(CResponseFailed)fail;


/*!
 *
 *  下载文件
 *
 *  @param url           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 */
+ (CURLSessionTask *)downloadWithUrl:(NSString *)url
                          saveToPath:(NSString *)saveToPath
                            progress:(CDownloadProgress)progressBlock
                             success:(CResponseSuccess)success
                             failure:(CResponseFailed)failure;



#pragma mark - CANCEL

/**
 取消所有请求
 */
+ (void)cancelAllRequest;



/**
 取消某个请求

 @param url 请求地址
 */
+ (void)cancelRequestWithURL:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
