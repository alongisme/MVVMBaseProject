//
//  OneModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneModel : NSObject
@property (nonatomic, assign) NSInteger chapterSort;
@property (nonatomic, assign) NSInteger chapterId;
@property (nonatomic, strong) NSString *chapterImage;
@property (nonatomic, strong) NSString *chapterName;
@end