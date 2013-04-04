//
//  NoteView.m
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "NoteView.h"

@implementation NoteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *topBarBackimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50)];
        topBarBackimageview.image = [UIImage imageNamed:@"noteview_toolbar"];
        
        topBarBackimageview.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        topBarBackimageview.userInteractionEnabled = YES;
        
        UIButton *buttonSave = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSave.frame = CGRectMake(topBarBackimageview.left+10, topBarBackimageview.top+5, 50, topBarBackimageview.height-15);
        [buttonSave setTitle:@"保存" forState:UIControlStateNormal];
        [buttonSave setBackgroundImage:[UIImage imageNamed:@"note_button"] forState:UIControlStateNormal];
        buttonSave.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [buttonSave addTarget:self action:@selector(savenote:) forControlEvents:UIControlEventTouchUpInside];
               
        UIButton *buttonCancle = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancle.frame = CGRectMake(topBarBackimageview.right-60, topBarBackimageview.top+5, 50, topBarBackimageview.height-15);
        [buttonCancle setTitle:@"取消" forState:UIControlStateNormal];
        [buttonCancle setBackgroundImage:[UIImage imageNamed:@"note_button"] forState:UIControlStateNormal];
        buttonCancle.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
       
        
        [buttonCancle addTarget:self action:@selector(canclenote:) forControlEvents:UIControlEventTouchUpInside];
        
        [topBarBackimageview addSubview:buttonSave];
        [topBarBackimageview addSubview:buttonCancle];
        
        [self addSubview:topBarBackimageview];
        
        CGRect mainRect = CGRectMake(5, topBarBackimageview.height-5, self.width-10, self.height-topBarBackimageview.height);
        UITextView *textView = [[UITextView alloc] initWithFrame:mainRect];
        UIImageView *textViewImageView = [[UIImageView alloc] initWithFrame:textView.bounds];
        textViewImageView.image = [UIImage imageNamed:@"textview_background"];
        [textView addSubview:textViewImageView];
        [textView sendSubviewToBack:textViewImageView];
        
        [self addSubview:textView];
        
    }
    return self;
}

- (void)savenote:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapSaveButton:)]) {
        [self.delegate didTapSaveButton:self];
    }
}

- (void)canclenote:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didTapCancelButton:)]) {
        [self.delegate didTapCancelButton:self];
    }
}

@end
