//
//  ViewController.h
//  iPadBook
//
//  Created by JackYi on 13-3-10.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSBookShelfView.h"

#define NAV_HEIGHT 47.f
#define CELL_MARGIN 20.f

#define IPAD_DOC_WIDTH          150.f
#define IPAD_DOC_HEIGHT         230.f
#define IPAD_BOTTOM_OFFSET      230.f
#define CELL_IPAD_HEIGHT        230.f

@interface BookSelfViewController : UIViewController<GSBookShelfViewDelegate, GSBookShelfViewDataSource>

@property (strong, nonatomic) GSBookShelfView *bookShelfView;
@property (strong, nonatomic) NSMutableArray *bookArray;

@end
