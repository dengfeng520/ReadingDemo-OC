//
//  BookTextViewController.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/7.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "BookTextViewController.h"
#import "LTAttributedLabel.h"

@interface BookTextViewController ()

///
@property (strong, nonatomic) LTAttributedLabel *label;

@end

@implementation BookTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// MARK: - lazy data
-(LTAttributedLabel *)label{
    if(_label == nil){
        _label = [[LTAttributedLabel alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_label];
    }
    return _label;
}

@end
