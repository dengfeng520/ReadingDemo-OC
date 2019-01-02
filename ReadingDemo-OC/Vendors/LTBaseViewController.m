//
//  LTBaseViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "LTBaseViewController.h"

@interface LTBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation LTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //------------------------------
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //------------------------------
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    
    //------------------------------
    UIColor *txtColer = [UIColor colorWithRed:99/ 255.0 green:108/ 255.0 blue:238/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = txtColer;
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont fontWithName:@"Montserrat-Bold" size:16.5], NSForegroundColorAttributeName:txtColer}];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] init];
    self.navigationItem.backBarButtonItem.title = @"";
}


@end
