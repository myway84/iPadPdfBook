//
//  PdfView.m
//  pdf
//
//  Created by JackYi on 13-3-12.
//  Copyright (c) 2013年 JackYi. All rights reserved.
//

#import "PdfView.h"

@implementation PdfView

- (void)awakeFromNib
{
    [super awakeFromNib];
 //   self.url = [[NSBundle mainBundle] URLForResource:@"Cookbook" withExtension:@"pdf"];
    self.url = [[NSURL alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
 //   self.url = [[NSBundle mainBundle] URLForResource:@"Cookbook" withExtension:@"pdf"];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();
    
	// PDF might be transparent, assume white paper
	[[UIColor whiteColor] set];
	CGContextFillRect(ctx, rect);
    
	// Flip coordinates
	CGContextGetCTM(ctx);
	CGContextScaleCTM(ctx, 1, -1);
	CGContextTranslateCTM(ctx, 0, -rect.size.height);
    
	// url is a file URL
	CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef)self.url);
	CGPDFPageRef page1 = CGPDFDocumentGetPage(pdf, 1);
    
	// get the rectangle of the cropped inside
	CGRect mediaRect = CGPDFPageGetBoxRect(page1, kCGPDFCropBox);
	CGContextScaleCTM(ctx, rect.size.width / mediaRect.size.width,
                      rect.size.height / mediaRect.size.height);
	CGContextTranslateCTM(ctx, -mediaRect.origin.x, -mediaRect.origin.y);
    
	// draw it
	CGContextDrawPDFPage(ctx, page1);
	CGPDFDocumentRelease(pdf);
}

@end
