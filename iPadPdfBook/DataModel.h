//
//  DataModel.h
//  iPadBook
//
//  Created by JackYi on 13-3-13.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic, readonly) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic, readonly) NSPersistentStoreCoordinator *persistentSotreCoordinator;
@property (copy, nonatomic) NSString *databaseName;

+ (id)shareInstance;

@end
