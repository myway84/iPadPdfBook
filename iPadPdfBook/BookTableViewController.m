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
#import "CollectionViewController.h"

@interface BookTableViewController ()<UITableViewDataSource, UITableViewDelegate, ReaderViewControllerDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>


@end

@implementation BookTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor]}];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor]} forState:UIControlStateNormal];
    
    [self.fetchedResultsController performFetch:nil];
    [self registKeyValueObserver];
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (nil == _managedObjectContext) {
        _managedObjectContext = [DataModel shareInstance].managedObjectContext;
    }
    return _managedObjectContext;
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
    fetchRequset.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:YES ]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequset managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (IBAction)setEditMode:(id)sender {
    if (self.myTableView.isEditing) {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        [self.myTableView setEditing:NO animated:YES];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
        [self.myTableView setEditing:YES animated:YES];
    }
}

- (IBAction)sortSegement:(id)sender {
    UISegmentedControl *segment = sender;
    switch (segment.selectedSegmentIndex) {
        case 0:
            self.bookSortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"createTime" ascending:YES ]];
            self.bookPredicate = nil;
            break;
            
        case 1:
            self.bookSortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)]];
            self.bookPredicate = nil;
            break;
        case 2:
            self.bookSortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"readeTime" ascending:NO]];
            self.bookPredicate = [NSPredicate predicateWithFormat:@"readeTime != nil"];
            break;
    }
}

- (IBAction)segementChange:(id)sender {
    UISegmentedControl *segement = sender;
    if (0 == segement.selectedSegmentIndex) {
        UIViewController *vc = [self.childViewControllers lastObject];
//        [vc.view removeFromSuperview];
//        [vc removeFromParentViewController];
        vc.view.hidden = YES;
        
    }
    
    if (1 == segement.selectedSegmentIndex)
    {
        
    }
}

- (IBAction)pushToAnotherViewController:(id)sender {
    
    [self performSegueWithIdentifier:@"pushIdentifier" sender:sender];
}

- (IBAction)tappedShareBarItem:(id)sender {
    NSString *textToShare = @"我想分享这本书给你。";
    NSArray *activityItems = @[textToShare];
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    vc.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)registKeyValueObserver
{
    [self addObserver:self forKeyPath:@"bookPredicate" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self addObserver:self forKeyPath:@"bookSortDescriptors" options:NSKeyValueObservingOptionNew context:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString: @"bookPredicate"]) {
        [self bookReloadData];
    }
    else if([keyPath isEqualToString:@"bookSortDescriptors"])
    {
        [self bookReloadData];
    }
    
   DLog(@"old %@, new %@", change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
}

- (void)bookReloadData
{
    self.fetchedResultsController.fetchRequest.predicate = self.bookPredicate;
    self.fetchedResultsController.fetchRequest.sortDescriptors = self.bookSortDescriptors;
    [self.fetchedResultsController performFetch:nil];
    
    [self.myTableView reloadData];
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
    
    [cell setEditing:NO animated:YES];
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%i", editingStyle);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       Book *deleteBook = [self.fetchedResultsController objectAtIndexPath:indexPath];
       [Book deleteBook:deleteBook];
    }
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
    book.readeTime = [NSDate date];
    
    NSString *phrase = nil;
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:book.path password:phrase];
    if (document) {
        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
		readerViewController.delegate = self;
        readerViewController.book = book;
        
        [self presentViewController:readerViewController animated:YES completion:nil];
    }
   
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.myTableView.editing) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
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

#pragma mark UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.bookPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    
    if (0 == searchText.length) {
        self.bookPredicate = nil;
    }
}

@end
