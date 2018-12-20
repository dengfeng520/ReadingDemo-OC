//
//  LTserverManger.h
//  ReadingDemo-OC
//
//  Created by RP. wang on 2018/12/20.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LTStatusCode) {
    LTStatus_Success = 0,
    LTStatus_Offline = -1009,
    LTStatus_Timeout = -1001,
};

@interface LTserverManger : NSObject

+(instancetype)shareServerManger;
///POST
-(RACSignal *)postSignalWithAPI:(NSString *)api paramters:(NSDictionary *)parameters;

@end

NS_ASSUME_NONNULL_END
