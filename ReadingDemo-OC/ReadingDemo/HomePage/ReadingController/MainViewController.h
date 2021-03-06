//
//  MainViewController.h
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTBaseViewController.h"
#import "Masonry.h"
#import "ReactiveObjC.h"
#import "MainViewModel.h"
#import "ReadModel.h"

NS_ASSUME_NONNULL_BEGIN

//runLoop tasks blocks
typedef void(^runloopBlock)(void);

@interface MainViewController : LTBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *listView;
///
@property (strong, nonatomic) MainViewModel *viewModel;
///
@property (strong, nonatomic) NSMutableArray *bookList;
///
@property (strong, nonatomic) NSMutableDictionary *imgCacheHashMap;
///
@property (strong, nonatomic) NSCache *imgCacheData;
///
@property (strong, nonatomic) NSOperationQueue *queue;
///
@property (retain, nonatomic) dispatch_queue_t GCDQueue;
// tasks Array
@property (nonatomic, strong) NSMutableArray *tasksList;
// Max tasks
@property (nonatomic, assign) NSUInteger maxTaskCount;

@end

NS_ASSUME_NONNULL_END
