//
//  NoteViewController.h
//  iPadPdfBook
//
//  Created by JackYi on 13-4-4.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NoteViewController;
@protocol NoteViewControllerDelegate <NSObject>

- (void)didTappedToolBarIn:(NoteViewController*) noteViewController cancleButton:(UIButton*) button;
- (void)didTappedToolBarIn:(NoteViewController*) noteViewController saveButton:(UIButton*) button;

@end

@interface NoteViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *noteView;
@property (weak, nonatomic) IBOutlet UIView *toolBar;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;

@property (weak, nonatomic) id<NoteViewControllerDelegate> delegate;
@property (copy, nonatomic) NSString *stringNote;

- (IBAction)onTappedCancleButton:(id)sender;
- (IBAction)onTappedSaveButton:(id)sender;

@end
