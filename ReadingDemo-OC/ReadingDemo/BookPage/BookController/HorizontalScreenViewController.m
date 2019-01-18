//
//  HorizontalScreenViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/17.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "HorizontalScreenViewController.h"
#import "Masonry.h"

@interface HorizontalScreenViewController ()

///
@property (strong, nonatomic) UIView *loginView;
///
@property (strong, nonatomic) UIButton *leftBtn;
///
@property (strong, nonatomic) UIButton *rightBtn;
@end

@implementation HorizontalScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self createTestView];

}

- (void)setInterfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}



// 设备支持方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

// 默认方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft; // 或者其他值 balabala~
}

// 开启自动转屏
- (BOOL)shouldAutorotate {
    return YES;
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    if (size.width > size.height) {
        // 横屏布局
        [self horizontalScreenConstraint];
    } else {
        // 竖屏布局
        [self verticalScreenConstraint];
    }
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
        // 横屏
        [self horizontalScreenConstraint];
    }else{
        // 竖屏
        [self verticalScreenConstraint];
    }
}


// MARK: - 竖屏约束
-(void)verticalScreenConstraint{
    
    __weak typeof (self) weakSelf = self;
    _loginView.backgroundColor = [UIColor redColor];
    [_loginView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //
        make.center.equalTo(weakSelf.view).with.offset(0);
        //
        make.width.mas_equalTo(250);
        //
        make.height.mas_equalTo(200);
    }];
}

// MARK: - 横屏约束
-(void)horizontalScreenConstraint{
    
    __weak typeof (self) weakSelf = self;
    _loginView.backgroundColor = [UIColor blueColor];
    [_loginView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //
        make.center.equalTo(weakSelf.view).with.offset(0);
        //
        make.width.mas_equalTo(350);
        //
        make.height.mas_equalTo(180);
    }];
}

-(void)createTestView{
    
    __weak typeof (self) weakSelf = self;
    //---------------------------------
    _loginView = [[UIView alloc]init];
    [self.view addSubview:_loginView];
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.center.equalTo(weakSelf.view).with.offset(0);
        //
        make.width.mas_equalTo(250);
        //
        make.height.mas_equalTo(200);
    }];
    _loginView.backgroundColor = [UIColor redColor];
    _loginView.layer.cornerRadius = 5.f;
    
    //---------------------------------
    _leftBtn = [[UIButton alloc]init];
    [_loginView addSubview:_leftBtn];
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.left.equalTo(weakSelf.loginView.mas_left).with.offset(8);
        //
        make.right.equalTo(weakSelf.loginView.mas_centerX).with.offset(-4);
        //
        make.bottom.equalTo(weakSelf.loginView.mas_bottom).with.offset(-8);
        //
        //        make.height.mas_equalTo(44);
        make.height.mas_lessThanOrEqualTo(44);
    }];
    _leftBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //---------------------------------
    _rightBtn = [[UIButton alloc]init];
    [_loginView addSubview:_rightBtn];
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        make.right.equalTo(weakSelf.loginView.mas_right).with.offset(-8);
        //
        make.left.equalTo(weakSelf.loginView.mas_centerX).with.offset(4);
        //
        make.bottom.equalTo(weakSelf.loginView.mas_bottom).with.offset(-8);
        //
        //        make.height.mas_equalTo(44);
        make.height.mas_lessThanOrEqualTo(44);
    }];
    _rightBtn.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}


@end
