//
//  BookTableViewController.m
//  iPadBook
//
//  Created by JackYi on 13-3-30.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "BookTableViewController.h"
#import "Book+Operation.h"
#import "DataModel.h"
#import "ReaderViewController.h"

@interface BookTableViewController ()<UITableViewDataSource, UITableViewDelegate, ReaderViewControllerDelegate, NSFetchedResultsControllerDelegate>

@end

@implementation BookTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setCenterTitleView];
    
  // new way to set title color ios5.0+
  //  self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor yellowColor] forKey:UITextAttributeTextColor];
    
    [self.fetchedResultsController performFetch:nil];
}

- (void)setCenterTitleView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:17.0];
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    label.textAlignment = UITextAlignmentCenter;
    
    label.textColor = [UIColor blackColor];
    self.navigationItem.titleView = label;
    label.text = @"BookReader";
    [label sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (NSFetchedResultsController* )fetchedResultsController
{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequset = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    fetchRequset.sortDescriptors = [NSArray arrayWithObjects:[NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:YES selector:@selector(localizedStandardCompare:)], nil];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequset managedObjectContext:[[DataModel shareInstance] managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

#pragma mark UITableViewDataSourece

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BookTableViewCell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [book title];
    return cell;
}


//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       Book *deleteBook = [self.fetchedResultsController objectAtIndexPath:indexPath];
       [Book deleteBook:deleteBook];
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *phrase = nil;
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:book.path password:phrase];
    if (document) {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
		readerViewController.delegate = self;
        readerViewController.book = book;
        
        [self presentViewController:readerViewController animated:YES completion:nil];
    }
   
}


#pragma mark  NSFetchedResultsControllerDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.myTableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.myTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.myTableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.myTableView endUpdates];
}

#pragma mark ReaderViewControllerDelegate
- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
