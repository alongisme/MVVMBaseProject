//
//  TwoModel.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/13.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwoModel : NSObject
@property (nonatomic, assign) NSInteger chapterSort;
@property (nonatomic, assign) NSInteger chapterId;
@property (nonatomic, strong) NSString *chapterImage;
@property (nonatomic, strong) NSString *chapterName;
@end
