//
//  CollectionViewController.h
//  iPadPdfBook
//
//  Created by JackYi on 13-4-21.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  NSArray *dataSource;

- (IBAction)back:(id)sender;

@end
