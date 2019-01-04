//
//  BookPageViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/3.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "BookPageViewController.h"

@interface BookPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
///
@property (nonatomic, weak) UIPageViewController * pageViewController;

@end

@implementation BookPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"ReadingBook",  @"description for this key.");
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];

}

// MARK: - PageView
-(void)createPageViewController{
    
}


@end