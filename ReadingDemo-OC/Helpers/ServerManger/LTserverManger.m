//
//  LTserverManger.m
//  ReadingDemo-OC
//
//  Created by RP. wang on 2018/12/20.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTserverManger.h"
#import <CommonCrypto/CommonCrypto.h>
#import "AFNetworking.h"

typedef void (^LTResponseBlock)(NSURLSessionDataTask *task, id responseObject, NSError *error);

@interface LTserverManger ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation LTserverManger

static LTserverManger *__serverManger;
static dispatch_once_t onceToken;

+(instancetype)shareServerManger{
    dispatch_once(&onceToken, ^{
        __serverManger = [[LTserverManger alloc]init];
    });
    return __serverManger;
}

-(instancetype)init{
    self = [super init];
    if(self){
        _sessionManager = [AFHTTPSessionManager manager];
        //header
        AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
        [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //time out
        requestSerializer.timeoutInterval = 20.f;
        _sessionManager.requestSerializer = requestSerializer;
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                                     @"application/json",
                                                                     @"text/json",
                                                                     @"text/javascript",
                                                                     @"text/html",
                                                                     @"text/plain",nil];
    }
    return self;
}

+(instancetype)alloc{
    NSCAssert(!__serverManger, @"Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'There can only be one LTserverManger instance.'");
    return [super alloc];
}

// POST
- (NSURLSessionDataTask *)POST:(NSString *)api paramters:(NSDictionary *)paramters completion:(LTResponseBlock)completion{
    
    NSURLSessionDataTask *dataTask = [_sessionManager POST:api parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!completion) return;
        
        NSString *statusCode = responseObject[@"errno"];
        NSDictionary *data = responseObject;
        
        if (statusCode.integerValue == LTStatus_Success) {
            completion(task,data,nil);
        }else{
            NSError *error = [[NSError alloc] initWithDomain:NSCocoaErrorDomain code:statusCode.integerValue userInfo:@{NSLocalizedDescriptionKey:responseObject[@"msg"]}];
            completion(task,nil,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (!completion) return;
        completion(task,nil,error);
    }];
    return dataTask;
}

//MARK: - POST
-(RACSignal *)postSignalWithAPI:(NSString *)api paramters:(NSDictionary *)parameters{
    
    NSString *apiURLString = [NSString stringWithFormat:@"%@",api];
    @weakify(self)
    //创建信号
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self);
        NSURLSessionDataTask *dataTask = [self POST:apiURLString paramters:parameters completion:^(NSURLSessionDataTask *task, id responseObject, NSError *error) {
            //信号传递
            if(error){
                [subscriber sendError:error];
            }else{
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            }
        }];
        //步骤五:检测信号是否执行完了
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }];
}

-(void)clearData{
    __serverManger = nil;
    onceToken = 0;
}

@end
