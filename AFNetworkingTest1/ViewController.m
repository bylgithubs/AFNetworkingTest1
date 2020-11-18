//
//  ViewController.m
//  AFNetworkingTest1
//
//  Created by Civet on 2020/11/11.
//  Copyright © 2020 PersonalONBYL. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

typedef NS_ENUM(NSInteger,TestType){
    Test1 = 0,
    Test2 = 1,
    Test3 = 2,
    Test4 = 4,
};
@interface ViewController ()

@property(nonatomic, assign)TestType type;

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"----------%ld",Test2);
    [self initView];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *documentPath1 = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    [self monitorNetworkStatus];
    [self sendGetRequestOfAF];
    //[self sendPostRequestOfAF];
    [self sendDownloadRequestOfAF];
    
}

- (void)initView{
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.imageView];
}

//- (AFHTTPSessionManager *)sharedManager{
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.operationQueue.maxConcurrentOperationCount = 3;
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 30.0f;
//    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
//
//    //1,2顺序不能变
//    manager.responseSerializer = [AFJSONResponseSerializer serializer]; //1
//    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain", nil];   //2
//
//    return manager;
//}

////单例
//- (AFHTTPSessionManager *)sharedManager{
//    static AFHTTPSessionManager *manager = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken,^{
//        manager = [AFHTTPSessionManager manager];
//        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        manager.operationQueue.maxConcurrentOperationCount = 3;
//        //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//        manager.requestSerializer.timeoutInterval = 15.0f;
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//        //设置请求头
////        manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain", nil];
////        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
//
//    });
//    return manager;
//}

//单例
- (AFHTTPSessionManager *)sharedManager{
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [AFHTTPSessionManager manager];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.operationQueue.maxConcurrentOperationCount = 3;
        //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        manager.requestSerializer.timeoutInterval = 15.0f;
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        //设置请求头
//        manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain", nil];
//        [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
        
    });
    return manager;
}

//- (void)sendGetRequestOfAF{
//        AFHTTPSessionManager *manager = [self sharedManager];
//            //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        //    NSString *url= @"https://oyeadmin.oyeze.com/civetBB/getLatestBackupMsg/civet1575253570483";
//            //NSString *url= @"https://www.baidu.com/";
//            NSString *url = @"https://civetadmin.foxconn.com/civetOA/getLatestBackupMsg/anna030";
//    //NSString *url = @"https://www.baidu.com";
//            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//                NSLog(@"---------------%@",downloadProgress);
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                NSLog(@"--------------%@",responseObject);
//                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//                NSLog(@"--------------%@",dic);
//            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                NSLog(@"---------------%@",error);
//            }];
//}

- (void)sendGetRequestOfAF{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *manager = [self sharedManager];
                //AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            //    NSString *url= @"https://oyeadmin.oyeze.com/civetBB/getLatestBackupMsg/civet1575253570483";
                //NSString *url= @"https://www.baidu.com/";
                NSString *url = @"https://civetadmin.foxconn.com/civetOA/getLatestBackupMsg/anna030";
        //NSString *url = @"https://www.baidu.com";
                [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                    NSLog(@"---------------%@",downloadProgress);
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"--------------%@",responseObject);
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
                    NSLog(@"--------------%@",dic);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"--------------%@",dic);
                    });
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"---------------%@",error);
                }];
    });
        
}

- (void)sendPostRequestOfAF{
    NSString *url= @"https://www.baidu.com";
    NSDictionary *parameters = @{@"name":@"aa",@"pwd":@"123"};

    [[self sharedManager] POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---------------%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----------------%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"-----------------%@",error);
    }];
}

- (void)sendUploadRequestOfAF{
    NSString *url = @"https:www.baidu.com";
    NSDictionary *parameters = @{@"name":@"upload",@"password":@"111"};
    [[self sharedManager] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        //沙盒路径
        NSString *filePath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"fileName.txt"]];
        //根目录路径
        NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"fileName.txt" ofType:@"txt"];
        //多个文件上传可以使用for循环
        [formData appendPartWithFileURL:[NSURL fileURLWithPath:filePath1] name:@"headUrl" fileName:@"fileName.txt" mimeType:@"application/octet-stream" error:nil]; //application/octet-stream , image/png
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:path] name:@"filebody1" fileName:@"txt" mimeType:@"application/octet-stream" error:nil]; 
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功：%@",responseObject);
        //data转NSString
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败:%@",error);
    }];
}

