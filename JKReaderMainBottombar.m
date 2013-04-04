//
//  JKReaderMainButtombar.m
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "JKReaderMainBottombar.h"

@implementation JKReaderMainBottombar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)hideBottombar
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    
    if (self.hidden = YES) {
        [UIView animateWithDuration:0.25f delay:0.0
            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveLinear
            animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                self.hidden = YES;
         }];
    }
}
- (void)showBottombar
{
#ifdef DEBUGX
    NSLog(@"%s", __FUNCTION__);
#endif
    
    if (self.hidden == YES) {
        [UIView animateWithDuration:0.25f delay:0.0
            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveLinear
            animations:^{
                self.hidden = NO;
                self.alpha = 1.0f;
            }
             completion:NULL
        ];
    }
}



@end
