//
//  CollectionViewController.m
//  iPadPdfBook
//
//  Created by JackYi on 13-4-21.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "CollectionViewController.h"
#import "TestView.h"
#import "PdfView.h"
#import "DataModel.h"
#import "Book+Operation.h"
#import "ReaderViewController.h"
#import "ShelfView.h"

@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ReaderViewControllerDelegate>

@end

@implementation CollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Wood-Planks"]];
    
    NSFetchRequest *fetchRequset = [NSFetchRequest fetchRequestWithEntityName:@"Book"];
    self.dataSource =  [[DataModel shareInstance].managedObjectContext executeFetchRequest:fetchRequset error:nil];
    
    self.navigationItem.hidesBackButton = YES;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *collectionViewCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionIndentifier" forIndexPath:indexPath];
    
    PdfView *pdfView = [[PdfView alloc] initWithFrame:collectionViewCell.bounds];
    Book *book = self.dataSource[indexPath.row];
    
    
    NSURL *url = [NSURL fileURLWithPath:book.path];
    [pdfView setUrl:url];
    collectionViewCell.backgroundView = pdfView;
    
    collectionViewCell.contentView.backgroundColor = [UIColor clearColor];
    
    return collectionViewCell;
}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    TestView *test = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heardView" forIndexPath:indexPath];
//    return test;
//}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DLog(@"%i", indexPath.row);
    Book *book = self.dataSource[indexPath.row];
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

#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark ReaderViewControllerDelegate

- (void)dismissReaderViewController:(ReaderViewController *)viewController
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
