//
//  JKReaderMainButtombar.h
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "UIXToolbarView.h"

@class JKReaderMainBottombar;

@protocol JKReaderMainBottomDelegate <NSObject>
@required

- (void)tappedInBottombar:(JKReaderMainBottombar *)bottombar noteButton:(UIButton *)button;
- (void)tappedInBottombar:(JKReaderMainBottombar *)bottombar graffittiButton:(UIButton *)button;

@end

@interface JKReaderMainBottombar : UIXToolbarView

@property (weak, nonatomic) id<JKReaderMainBottomDelegate> delegate;

- (void)hideBottombar;
- (void)showBottombar;

@end
