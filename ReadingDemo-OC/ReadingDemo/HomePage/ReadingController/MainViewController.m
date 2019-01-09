//
//  MainViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "MainViewController.h"

#import "MJExtension.h"
#import "MBProgressHUD.h"



@interface MainViewController ()<NSCacheDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"bookshelf",  @"description for this key.");

    __weak typeof (self) weakSelf = self;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    
    //步骤四:订阅信号量
    [[[self.viewModel.listCommand executionSignals]switchToLatest]subscribeNext:^(id  _Nullable x) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:true];
        if([[x allKeys]containsObject:@"feed"]){
            NSDictionary *hashMap = [x objectForKey:@"feed"];
            // ---> Model
            NSArray *lsList = [ReadModel mj_objectArrayWithKeyValuesArray:hashMap[@"entry"]];
            weakSelf.bookList = [lsList mutableCopy];
            // ---> Update
            [weakSelf.listView reloadData];
        }
    }];
    //步骤三:执行命令
    [weakSelf.viewModel.listCommand execute:nil];
}


// MARK: - lazy data
-(UICollectionView *)listView{
    if(_listView == nil){
        __weak typeof (self) weakSelf = self;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.frame.size.width - 30, self.view.frame.size.height);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _listView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_listView];
        _listView.delegate = self;
        _listView.dataSource = self;
        _listView.showsVerticalScrollIndicator = false;
        _listView.showsHorizontalScrollIndicator = false;
        _listView.backgroundColor = [UIColor whiteColor];
        [_listView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.view).with.insets(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }
    return _listView;
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"\n================== remove old data %@\n",obj);
}

-(MainViewModel *)viewModel{
    if(_viewModel == nil){
        _viewModel = [[MainViewModel alloc]init];
    }
    return _viewModel;
}

-(NSMutableArray *)bookList{
    if(_bookList == nil){
        _bookList = [NSMutableArray array];
    }
    return _bookList;
}

-(NSMutableDictionary *)imgCacheHashMap{
    if(_imgCacheHashMap == nil){
        _imgCacheHashMap = [NSMutableDictionary dictionary];
    }
    return _imgCacheHashMap;
}

-(NSCache *)imgCacheData{
    if(_imgCacheData == nil){
        _imgCacheData = [[NSCache alloc]init];
        _imgCacheData.delegate = self;
        //设置缓存数据数量
        _imgCacheData.countLimit = LINK_MAX;
        //设置缓存数据占据内存大小
        _imgCacheData.totalCostLimit = 180 * MAX_CANON * MAX_CANON;
    }
    return _imgCacheData;
}

@end
