//
//  NoteView.h
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteView;

@protocol NoteViewDelegate<NSObject>
@optional

- (void)didTapSaveButton:(NoteView *)noteView;
- (void)didTapCancelButton:(NoteView *)noteView;

@end

@interface NoteView : UIView

@property (weak, nonatomic) UIImageView *toolbarNote;
@property (weak, nonatomic) UITextView *textView;
@property (weak, nonatomic) id<NoteViewDelegate> delegate;
@end


