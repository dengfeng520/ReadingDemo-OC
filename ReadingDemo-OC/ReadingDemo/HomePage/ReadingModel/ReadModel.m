//
//  ReadModel.m
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/3.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import "ReadModel.h"
#import "MJExtension.h"

@implementation ReadModel
+(void)load{
    
    [ReadModel mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"im_image" : [im_image class],
                 };
    }];
    
    [ReadModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"im_image" : @"im:image",
                 @"summary" : @"summary",
                 @"im_name" : @"im:name",
                 @"im_price" : @"im:price",
                 @"rights" : @"rights",
                 @"title" : @"title",
                 @"Id" : @"id",
                 @"category" : @"category",
                 @"im_releaseDate" : @"im:releaseDate",
                 };
    }];
}
@end
//==============================
@implementation im_name

@end
//==============================
@implementation im_image

@end
//==============================
@implementation attributes

@end
//==============================
@implementation summary

@end
//==============================
@implementation im_price

@end
//==============================
@implementation im_contentType

@end
//==============================
@implementation rights

@end
//==============================
@implementation title

@end
//==============================
@implementation im_artist

@end
//==============================
@implementation category

@end
//==============================
@implementation im_releaseDate


@end
