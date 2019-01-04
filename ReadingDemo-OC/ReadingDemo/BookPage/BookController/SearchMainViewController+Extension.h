//
//  SearchMainViewController+Extension.h
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/4.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//



NS_ASSUME_NONNULL_BEGIN

// 翻页模式
NS_ENUM(NSInteger, TReaderTransitionStyle){
    TReaderTransitionStylePageCur,
    TReaderTransitionStyleScroll,
};

@interface SearchMainViewController ()

@property (nonatomic, assign) TReaderTransitionStyle style;

@end

NS_ASSUME_NONNULL_END
