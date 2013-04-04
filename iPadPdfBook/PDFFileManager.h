//
//  PDFFileManager.h
//  iPadBook
//
//  Created by JackYi on 13-3-13.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDFFileManager : NSObject

+ (NSString *)docuemntPath;
+ (NSArray *)fullNamePDFFileOfDocument;

@end
