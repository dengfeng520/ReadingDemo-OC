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

@interface MainViewController : LTBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *listView;
///
@property (strong, nonatomic) MainViewModel *viewModel;
///
@property (strong, nonatomic) NSMutableArray *bookList;
///
@property (strong, nonatomic) NSMutableDictionary *imgCacheHashMap;
///
@property (strong, nonatomic) NSCache *imgCacheData;


@end

NS_ASSUME_NONNULL_END
