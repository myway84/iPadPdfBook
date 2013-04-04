//
//  ViewController.m
//  iPadBook
//
//  Created by JackYi on 13-3-10.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "BookSelfViewController.h"
#import "PDFFileManager.h"
#import "NoteView.h"

@interface BookSelfViewController ()

@end

@implementation BookSelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSURL *documentURL =  [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//
//
//    NSURL *source = [[NSBundle mainBundle] URLForResource:@"Test1" withExtension:@"pdf"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Test1" ofType:@"pdf"];
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"Test1.pdf"];
//
//    NSError *error ;
//    if ([fileManager copyItemAtURL:source toURL:[documentURL URLByAppendingPathComponent:@"Test1.pdf"] error:&error] == YES) {
//        NSLog(@"YES");
//    }
//
//    if ([fileManager copyItemAtPath:path toPath:writableDBPath error:&error] == YES) {
//            NSLog(@"YES");
//    }
//
//    NSLog(@"%@", error);

//    NSArray *array = [fileManager contentsOfDirectoryAtPath:[documentURL path] error:nil];
//    NSString *path = [array[0] pathExtension];
//    NSLog(@"%@", path);
////    NSLog(@"%@", array[0]);
//    DLog(@"%@", path);
//    DLog(@"%i", 5);
//
//    DLog(@"%@",[PDFFileManager fullNamePDFFileOfDocument]);
    
    NoteView *noteview = [[NoteView alloc] initWithFrame:CGRectMake(10, 0, 400, 500)];
    [self.view addSubview:noteview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark GBookShelfViewDataSource

- (NSInteger)numberOfBooksInBookShelfView:(GSBookShelfView *)bookShelfView
{
    return [self.bookArray count];
}
//
//- (NSInteger)numberOFBooksInCellOfBookShelfView:(GSBookShelfView *)bookShelfView
//{
//    
//}
//
//- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView bookViewAtIndex:(NSInteger)index
//{
//    
//}
//
//- (UIView *)bookShelfView:(GSBookShelfView *)bookShelfView cellForRow:(NSInteger)row
//{
//    
//}
//
//- (UIView *)aboveTopViewOfBookShelfView:(GSBookShelfView *)bookShelfView
//{
//    
//}
//
//- (UIView *)belowBottomViewOfBookShelfView:(GSBookShelfView *)bookShelfView
//{
//    
//}
//
//- (UIView *)headerViewOfBookShelfView:(GSBookShelfView *)bookShelfView
//{
//    
//}

- (NSInteger)numberOFBooksInCellOfBookShelfView:(GSBookShelfView *)bookShelfView {
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(orientation)) {
        return 5;
    } else {
        return 4;
    }
}

- (CGFloat)cellHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return CELL_IPAD_HEIGHT;
}

- (CGFloat)cellMarginOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return CELL_MARGIN;
}

- (CGFloat)bookViewHeightOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return IPAD_DOC_HEIGHT;
}

- (CGFloat)bookViewWidthOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return IPAD_DOC_WIDTH;
}

- (CGFloat)bookViewBottomOffsetOfBookShelfView:(GSBookShelfView *)bookShelfView {
    return IPAD_BOTTOM_OFFSET;
}

@end
