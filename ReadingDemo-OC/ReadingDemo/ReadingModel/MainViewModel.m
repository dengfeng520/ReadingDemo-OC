//
//  MainViewModel.m
//  ReadingDemo-OC
//
//  Created by RP. wang on 2018/12/20.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "MainViewModel.h"
#import "LTserverManger+category.h"



@implementation MainViewModel

-(instancetype)init{
    self = [super init];
    if(self){

        //步骤一:创建命令
        self.listCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
           
            //步骤二:创建信号,用来传递数据
            RACSignal *signal = [[LTserverManger shareServerManger]postRecommendListDatafromServer:200];

            return signal;
        }];
    }
    return self;
}

@end
