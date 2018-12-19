//
//  MainViewController.h
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : LTBaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *listView;

@end

NS_ASSUME_NONNULL_END
