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
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end
