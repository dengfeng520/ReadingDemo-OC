//
//  MainViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"bookshelf",  @"description for this key.");

    __weak typeof (self) weakSelf = self;
    //步骤四:订阅信号量
    [[[self.viewModel.listCommand executionSignals]switchToLatest]subscribeNext:^(id  _Nullable x) {
       
        if([[x allKeys]containsObject:@"feed"]){
            NSDictionary *hashMap = [x objectForKey:@"feed"];
            weakSelf.bookList = hashMap[@"entry"];
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


@end
