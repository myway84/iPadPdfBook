//
//  JKReaderMainButtombar.m
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "JKReaderMainBottombar.h"

#define BUTTON_X 8.0f
#define BUTTON_Y 8.0f
#define BUTTON_SPACE 8.0f
#define BUTTON_HEIGHT 30.0f

#define NOTE_BUTTON_WIDTH 56.0f
#define GRAFFITI_BUTTON_WIDTH 56.0f

@implementation JKReaderMainBottombar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
		UIImage *imageH = [UIImage imageNamed:@"Reader-Button-H.png"];
		UIImage *imageN = [UIImage imageNamed:@"Reader-Button-N.png"];
        
		UIImage *buttonH = [imageH resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
		UIImage *buttonN = [imageN resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];

        UIButton *noteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [noteButton addTarget:self action: @selector(noteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [noteButton setImage:[UIImage imageNamed:@"write_note_button"] forState:UIControlStateNormal];
        [noteButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
        [noteButton setBackgroundImage:buttonN forState:UIControlStateNormal];
        noteButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;

        noteButton.frame = CGRectMake(BUTTON_X, BUTTON_Y, NOTE_BUTTON_WIDTH, BUTTON_HEIGHT);
        [self addSubview:noteButton];
        
        
        UIButton *graffitiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [graffitiButton addTarget:self action:@selector(graffiButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [graffitiButton setBackgroundImage:buttonH forState:UIControlStateHighlighted];
        [graffitiButton setBackgroundImage:buttonN forState:UIControlStateNormal];
        graffitiButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        graffitiButton.frame = CGRectMake(self.right-BUTTON_X-GRAFFITI_BUTTON_WIDTH, BUTTON_Y, GRAFFITI_BUTTON_WIDTH, BUTTON_HEIGHT);
        [self addSubview:graffitiButton];
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


- (void)noteButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    [self.delegate tappedInBottombar:self noteButton:button];
}

- (void)graffiButtonTapped:(UIButton *)button
{
#ifdef DEBUGX
	NSLog(@"%s", __FUNCTION__);
#endif
    [self.delegate tappedInBottombar:self graffittiButton:button];
}

@end
