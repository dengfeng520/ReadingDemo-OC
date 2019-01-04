//
//  ReadModel.h
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/3.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class im_Name,im_image,attributes,im_price,rights,title,Id,category,im_releaseDate;

NS_ASSUME_NONNULL_BEGIN

@interface ReadModel : NSObject
///
@property (strong, nonatomic) im_Name *im_name;
///
@property (strong, nonatomic) NSArray *im_image;
///
@property (strong, nonatomic) NSArray *summary;
///
@property (strong, nonatomic) im_price *im_price;
///
@property (strong, nonatomic) rights *rights;
///
@property (strong, nonatomic) title *title;
///
@property (strong, nonatomic) Id *Id;
///
@property (strong, nonatomic) category *category;
///
@property (strong, nonatomic) im_releaseDate *im_releaseDate;

@end

//==============================
@interface im_Name : NSObject

@property (copy, nonatomic) NSString *label;

@end

//==============================
@interface im_image : NSObject
///
@property (copy, nonatomic) NSString *label;
///
@property (copy, nonatomic) attributes *attributes;
@end

//==============================
@interface attributes : NSObject
///
@property (assign, nonatomic) NSInteger height;
///
@property (copy, nonatomic) NSString *amount;
///
@property (copy, nonatomic) NSString *currency;
///
@property (copy, nonatomic) NSString *term;
///
@property (copy, nonatomic) NSString *label;
///
@property (copy, nonatomic) NSString *rel;
///
@property (copy, nonatomic) NSString *type;
///
@property (copy, nonatomic) NSString *href;
///
@property (copy, nonatomic) NSString *im_id;
///
@property (copy, nonatomic) NSString *im_bundleId;
///
//@property (copy, nonatomic) NSString *label;
///
@property (copy, nonatomic) NSString *scheme;

@end

//==============================
@interface summary : NSObject
///
@property (copy, nonatomic) NSString *label;
@end

//==============================
@interface im_price : NSObject
///
@property (copy, nonatomic) NSString *label;
///
@property (strong, nonatomic) attributes *attributes;
@end

//==============================
@interface im_contentType : NSObject
///
@property (strong, nonatomic) attributes *attributes;
@end

//==============================
@interface rights : NSObject
///
@property (copy, nonatomic) NSString *label;
@end

//==============================
@interface title : NSObject
///
@property (copy, nonatomic) NSString *label;
@end

//==============================
@interface Id : NSObject
///
@property (copy, nonatomic) NSString *label;
///
@property (strong, nonatomic) attributes *attributes;

@end

//==============================
@interface im_artist : NSObject
///
@property (strong, nonatomic) NSString *label;
///
@property (strong, nonatomic) attributes *attributes;
@end

//==============================
@interface category : NSObject
///
@property (strong, nonatomic) attributes *attributes;
@end

//==============================
@interface im_releaseDate : NSObject
///
@property (copy, nonatomic) NSString *label;
///
@property (strong, nonatomic) attributes *attributes;

@end
NS_ASSUME_NONNULL_END
