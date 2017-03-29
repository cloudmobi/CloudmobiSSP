//
//  NaTemplateViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "NaTemplateViewController.h"
#import "Tools.h"
#import <CTSDK/CTService.h>
#import <CTSDK/CTADExternalDelegate.h>
@interface NaTemplateViewController ()<CTNaTemplateDelegate>
@property (nonatomic, strong)ZCJHUD *hud;
@end

@implementation NaTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NaTemplate";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:115/255.0 green:74/255.0 blue:18/255.0 alpha:1];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width , 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"RequestAd"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getCTNaTemplate) forControlEvents:UIControlEventTouchUpInside];
}

- (void)getCTNaTemplate
{
    [self showGetAdWithStr:@"开始请求广告"];
    @weakify(self)
    CTService *service = [CTService shareManager];
    [service getNaTemplateADswithSlotId:nativeSlotId delegate:self frame:CGRectMake(20, 150, XPWidth - 40, (XPWidth - 40)/1.9 + 40 )  needCloseButton:YES isTest:YES success:^(UIView *NaTemplateView) {
        @strongify(self)
        [self.view addSubview:NaTemplateView];

    } failure:^(NSError *error) {
        NSString *str = [NSString stringWithFormat:@"Native出错了：%@",error.description];
        XPLog(@"%@",str);
    }];
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
-(void)CTNaTemplateDidClick:(CTNaTemplate*)naTemplate
{
    XPLog(@"CTNaTemplateDidClick");
}

-(void)CTNaTemplateDidIntoLandingPage:(CTNaTemplate*)naTemplate
{
    XPLog(@"CTNaTemplateDidIntoLandingPage");
}

-(void)CTNaTemplateDidLeaveLandingPage:(CTNaTemplate*)naTemplate
{
    XPLog(@"CTNaTemplateDidLeaveLandingPage");
}

-(void)CTNaTemplateClosed:(CTNaTemplate*)naTemplate
{
    XPLog(@"CTNaTemplateClosed");
}

-(void)CTNaTemplateWillLeaveApplication:(CTNaTemplate*)naTemplate
{
    XPLog(@"CTNaTemplateWillLeaveApplication");
}

-(void)CTNaTemplateHtml5Closed:(CTNaTemplate*)naTemplate
{
    XPLog(@"CTNaTemplateHtml5Closed");
}
- (void)CTNaTemplateJumpfail:(CTNaTemplate *)naTemplate
{
    XPLog(@"CTNaTemplateJumpfail");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
