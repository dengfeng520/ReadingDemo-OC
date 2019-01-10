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
    //先判断内存中是否有缓存数据
    UIImage *cacheImg = [self.imgCacheData objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    //检查内存缓存
    if(cacheImg){
        cell.bookImg.image = cacheImg;
        NSLog(@"======================cache\n");
    }else{
     
        NSString *fullPathStr = [self getComponentFile:[NSString stringWithFormat:@"%d",(int)indexPath.row]];
        //是否有硬盘缓存
        NSData *imgData = [NSData dataWithContentsOfFile:fullPathStr];
        if(imgData){
            NSLog(@"=====================hard disk\n");
            //赋值操作
            cell.bookImg.image = [UIImage imageWithData:imgData];
            //加入到内存中
            [self.imgCacheData setObject:[UIImage imageWithData:imgData] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
            
        }else{
            //设置默认占位图片
            cell.bookImg.image = [UIImage imageNamed:@"Placeholder"];
            //滚动时不进行下载操作
            if(self.listView.dragging == NO && self.listView.decelerating == NO){
                
                [self startImageDownload:imgModel forIndexPath:indexPath];
                //开启下载队列
//                dispatch_async(self.GCDQueue, ^{
//                    //获取图片URL
//                    NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgModel.label]];
//                    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
//                    NSLog(@"======================download\n");
//                    //[self.imgCacheHashMap setObject:[UIImage imageWithData:imgData] forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
//                    //加入内存缓存中
//                    [self.imgCacheData setObject:[UIImage imageWithData:imgData] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//                    //同时缓存到硬盘中
//                    [imgData writeToFile:fullPathStr atomically:YES];
//                    //返回主线程
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        //下载完成后 刷新cell
//                        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
//                        //加载图片
//                        cell.bookImg.image = [UIImage imageWithData:imgData];
//                    });
//                });
                //==============================
            }
           
            
            
            //==============================
        }
        //        NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgModel.label]];
        //        [cell.bookImg sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Placeholder"]];
        //        [cell.bookImg sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Placeholder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //
        //        }];
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

// MARK: - UIScrollViewDelegate
//用户停止拖拽时
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(decelerate){
        [self loadImageForOnscreenRows];
    }
}
// 完全停止滚动时开始下载图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self loadImageForOnscreenRows];
}

// MARK: - download Image
-(void)loadImageForOnscreenRows{
    if(self.bookList.count > 0){
        NSArray *visiblePaths = [self.listView indexPathsForVisibleItems];
        for (NSIndexPath *indexPath in visiblePaths){
            //============================= get Model data
            ReadModel *model = self.bookList[indexPath.row];
            im_image *imgModel = model.im_image.lastObject;
            [self startImageDownload:imgModel forIndexPath:indexPath];
        }
    }else{
        return;
    }
}

//download
-(void)startImageDownload:(im_image *)imgModel forIndexPath:(NSIndexPath *)indexPath{
    //开启下载队列
    dispatch_async(self.GCDQueue, ^{
        //获取图片URL
        NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgModel.label]];
        NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
        NSLog(@"======================download\n");
        //加入内存缓存中
        [self.imgCacheData setObject:[UIImage imageWithData:imgData] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        //获取沙盒路径
        NSString *fullPathStr = [self getComponentFile:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        //同时缓存到硬盘中
        [imgData writeToFile:fullPathStr atomically:YES];
        //返回主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listView reloadItemsAtIndexPaths:@[indexPath]];
            MainCollectionCell *cell = (MainCollectionCell *)[self.listView cellForItemAtIndexPath:indexPath];
            //加载图片
            cell.bookImg.image = [UIImage imageWithData:imgData];
        });
    });
    
//    NSBlockOperation *downloadBlock = [NSBlockOperation  blockOperationWithBlock:^{
//
//        // 返回主线程
//        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
//
//        }];
//    }];
//    //加入到队列中
//    [self.queue addOperation:downloadBlock];
}

-(NSString *)getComponentFile:(NSString *)fileName{
    //获取沙盒路径
    NSString *ComponentFileName = [fileName lastPathComponent];
    //获取Cache路径
    NSString *cachePahtStr = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //获取完整路径
    NSString *fullPathStr = [cachePahtStr stringByAppendingPathComponent:ComponentFileName];
    
    return fullPathStr;
}

@end

