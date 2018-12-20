//
//  LTserverManger+category.h
//  ReadingDemo-OC
//
//  Created by RP. wang on 2018/12/20.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTserverManger.h"

NS_ASSUME_NONNULL_BEGIN

@interface LTserverManger (category)

-(RACSignal *)postRecommendListDatafromServer:(int)pageSize;

@end

NS_ASSUME_NONNULL_END
