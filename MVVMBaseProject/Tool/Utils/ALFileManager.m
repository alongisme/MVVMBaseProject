//
//  ALFileManager.m
//  MVVMBaseProject
//
//  Created by along on 2017/4/17.
//  Copyright © 2017年 along. All rights reserved.
//

#import "ALFileManager.h"

@implementation ALFileManager

+ (BOOL)al_fileExistsAtPath:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (BOOL)al_fileExistsAtPath:(NSString *)filePath isDirectory:(BOOL)isDirectory {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
}

//创建文件夹
+ (BOOL)al_createDirectoryWithDirectoryName:(NSString *)directoryName directoryPath:(NSString *)directoryPath {
    NSError *error = nil;
    
    BOOL res = [[NSFileManager defaultManager] createDirectoryAtPath:[directoryPath stringByAppendingPathComponent:directoryName] withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (res) {
        return YES;
    }else {
        if(error) NSLog(@"%@",error);
        return NO;
    }
}

//创建文件
+ (BOOL)al_createFileWithFileName:(NSString *)fileName directoryPath:(NSString *)directoryPath contentData:(NSData *)contentData{
    BOOL res = [[NSFileManager defaultManager] createFileAtPath:[directoryPath stringByAppendingPathComponent:fileName] contents:contentData attributes:nil];
    if(res) return YES;
    return NO;
}

//文件属性
+ (NSDictionary *)al_fileAttriutes:(NSString *)filePath {
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSArray *keys = [fileAttributes allKeys];
    id key, value;
    NSUInteger count = [keys count];
    for (int i = 0; i < count; i++) {
        key = [keys objectAtIndex: i];
        value = [fileAttributes objectForKey: key];
        NSLog (@"Key: %@ for value: %@", [keys objectAtIndex: i], [fileAttributes objectForKey: key]);
    }
    return fileAttributes;
}

//删除文件
+ (BOOL)al_deleteFileWithFilePath:(NSString *)filePath {
    NSError *error = nil;
    BOOL res = [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
    if(res) {
        return YES;
    } else {
        if(error) {
            NSLog(@"%@",error);
        }
        return NO;
    }
}

//比较两个文件内容
+ (BOOL)contentsEqualAtFilePath:(NSString *)filePathOne filePathTwo:(NSString *)filePathTwo {
    return [[NSFileManager defaultManager] contentsEqualAtPath:filePathOne andPath:filePathTwo];
}

//document 路径
+ (NSString *)dicDocumentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

//获取Tmp目录
+ (NSString *)dirTmp {
    NSString *tmpDirectory = NSTemporaryDirectory();
    return tmpDirectory;
}

//获取Cache目录
+ (NSString *)dirCache {
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    return cachePath;
}

//获取Library目录
+ (NSString *)dirLib {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    return libraryDirectory;
}
@end
