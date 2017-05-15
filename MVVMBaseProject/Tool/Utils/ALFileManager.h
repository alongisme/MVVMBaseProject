//
//  ALFileManager.h
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALFileManager : NSObject

/**
 判断文件是否存在

 @param filePath filepath
 @return yes or no
 */
+ (BOOL)al_fileExistsAtPath:(NSString *)filePath;

/**
 判断文件夹是否存在

 @param filePath filepath
 @param isDirectory 是否文件夹
 @return yes or no
 */
+ (BOOL)al_fileExistsAtPath:(NSString *)filePath isDirectory:(BOOL)isDirectory;

/**
 创建文件夹

 @param directoryName 文件夹名称
 @param directoryPath 文件夹路径
 @return yes or no
 */
+ (BOOL)al_createDirectoryWithDirectoryName:(NSString *)directoryName directoryPath:(NSString *)directoryPath;

/**
 创建文件

 @param fileName 文件名
 @param directoryPath 路径文件夹
 @param contentData 内容
 @return yes or no
 */
+ (BOOL)al_createFileWithFileName:(NSString *)fileName directoryPath:(NSString *)directoryPath contentData:(NSData *)contentData;


/**
 文件属性

 @param filePath 文件路径
 @return 文件属性
 */
+ (NSDictionary *)al_fileAttriutes:(NSString *)filePath;


/**
 删除文件

 @param filePath 文件路径
 @return yes or no
 */
+ (BOOL)al_deleteFileWithFilePath:(NSString *)filePath;


/**
 比较两个文件

 @param filePathOne 文件路径1
 @param filePathTwo 文件路径2
 @return yes or no
 */
+ (BOOL)contentsEqualAtFilePath:(NSString *)filePathOne filePathTwo:(NSString *)filePathTwo;

/**
 document 路径

 @return path
 */
+ (NSString *)dicDocumentDirectory;

/**
 获取Tmp目录

 @return path
 */
+ (NSString *)dirTmp;

/**
 获取Cache目录

 @return path
 */
+ (NSString *)dirCache;

/**
 获取Library目录

 @return path
 */
+ (NSString *)dirLib;
@end
