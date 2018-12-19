//
//  MainViewController+category.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "MainViewController+category.h"

@implementation MainViewController (category)

-(void)loadView{
    [super loadView];
    
    self.listView.delegate = self;
    self.listView.dataSource = self;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10086;
}



@end
