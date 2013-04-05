//
//  Book+Create.h
//  iPadBook
//
//  Created by JackYi on 13-3-15.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "Book.h"

@interface Book (Operation)

+ (Book *)createBookTitle:(NSString* )title path:(NSString* )path inMannagedObjectContext:(NSManagedObjectContext *)managedContext;
+ (void)deleteBook:(Book *)book;
+ (void)saveBook:(Book *)book;

@end
