//
//  BookPageViewController.h
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/3.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

// 翻页模式
typedef NS_ENUM(NSInteger, TReaderTransitionStyle){
    TReaderTransitionStylePageCur,
    TReaderTransitionStyleScroll,
};

@interface BookPageViewController : LTBaseViewController

///
@property (nonatomic, assign) TReaderTransitionStyle style;
///
@property (nonatomic, weak) UIPageViewController * pageViewController;

@end

NS_ASSUME_NONNULL_END