- (void)sendDownloadRequestOfAF{
    NSString *urlStr= @"http://cn.bing.com/az/hprichbg/rb/WindmillLighthouse_ZH-CN12870536851_1920x1080.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [[self sharedManager] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"当前下载进度为：%lf",1.0 * downloadProgress.completedUnitCount/downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *downloadPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
        NSLog(@"默认下载地址%@",downloadPath);
        NSString *fileName = [NSString stringWithFormat:@"fileName.jpg"];
        NSString *filePath = [downloadPath stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath:%@",filePath);
        NSData *data = [NSData dataWithContentsOfURL:filePath];
        //假设为图片数据
        UIImage *image = [UIImage imageWithData:data];
        [self.imageView setImage:image];
    }];
    //启动下载任务
    [task resume];
}

+ (AFSecurityPolicy *)customSecurityPolicy{
    //Https CA证书地址
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"HTTPSCer" ofType:@"cer"];
    //获取CA证书数据
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //创建AFSecurityPolicy对象
    AFSecurityPolicy *security = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    //设置是否允许不信任的证书（证书无效、证书时间过期）通过验证 ，默认为NO.
    security.allowInvalidCertificates = YES;
    //是否验证域名证书的CN(common name)字段。默认值为YES。
    security.validatesDomainName = NO;
    //根据验证模式来返回用于验证服务器的证书
    security.pinnedCertificates = [NSSet setWithObject:cerData];
    return security;
}


-(AFHTTPSessionManager *)sharedManager2
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //最大请求并发任务数
    manager.operationQueue.maxConcurrentOperationCount = 5;

    // 请求格式
    // AFHTTPRequestSerializer            二进制格式
    // AFJSONRequestSerializer            JSON
    // AFPropertyListRequestSerializer    PList(是一种特殊的XML,解析起来相对容易)
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = 30.0f;
    // 设置请求头
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    // 设置接收的Content-Type
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];
    
    // 返回格式
    // AFHTTPResponseSerializer           二进制格式
    // AFJSONResponseSerializer           JSON
    // AFXMLParserResponseSerializer      XML,只能返回XMLParser,还需要自己通过代理方法解析
    // AFXMLDocumentResponseSerializer (Mac OS X)
    // AFPropertyListResponseSerializer   PList
    // AFImageResponseSerializer          Image
    // AFCompoundResponseSerializer       组合
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回格式 JSON
    //设置返回C的ontent-type
    manager.responseSerializer.acceptableContentTypes=[[NSSet alloc] initWithObjects:@"application/xml", @"text/xml",@"text/html", @"application/json",@"text/plain",nil];

    return manager;
}

- (void)monitorNetworkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        switch (status){
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"无网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"蜂窝数据网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                break;
            default:
                break;
        }
    }];
    [manager startMonitoring];
}


- (void)testQueue{
    dispatch_group_t group = dispatch_group();
}

static dispatch_group_t dispatch_group(){
    static dispatch_group_t group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        group = dispatch_group_create();
    });
    return group;
}

NSArray* array(){
    NSArray *arr;
    return arr;
}

//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
////    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//    policy.allowInvalidCertificates = YES;
//    policy.validatesDomainName = NO;
//    //manager.securityPolicy = policy;
//    manager.operationQueue.maxConcurrentOperationCount = 5;
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.requestSerializer.timeoutInterval = 15.0f;
//    NSString *userInfo1 = [NSString stringWithFormat:@"%@:%@",CivetMall_Web_Request_UserName,CivetMall_Web_Request_PassWord];
//    NSString *authorization = [NSString stringWithFormat:@"Basic %@",[userInfo1 base64EncodedString]];
//    [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
////    [manager.requestSerializer setValue:CivetMall_Web_Request_UserName forHTTPHeaderField:@"username"];
////    [manager.requestSerializer setValue:CivetMall_Web_Request_PassWord forHTTPHeaderField:@"password"];
//
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain", nil];
//
//
//    NSString *url = @"https://civetadmin.foxconn.com/civetOA/getLatestBackupMsg/anna030";
//
//    NSDictionary *param11 = @{@"username":CivetMall_Web_Request_UserName,@"password":CivetMall_Web_Request_PassWord};
//    [manager GET:url parameters:param11 progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"---------------%@",downloadProgress);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"--------------%@",responseObject);
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        NSLog(@"--------------%@",dic);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"---------------%@",error);
//    }];

@end
