//
//  Book+Create.m
//  iPadBook
//
//  Created by JackYi on 13-3-15.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "Book+Operation.h"
#import "DataModel.h"

@implementation Book (Operation)
+ (Book *)createBookTitle:(NSString* )title path:(NSString* )path
{
    
    NSManagedObjectContext *managedContext = [DataModel shareInstance].managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"path = %@", path]];
    
    NSError *error = nil;
    NSArray *results = [managedContext executeFetchRequest:request error:&error];
    if (error) {
        DLog(@"%@", error);
        return nil;
    }
    if ([results count] > 0) {
        DLog(@"是相同PDF");
        return nil;
    }
    else
    {
        Book *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:managedContext];
        [entity setTitle:title];
        [entity setCreateTime:[NSDate date]];
        [entity setPath:path];
        return entity;
    }
}

+ (void)deleteBook:(Book *)book 
{
    [[DataModel shareInstance].managedObjectContext delete:book];
}

+ (void)saveBook:(Book *)book
{
    if ([book hasChanges]) {
        [[DataModel shareInstance].managedObjectContext save:nil];

    }
}
@end
