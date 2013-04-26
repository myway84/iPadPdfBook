//
//  ViewSeuge.m
//  PointingGolf
//
//  Created by JackYi on 13-4-20.
//  Copyright (c) 2013年 Chinamobo Co., Ltd. All rights reserved.
//

#import "ViewSeuge.h"

@implementation ViewSeuge

- (void)perform
{
    UIViewController *sourceViewController = self.sourceViewController;
    UIViewController *destinationViewController = self.destinationViewController;
    
    [sourceViewController addChildViewController:destinationViewController];
    
    destinationViewController.view.frame = sourceViewController.view.bounds;
    [sourceViewController.view addSubview:destinationViewController.view];
}
@end
