//
//  BookModel.h
//  ReadingDemo-OC
//
//  Created by rp.wang on 2019/1/3.
//  Copyright © 2019 西安乐推网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookModel : NSObject

///book ID
@property (assign, nonatomic) NSInteger bookId;
///book Name
@property (copy, nonatomic) NSString *bookName;
///
@property (assign, nonatomic) NSInteger totalChapter;
///
@property (assign, nonatomic) NSInteger *curChpaterIndex;
///
@property (copy, nonatomic) NSString *urlPath;
///是否有下一章
-(BOOL)haveNextChapter;
///是否有上一章
-(BOOL)haveUpPreChapter;
///内容
@property (strong, nonatomic) ReadModel *readModel;

@end

NS_ASSUME_NONNULL_END
