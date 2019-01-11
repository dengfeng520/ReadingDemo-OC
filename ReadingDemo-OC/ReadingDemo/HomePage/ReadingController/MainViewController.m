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
    
    NSCache *testCache = [[NSCache alloc]init];
    testCache.delegate = self;
    //设置缓存数据数量
    testCache.countLimit = 5;
    for(int i = 0;i< 10;i++){
        [testCache setObject:[NSNumber numberWithInt:i] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for(int x = 0;x<10;x++){
            NSNumber *number = [testCache objectForKey:[NSString stringWithFormat:@"%d",x]];
            NSLog(@"cache data ==============%@",number);
        }
    });

    
    self.title = NSLocalizedString(@"bookshelf",  @"description for this key.");

    __weak typeof (self) weakSelf = self;
    
    NSString *filePath = [self documentsPath:@"homeList.txt"];

    NSArray *temporaryList = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"==============%ld",(long)temporaryList.count);
    if(temporaryList){
        NSLog(@"List Cache=================");
        // ---> Model
        NSArray *lsList = [ReadModel mj_objectArrayWithKeyValuesArray:temporaryList];
        weakSelf.bookList = [lsList mutableCopy];
        // ---> Update
        [weakSelf.listView reloadData];

    }else{
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

                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    NSLog(@"List Https=================%ld",(long)lsList.count);
                    // cache
                    NSArray *lsAry = hashMap[@"entry"];
                    [lsAry writeToFile:filePath atomically:YES];
                });
            }
        }];
        //步骤三:执行命令
        [weakSelf.viewModel.listCommand execute:nil];
    }
}

-(NSString *)documentsPath:(NSString *)fileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
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
//    NSLog(@"\n================== remove old data %@\n",obj);
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

-(NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}
-(dispatch_queue_t)GCDQueue{
    if(_GCDQueue == nil){
        _GCDQueue = dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    }
    return _GCDQueue;
}

-(NSMutableArray *)tasksList{
    if(_tasksList == nil){
        _tasksList = [NSMutableArray array];
    }
    return _tasksList;
}

@end
