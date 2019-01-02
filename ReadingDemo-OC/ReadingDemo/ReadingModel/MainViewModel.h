//
//  MainViewModel.h
//  ReadingDemo-OC
//
//  Created by RP. wang on 2018/12/20.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC.h"
#import "LTserverManger.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewModel : NSObject

@property (strong, nonatomic) RACCommand *listCommand;

@end

NS_ASSUME_NONNULL_END
