//
//  BannerViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "BannerViewController.h"
#import "Tools.h"
#import <CTSDK/CTService.h>
#import <CTSDK/CTADExternalDelegate.h>
@interface BannerViewController ()<CTBannerDelegate>
@property (nonatomic, strong)ZCJHUD *hud;
@end

@implementation BannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Banner";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:115/255.0 green:74/255.0 blue:18/255.0 alpha:1];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width , 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"RequestAd"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getCTBanner) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getCTBanner
{
    [self showGetAdWithStr:@"开始请求广告"];
    @weakify(self)
    CTService *service = [CTService shareManager];
    [service getBannerADswithSlotId:bannerSlotId delegate:self frame:CGRectMake(0, 150, XPWidth, 50) needCloseButton:YES isTest:YES success:^(UIView *bannerView) {
        @strongify(self)
        [self.view addSubview:bannerView];

    } failure:^(NSError *error) {
        NSString *str = [NSString stringWithFormat:@"Banner出错了：%@",error.description];
        XPLog(@"%@",str);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
-(void)CTBannerDidClick:(CTBanner*)banner
{
    XPLog(@"CTBannerDidClick");
}

-(void)CTBannerDidIntoLandingPage:(CTBanner*)banner
{
    XPLog(@"CTBannerDidIntoLandingPage");
}

-(void)CTBannerDidLeaveLandingPage:(CTBanner*)banner
{
    XPLog(@"CTBannerDidLeaveLandingPage");
}

-(void)CTBannerClosed:(CTBanner*)banner
{
    XPLog(@"CTBannerClosed");
}

-(void)CTBannerWillLeaveApplication:(CTBanner*)banner
{
    XPLog(@"CTBannerWillLeaveApplication");
}

-(void)CTBannerHtml5Closed:(CTBanner*)banner
{
    XPLog(@"CTBannerHtml5Closed");
}
- (void)CTBannerJumpfail:(CTBanner *)banner
{
    XPLog(@"CTBannerJumpfail");
}

@end
