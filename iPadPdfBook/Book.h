//
//  Book.h
//  iPadBook
//
//  Created by JackYi on 13-3-15.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * path;
@property (nonatomic, retain) NSDate * createTime;
@property (nonatomic, retain) NSDate * readeTime;
@property (nonatomic, retain) NSString *noteContent;
@end
