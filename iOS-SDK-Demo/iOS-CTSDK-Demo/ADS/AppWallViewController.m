//
//  AppWallViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "AppWallViewController.h"
#import "Tools.h"
#import <CTSDK/CTService.h>
#import <CTSDK/CTADExternalDelegate.h>
@interface AppWallViewController ()<CTAppWallDelegate>
@property (nonatomic, assign)BOOL isCustumUI;
@property (nonatomic, strong)ZCJHUD *hud;
@end

@implementation AppWallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isCustumUI = NO;
    self.title = @"Appwall";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:115/255.0 green:74/255.0 blue:18/255.0 alpha:1];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width/2.0, 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"请求Appwall并Show"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(getCTAppWallViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *isCustomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    isCustomBtn.backgroundColor = [UIColor colorWithRed:188/255.0 green:235/255.0 blue:104/255.0 alpha:1];
    isCustomBtn.frame = CGRectMake(self.view.frame.size.width/2.0, self.view.frame.size.height - 50, self.view.frame.size.width/2.0, 50);
    [isCustomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [isCustomBtn setTitle:[NSString stringWithFormat:@"是否启用CustomColor"] forState:UIControlStateNormal];
    [self.view addSubview:isCustomBtn];
    [isCustomBtn addTarget:self action:@selector(changeCustomValue) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getCTAppWallViewController
{
    [self showGetAdWithStr:@"开始请求广告并展示应用墙"];
    //Custom UI
    CTCustomColor *customUI ;
    if (self.isCustumUI) {
        customUI = [[CTCustomColor alloc]init];
        customUI.normlBackgroundColor = [UIColor whiteColor];
        customUI.buttonBackgroundColor = [UIColor redColor];
        customUI.normlBackgroundColor = [UIColor yellowColor];
        customUI.btnNormlTextColor = [UIColor yellowColor];
        customUI.btnSelectedTextColor = [UIColor greenColor];
        customUI.cellBackgroundColor = [UIColor grayColor];
        customUI.cellTitleColor = [UIColor purpleColor];
        customUI.cellHeadTitleColor = [UIColor blueColor];
        customUI.marketColor = [UIColor blueColor];
        customUI.sliderViewColor = [UIColor grayColor];
    }
    CTService *service = [CTService shareManager];
    [service preloadAppWallWithSlotID:AppWallSlotId customColor:customUI delegate:self isTest:YES success:^{
        [self presentViewController:[service showAppWallViewController] animated:YES completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}

- (void)changeCustomValue
{
    self.isCustumUI = !self.isCustumUI;
    if (self.isCustumUI) {
        [self showGetAdWithStr:@"启用CustomColor自定义UI背景色"];
    }else
    {
        [self showGetAdWithStr:@"关闭CustomColor自定义UI背景色"];
    }
}
- (void)done
{
    [self.hud hide];
}
- (void)showGetAdWithStr:(NSString *)str
{
    self.hud = [[ZCJHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    self.hud.labelText = str;
    [self.hud show];
    [self performSelector:@selector(done) withObject:nil afterDelay:0.5];
}

#pragma mark - Delegate
/**
 * User click the advertisement.
 */
-(void)CTAppWallDidClick:(CTNativeAd *)nativeAd
{
    XPLog(@"CTAppWallDidClick");}
/**
 * Advertisement landing page will show.
 */
-(void)CTAppWallDidIntoLandingPage:(CTNativeAd *)nativeAd
{
    XPLog(@"CTAppWallDidIntoLandingPage");
}
/**
 * User left the advertisement landing page.
 */
-(void)CTAppWallDidLeaveLandingPage:(CTNativeAd *)nativeAd
{
    XPLog(@"CTAppWallDidLeaveLandingPage");
}
/**
 * Leave App
 */
-(void)CTAppWallWillLeaveApplication:(CTNativeAd *)nativeAd
{
    XPLog(@"CTAppWallWillLeaveApplication");
}
-(void)CTAppWallClosed
{
    XPLog(@"CTAppWallClosed");
    self.navigationController.navigationBarHidden = NO;
    
}
- (void)CTAppWallJumpfail:(CTNativeAd *)nativeAd
{
    XPLog(@"CTAppWallJumpfail");
}


@end
