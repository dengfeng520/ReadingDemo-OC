//
//  MainViewController+category.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "MainViewController+category.h"
#import "MainCollectionCell.h"
#import "UIImageView+WebCache.h"

typedef void(^runloopBlock)(void);


static NSString * const MainCollectionCellID = @"MainCollectionCellID";


@implementation MainViewController (category)

-(void)loadView{
    [super loadView];
    
    //注册Cell
    [self.listView registerClass:[MainCollectionCell class] forCellWithReuseIdentifier:MainCollectionCellID];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.bookList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MainCollectionCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];

    __weak typeof (self) weakSelf = self;
    //============================= 从Model中获取数据
    ReadModel *model = weakSelf.bookList[indexPath.row];
    im_image *imgModel = model.im_image.lastObject;
    
    
    //=============================
//    UIImage *cacheImg = [self.imgCacheHashMap objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    UIImage *cacheImg = [self.imgCacheData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if(cacheImg){
        cell.bookImg.image = cacheImg;
        NSLog(@"======================\n");
    }else{
        NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgModel.label]];

//        [cell.bookImg sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Placeholder"]];

        NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
        cell.bookImg.image = [UIImage imageWithData:imgData];

        //放到缓存中
//        [self.imgCacheHashMap setObject:[UIImage imageWithData:imgData] forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
        [self.imgCacheData setObject:[UIImage imageWithData:imgData] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    }
    
    

    //=============================
    cell.bookNameLab.text = [[NSString stringWithFormat:@"%@",model.im_name.label]stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    //=============================
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat cellWidth = self.listView.frame.size.width / 3 - 4;

    return CGSizeMake(cellWidth, cellWidth * 1.4);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = {0.f ,0.f};
    return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController *bookPageView = [[NSClassFromString(@"BookPageViewController") alloc]init];
//    SEL aSelector = NSSelectorFromString(@"setIsPlayLaunchAnimation:");
//    if ([bookPageView respondsToSelector:aSelector]) {
//        IMP aIMP = [bookPageView methodForSelector:aSelector];
//        void (*setter)(id, SEL, BOOL) = (void(*)(id, SEL, BOOL))aIMP;
//        setter(bookPageView, aSelector,true);
//    }
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:bookPageView animated:NO];
}


@end
