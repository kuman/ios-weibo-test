//
//  AppDelegate.h
//  WeiboTest
//
//  Created by Kuman on 12/4/13.
//  Copyright (c) 2013 Kuman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;

@end
