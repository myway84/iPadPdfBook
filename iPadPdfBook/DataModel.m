//
//  DataModel.m
//  iPadBook
//
//  Created by JackYi on 13-3-13.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentSotreCoordinator = _persistentSotreCoordinator;

+ (DataModel *)shareInstance
{
    static DataModel *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[DataModel alloc] init];
       
    });
    return singleton;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData:) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)saveData:(NSNotification *)notificationObject
{
    NSError *error;
    
    if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
        DLog(@"%@", [error localizedDescription]);
    }
}

- (NSString *)appName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

- (NSString *)databaseName
{
    if (_databaseName) {
        return _databaseName;
    }
    
    _databaseName = [NSString stringWithFormat:@"%@.sqlite", [self appName]];
    return _databaseName;
}

- (NSManagedObjectContext* )managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    if ([self persistentSotreCoordinator]) {
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectContext setPersistentStoreCoordinator:self.persistentSotreCoordinator];
    }
    return _managedObjectContext;
}

- (NSManagedObjectModel* )managedObjectModel
{
    if (!_managedObjectModel) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator* )persistentSotreCoordinator
{
    if (_persistentSotreCoordinator) {
        return _persistentSotreCoordinator;
    }
    
    _persistentSotreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSError *error = nil;
    NSDictionary *options = @{
    NSMigratePersistentStoresAutomaticallyOption : @YES,
    NSInferMappingModelAutomaticallyOption :@YES
    };
    
    DLog(@"%@", [self databaseName]);
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.databaseName];
    if(![_persistentSotreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error])
    {
        NSLog(@"ERROR IN PERSISTENT STORE COORDINATOR! %@, %@", error, [error userInfo]);
    }
    
    return _persistentSotreCoordinator;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
