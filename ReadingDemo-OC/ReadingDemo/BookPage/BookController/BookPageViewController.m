//
//  BookPageViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/3.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "BookPageViewController.h"

@interface BookPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>


@end

@implementation BookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"ReadingBook",  @"description for this key.");
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    //===============================
    [self createPageViewController];

}

// MARK: - PageView
-(void)createPageViewController{
    UIPageViewController *pageViewController = self.style == TReaderTransitionStyleScroll ? [[UIPageViewController alloc]init] : [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    pageViewController.view.frame = self.view.bounds;
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    self.pageViewController = pageViewController;
    
}


@end
