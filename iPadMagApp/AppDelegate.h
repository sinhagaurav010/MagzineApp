//
//  AppDelegate.h
//  iPadMagApp
//
//  Created by preet dhillon on 18/12/11.
//  Copyright (c) 2011 dhillon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagViewController.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigation;
    MagViewController   *magController;
}
@property (strong, nonatomic) UIWindow *window;

@end
