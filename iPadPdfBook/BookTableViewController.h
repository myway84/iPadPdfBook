//
//  BookTableViewController.h
//  iPadBook
//
//  Created by JackYi on 13-3-30.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookTableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPredicate *bookPredicate;
@property (strong, nonatomic) NSArray *bookSortDescriptors;

- (IBAction)setEditMode:(id)sender;

@end
