//
//  MainCollectionCell.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2018/12/19.
//  Copyright © 2018 西安乐推网络科技有限公司. All rights reserved.
//

#import "MainCollectionCell.h"
#import "Masonry.h"

@implementation MainCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        //============================
        __weak typeof (self) weakself = self;
        //============================
        _bookImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_bookImg];
        [_bookImg mas_makeConstraints:^(MASConstraintMaker *make) {
            //
            make.top.equalTo(weakself.contentView.mas_top).with.offset(15);
            //
            make.left.equalTo(weakself.contentView.mas_left).with.offset(12);
            //
            make.right.equalTo(weakself.contentView.mas_right).with.offset(-12);
            //
            make.height.mas_equalTo(weakself.bookImg.mas_width).multipliedBy(1.8);
        }];
        _bookImg.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
