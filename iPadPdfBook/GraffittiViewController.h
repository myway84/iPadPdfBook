//
//  GraffitiViewController.h
//  iPadPdfBook
//
//  Created by JackYi on 13-4-5.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Palette.h"

@class GraffittiViewController;

@protocol GraffittiViewControllerDelegate <NSObject>

- (void)didTappedToolBarIn:(GraffittiViewController*) graffittiViewController exitButton:(UIButton*) button;

@end

@interface GraffittiViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelColor;
@property (weak, nonatomic) IBOutlet UILabel *labelFont;
@property (weak, nonatomic) IBOutlet Palette *paletteView;

@property (weak, nonatomic) UISegmentedControl *widthButton;
@property (weak, nonatomic) UISegmentedControl *colorButton;

@property (assign, nonatomic) int segment;
@property (assign, nonatomic) int segmentWidth;

@property (assign, nonatomic) CGPoint myBeganpoint;
@property (assign, nonatomic) CGPoint myMovepoint;

@property (weak, nonatomic) id<GraffittiViewControllerDelegate> delegate;

- (IBAction)chooseColor:(id)sender;
- (IBAction)chooseWidth:(id)sender;
- (IBAction)lineClear:(id)sender;
- (IBAction)lineRemove:(id)sender;
- (IBAction)allLineEraser:(id)sender;
- (IBAction)captureScreen:(id)sender;
- (IBAction)exit:(id)sender;

@end
