//
//  InterstitialViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "InterstitialViewController.h"
#import "Tools.h"
#import <CTSDK/CTService.h>
#import <CTSDK/CTADExternalDelegate.h>
@interface InterstitialViewController ()<CTInterstitialDelegate>
@property (nonatomic,assign)BOOL isSuccess;
@property (nonatomic, strong)ZCJHUD *hud;

@end

@implementation InterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSuccess = NO;
    self.title = @"Interstitial";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:128/255.0 green:138/255.0 blue:135/255.0 alpha:1];
    button.frame = CGRectMake(0, XPHeight - 50, XPWidth/3.0, 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"RequestAd"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getCTInterstitia) forControlEvents:UIControlEventTouchUpInside];
    UIButton *showAD = [UIButton buttonWithType:UIButtonTypeCustom];
    showAD.backgroundColor = [UIColor colorWithRed:250/255.0 green:235/255.0 blue:215/255.0 alpha:1];
    showAD.frame = CGRectMake(XPWidth/3.0, XPHeight - 50, XPWidth/3.0, 50);
    [showAD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [showAD setTitle:[NSString stringWithFormat:@"VC展示"] forState:UIControlStateNormal];
    [self.view addSubview:showAD];
    
    [showAD addTarget:self action:@selector(showAdWithVC) forControlEvents:UIControlEventTouchUpInside];
    UIButton *vcShowAD = [UIButton buttonWithType:UIButtonTypeCustom];
    vcShowAD.backgroundColor = [UIColor colorWithRed:135/255.0 green:206/255.0 blue:235/255.0 alpha:1];
    vcShowAD.frame = CGRectMake(XPWidth/3.0 * 2, XPHeight - 50, XPWidth/3.0, 50);
    [vcShowAD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [vcShowAD setTitle:[NSString stringWithFormat:@"标准展示"] forState:UIControlStateNormal];
    [self.view addSubview:vcShowAD];
    
    [vcShowAD addTarget:self action:@selector(showAdByAddSubview) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getCTInterstitia
{
    [self showGetAdWithStr:@"开始请求广告"];
    @weakify(self)
    CTService *service = [CTService shareManager];
    [service preloadInterstitialWithSlotId:interstitilaSlotId delegate:self isFullScreen:NO isTest:YES success:^(UIView *InterstitialView) {
        @strongify(self)
        self.isSuccess = YES;
        [self.view addSubview:InterstitialView];
    } failure:^(NSError *error) {
        NSString *str = [NSString stringWithFormat:@"Interstital出错了：%@",error.description];
        XPLog(@"%@",str);
    }];
}
- (void)showAdWithVC
{
    if (self.isSuccess)
    {
        [[CTService shareManager] interstitialShowWithControllerStyle];
        self.isSuccess = NO;
    }else
    {
        [self showGetAdWithStr:@"请先调用RequestAd请求广告"];
    }
}
- (void)showAdByAddSubview
{
    if (self.isSuccess)
    {
        [[CTService shareManager] interstitialShow];
        self.isSuccess = NO;
    }else
    {
        [self showGetAdWithStr:@"请先调用RequestAd请求广告"];
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
-(void)CTInterstitialDidClick:(CTInterstitial*)interstitial
{
    XPLog(@"CTInterstitialDidClick");
}

-(void)CTInterstitialDidIntoLandingPage:(CTInterstitial*)interstitial
{
    XPLog(@"CTInterstitialDidIntoLandingPage");
}

-(void)CTInterstitialDidLeaveLandingPage:(CTInterstitial*)interstitial
{
    XPLog(@"CTInterstitialDidLeaveLandingPage");
}

-(void)CTInterstitialClosed:(CTInterstitial*)interstitial
{
    XPLog(@"CTInterstitialClosed");
}

-(void)CTInterstitialWillLeaveApplication:(CTInterstitial*)interstitial
{
    XPLog(@"CTInterstitialWillLeaveApplication");
}
- (void)CTInterstitialJumpfail:(CTInterstitial *)interstitialAD
{
    XPLog(@"InterstitialJumpfail 失败");
}

#pragma mark - 横竖屏切换
////支持横竖屏
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

//检测是横屏横还是竖屏
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator;
{
    if (size.width >size.height)
    {
        [[CTService shareManager] ScreenIsVerticalScreen:NO];
    }
    else
    {
        [[CTService shareManager] ScreenIsVerticalScreen:YES];
    }
}

@end
