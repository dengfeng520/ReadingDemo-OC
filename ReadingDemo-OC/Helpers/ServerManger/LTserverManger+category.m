//
//  LTserverManger+category.m
//  ReadingDemo-OC
//
//  Created by RP. wang on 2018/12/20.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTserverManger+category.h"

@implementation LTserverManger (category)

-(RACSignal *)postRecommendListDatafromServer:(int)pageSize{
    
    return [self postSignalWithAPI:[NSString stringWithFormat:@"http://phobos.apple.com/WebObjects/MZStoreServices.woa/ws/RSS/toppaidapplications/limit=%d/json",pageSize] paramters:@{}];
    return [RACSignal empty];
}

@end
