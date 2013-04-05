//
//  NoteViewController.m
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "NoteViewController.h"

@interface NoteViewController ()

@end

@implementation NoteViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIImageView *textViewImageView = [[UIImageView alloc] initWithFrame:self.noteTextView.bounds];
    textViewImageView.image = [UIImage imageNamed:@"textview_background"];
    [self.noteTextView addSubview:textViewImageView];
    [self.noteTextView sendSubviewToBack:textViewImageView];
    
    self.noteTextView.text = self.stringNote;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.noteTextView becomeFirstResponder];
    self.noteView.bottom = self.view.height + self.noteView.height;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
              
        CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        UIWindow *bw = [[UIApplication sharedApplication].windows lastObject];
        UIWindow *keyWin = [[UIApplication sharedApplication] keyWindow];
        frame = [bw convertRect:frame fromWindow:keyWin];

        [UIView animateWithDuration:0.3f animations:^{
            self.noteView.bottom = frame.origin.y;
        }];
    }];
   
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        UIWindow *bw = [[UIApplication sharedApplication].windows lastObject];
        UIWindow *keyWin = [[UIApplication sharedApplication] keyWindow];
        frame = [bw convertRect:frame fromWindow:keyWin];
        
        [UIView animateWithDuration:0.3f animations:^{
            self.noteView.top = frame.origin.y;
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onTappedCancleButton:(id)sender {
    
    self.stringNote = self.noteTextView.text;
    
    [self.noteTextView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didTappedToolBarIn:cancleButton:)]) {
        [self.delegate didTappedToolBarIn:self cancleButton:sender];
    }
}

- (IBAction)onTappedSaveButton:(id)sender {
    
    self.stringNote = self.noteTextView.text;
    
    [self.noteTextView resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didTappedToolBarIn:saveButton:)]) {
        [self.delegate didTappedToolBarIn:self saveButton:sender];
    }
}

@end
