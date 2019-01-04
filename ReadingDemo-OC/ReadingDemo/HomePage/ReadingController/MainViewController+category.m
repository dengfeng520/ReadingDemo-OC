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
    
//    self.maxTaskCount = 21;
//    //
//    self.tasks = [NSMutableArray array];
//    // 创建定时器 (保证runloop回调函数一直在执行)
//    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self
//                                                             selector:@selector(notDoSomething)];
//    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
//
//    //添加runloop观察者
//    [self addRunloopObserver];
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
    //=============================
    ReadModel *model = weakSelf.bookList[indexPath.row];
//    NSArray *imgList = weakSelf.bookList[indexPath.row][@"im:image"];
    im_image *imgModel = model.im_image.lastObject;
    NSURL *imgURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",imgModel.label]];
    [cell.bookImg sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    // 耗时操作可以放在任务中
//    [self addTask:^{
//
//        [cell.bookImg sd_setImageWithURL:imgURL completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            
//            //对图片压缩处理
//            CGSize newSize;
//            
//            CGImageRef imageRef = nil;
//            
//            if ((image.size.width / image.size.height) < 1) {
//                
//                newSize.width = image.size.width;
//                
//                newSize.height = image.size.width ;
//                
//                imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
//                
//            } else {
//                
//                newSize.height = image.size.height;
//                
//                newSize.width = image.size.height * 1;
//                
//                imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
//            }
//        }];
//    }];
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
    CATransition* transition = [CATransition animation];
    transition.duration = 0.35;
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:bookPageView animated:NO];
}


//// MARK: - RunLoop优化相关
//-(void)notDoSomething{
//
//}
////删除所有任务
//- (void)removeAllTasks{
//    [self.tasks removeAllObjects];
//}
//
////add task 添加任务
//- (void)addTask:(runloopBlock)unit{
//    //添加任务到数组
//    [self.tasks addObject:unit];
//
//    if (self.tasks.count > self.maxTaskCount) {
//        [self.tasks removeObjectAtIndex:0];
//    }
//}
//
////这里处理耗时操作了
//static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
//
//    //通过info桥接为当前的对象
//    MainViewController *runloop = (__bridge MainViewController *)info;
//
//    //如果没有任务，就直接返回
//    if (runloop.tasks.count == 0) {
//        return;
//    }
//
//    BOOL result = NO;
//    while (result == NO && runloop.tasks.count) {
//
//        //取出任务
//        runloopBlock unit = runloop.tasks.firstObject;
//        // 执行任务
//        if (unit) {
//            unit();
//        }
//        //删除任务
//        [runloop.tasks removeObjectAtIndex:0];
//    }
//}
////添加runloop监听者
//- (void)addRunloopObserver{
//
//    //    获取 当前的Runloop ref - 指针
//    CFRunLoopRef current =  CFRunLoopGetCurrent();
//
//    //定义一个RunloopObserver
//    CFRunLoopObserverRef defaultModeObserver;
//
//    //上下文
//    /*
//     typedef struct {
//     CFIndex    version; //版本号 long
//     void *    info;    //这里我们要填写对象（self或者传进来的对象）
//     const void *(*retain)(const void *info);        //填写&CFRetain
//     void    (*release)(const void *info);           //填写&CGFRelease
//     CFStringRef    (*copyDescription)(const void *info); //NULL
//     } CFRunLoopObserverContext;
//     */
//    CFRunLoopObserverContext context = {
//        0,
//        (__bridge void *)(self),
//        &CFRetain,
//        &CFRelease,
//        NULL
//    };
//
//    /*
//     1 NULL空指针 nil空对象 这里填写NULL
//     2 模式
//     kCFRunLoopEntry = (1UL << 0),
//     kCFRunLoopBeforeTimers = (1UL << 1),
//     kCFRunLoopBeforeSources = (1UL << 2),
//     kCFRunLoopBeforeWaiting = (1UL << 5),
//     kCFRunLoopAfterWaiting = (1UL << 6),
//     kCFRunLoopExit = (1UL << 7),
//     kCFRunLoopAllActivities = 0x0FFFFFFFU
//     3 是否重复 - YES
//     4 nil 或者 NSIntegerMax - 999
//     5 回调
//     6 上下文
//     */
//    //    创建观察者
//    defaultModeObserver = CFRunLoopObserverCreate(NULL,
//                                                  kCFRunLoopBeforeWaiting, YES,
//                                                  NSIntegerMax - 999,
//                                                  &Callback,
//                                                  &context);
//
//    //添加当前runloop的观察着
//    CFRunLoopAddObserver(current, defaultModeObserver, kCFRunLoopDefaultMode);
//
//    //释放
//    CFRelease(defaultModeObserver);
//}


@end
