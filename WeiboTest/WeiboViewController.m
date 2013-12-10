//
//  WeiboViewController.m
//  WeiboTest
//
//  Created by Kuman on 12/6/13.
//  Copyright (c) 2013 Kuman. All rights reserved.
//

#import "WeiboViewController.h"
#import "WeiboSDK.h"
#import "AppDelegate.h"

@interface WeiboViewController () <WBHttpRequestDelegate>

@end

@implementation WeiboViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.view.backgroundColor = UIColor.grayColor;

    // ログインボタン
    UIButton *ssoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ssoButton setTitle:@"ログイン" forState:UIControlStateNormal];
    [ssoButton addTarget:self action:@selector(ssoButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    ssoButton.frame = CGRectMake(20, 250, 280, 50);
    [self.view addSubview:ssoButton];

    UIButton *tweetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tweetButton setTitle:@"つぶやく" forState:UIControlStateNormal];
    [tweetButton addTarget:self action:@selector(tweetButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    tweetButton.frame = CGRectMake(20, 370, 280, 50);
    [self.view addSubview:tweetButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ssoButtonPressed
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"WeiboViewController",
            @"Other_Info_1": [NSNumber numberWithInt:123],
            @"Other_Info_2": @[@"obj1", @"obj2"],
            @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)tweetButtonPressed
{
    NSLog(@"*** tweetButtonPressed ");
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestWithAccessToken:myDelegate.wbtoken
                                      url:@"https://api.weibo.com/2/statuses/update.json"
                               httpMethod:@"POST"
                                   params:@{@"status":@"Hello World"}
                                 delegate:self
                                  withTag:nil];
}

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;

    title = @"成功しました。";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;

    title = @"失敗しました。";
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    [alert show];
}

@end
