//
//  GraffitiViewController.m
//  iPadPdfBook
//
//  Created by JackYi on 13-4-5.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "GraffittiViewController.h"

@interface GraffittiViewController ()

@end

@implementation GraffittiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)chooseColor:(id)sender {
    [self segmentLineColor];
}

- (IBAction)chooseWidth:(id)sender {
    [self segmentLineWidth];
}

- (IBAction)lineClear:(id)sender {
    [self.paletteView myalllineclear];
}

- (IBAction)lineRemove:(id)sender {
    [self.paletteView myLineFinallyRemove];
}

- (IBAction)allLineEraser:(id)sender {
    self.segment = 10;
}

- (IBAction)captureScreen:(id)sender {
}

- (IBAction)exit:(id)sender {
}

-(void)segmentLineColor
{
	NSArray* segmentArray= @[@"黑", @"红", @"蓝", @"绿", @"黄", @"橙", @"灰", @"紫", @"紫", @"棕", @"粉红"];
    UISegmentedControl *seg =[[UISegmentedControl alloc] initWithItems:segmentArray];
	CGRect ButtonRect=CGRectMake(0, 0, 320, 40);
	[seg setFrame:ButtonRect];
	[seg setMomentary:YES];
	[seg addTarget:self action:@selector(segmentColorButton:)
		  forControlEvents:UIControlEventValueChanged];
	[seg setSegmentedControlStyle:UISegmentedControlStyleBar];
	[seg setTintColor:[UIColor darkGrayColor]];
	[self.view addSubview:seg];
    
    self.colorButton = seg;
}

-(void)segmentColorButton:(id)sender
{
	self.segment = [sender selectedSegmentIndex] ;
	switch (self.segment)
	{
		case 0:
			self.labelColor.text=@"颜色:黑色";
			self.labelColor.textColor=[UIColor blackColor];
			break;
		case 1:
			self.labelColor.text=@"颜色:红色";
			self.labelColor.textColor=[UIColor redColor];
			break;
		case 2:
			self.labelColor.text=@"颜色:蓝色";
			self.labelColor.textColor=[UIColor blueColor];
			break;
		case 3:
			self.labelColor.text=@"颜色:绿色";
			self.labelColor.textColor=[UIColor greenColor];
			break;
		case 4:
			self.labelColor.text=@"颜色:黄色";
			self.labelColor.textColor=[UIColor yellowColor];
			break;
		case 5:
			self.labelColor.text=@"颜色:橙色";
			self.labelColor.textColor=[UIColor orangeColor];
			break;
		case 6:
			self.labelColor.text=@"颜色:灰色";
			self.labelColor.textColor=[UIColor grayColor];
			break;
		case 7:
			self.labelColor.text=@"颜色:紫色";
			self.labelColor.textColor=[UIColor purpleColor];
			break;
		case 8:
			self.labelColor.text=@"颜色:棕色";
			self.labelColor.textColor=[UIColor brownColor];
			break;
		case 9:
			self.labelColor.text=@"颜色:粉红色";
			self.labelColor.textColor=[UIColor magentaColor];
			break;
		default:
			break;
	}
}

-(void)segmentLineWidth
{
	NSArray* segmentArray= @[@"1.0", @"2.0", @"3.0", @"4.0", @"5.0", @"6.0", @"7.0", @"8.0", @"9.0", @"12.0"];
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:segmentArray];
	CGRect ButtonRect=CGRectMake(0, 0, 320, 40);
	[seg setFrame:ButtonRect];
	[seg setMomentary:YES];
	[seg addTarget:self action:@selector(segmentWidthButton:)
		  forControlEvents:UIControlEventValueChanged];
	
	[seg setSegmentedControlStyle:UISegmentedControlStyleBar];
	[seg setTintColor:[UIColor darkGrayColor]];
	
	[self.view addSubview:seg];
}

-(void)segmentWidthButton:(id)sender
{
	self.segment =[sender selectedSegmentIndex];
	switch (self.segment)
	{
		case 0:
			self.labelFont.text=@"字号:1.0";
           
			break;
		case 1:
			self.labelFont.text=@"字号:2.0";
         
			break;
		case 2:
			self.labelFont.text=@"字号:3.0";
         
			break;
		case 3:
			self.labelFont.text=@"字号:4.0";
          
			break;
		case 4:
			self.labelFont.text=@"字号:5.0";
       
			break;
		case 5:
			self.labelFont.text=@"字号:6.0";
        
			break;
		case 6:
			self.labelFont.text=@"字号:7.0";
       
			break;
		case 7:
			self.labelFont.text=@"字号:8.0";
  
			break;
		case 8:
			self.labelFont.text=@"字号:9.0";

			break;
		case 9:
			self.labelFont.text=@"字号:12.0";
      
			break;
		default:
			break;
	}
    
	
}

#pragma mark -
//手指开始触屏开始
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
	[self.colorButton removeAllSegments];
	[self.widthButton removeAllSegments];
	UITouch* touch=[touches anyObject];
	self.myBeganpoint=[touch locationInView:self.view ];
	
	[self.paletteView Introductionpoint4:self.segment];
	[self.paletteView Introductionpoint5:self.segmentWidth];
	[self.paletteView Introductionpoint1];
	[self.paletteView Introductionpoint3:self.myBeganpoint];
	
}
//手指移动时候发出
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray* MovePointArray=[touches allObjects];
	self.myMovepoint=[[MovePointArray objectAtIndex:0] locationInView:self.view];
	[self.paletteView Introductionpoint3:self.myMovepoint];
	[self.paletteView setNeedsDisplay];
}
//当手指离开屏幕时候
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.paletteView Introductionpoint2];
	[self.paletteView setNeedsDisplay];
}
//电话呼入等事件取消时候发出
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	//NSLog(@"touches Canelled");
}


@end
