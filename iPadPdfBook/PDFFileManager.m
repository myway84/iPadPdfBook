//
//  PDFFileManager.m
//  iPadBook
//
//  Created by JackYi on 13-3-13.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "PDFFileManager.h"

@implementation PDFFileManager

+ (NSString *)docuemntPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSArray *)fullNamePDFFileOfDocument
{
    NSMutableArray *pdfFileNameArray = [NSMutableArray array];
    
    NSArray *fileNameArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[PDFFileManager docuemntPath] error:nil];
    
    [fileNameArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       if( [[obj pathExtension] isEqualToString:@"pdf"])
       {
           [pdfFileNameArray addObject:obj];
       }
    }];
    
    return pdfFileNameArray;
}

@end
