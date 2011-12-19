//
//  MagViewController.h
//  iPadMagApp
//
//  Created by preet dhillon on 18/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFScrollView.h"
#include <QuartzCore/QuartzCore.h>
//testJacob-3
@interface MagViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIScrollView *scrllViewMag;
    UIView *myContentView;
}

-(UIImage *)thumbNailImageFromPdfWithName:(NSString *)stringName;
@end
