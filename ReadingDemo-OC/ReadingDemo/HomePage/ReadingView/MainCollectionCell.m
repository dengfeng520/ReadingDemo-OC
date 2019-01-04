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
            make.height.mas_equalTo(weakself.bookImg.mas_width).multipliedBy(1);
        }];
        _bookImg.backgroundColor = [UIColor redColor];
        
        //============================
        _bookNameLab = [[UILabel alloc]initWithFrame:CGRectZero];
        [self.contentView addSubview:_bookNameLab];
        [_bookNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            //
            make.top.equalTo(weakself.bookImg.mas_bottom).with.offset(5);
            //
            make.left.equalTo(weakself.contentView.mas_left).with.offset(8);
            //
            make.right.equalTo(weakself.contentView.mas_right).with.offset(-8);
            //
            make.bottom.equalTo(weakself.contentView.mas_bottom).with.offset(-5);
        }];
        _bookNameLab.textAlignment = NSTextAlignmentCenter;
        _bookNameLab.numberOfLines = 0;
        _bookNameLab.font = [UIFont fontWithName:@"Montserrat-Regular" size:13.f];
    }
    return self;
}



@end
