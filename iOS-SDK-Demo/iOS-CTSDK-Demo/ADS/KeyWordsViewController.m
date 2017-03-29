//
//  KeyWordsViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "KeyWordsViewController.h"
#import "Tools.h"
#import <CTSDK/CTService.h>
#import "CTView.h"
#import <CTSDK/CTADExternalDelegate.h>
@interface KeyWordsViewController ()<CTNativeAdDelegate>
@property (nonatomic, strong)CTView *ccview;
@property (nonatomic, strong)ZCJHUD *hud;
@end

@implementation KeyWordsViewController
@synthesize ccview;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Keywords获取";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:115/255.0 green:74/255.0 blue:18/255.0 alpha:1];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"RequestAd"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getKeywordsViewController) forControlEvents:UIControlEventTouchUpInside];
    UIButton* btn31 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn31.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50);
    btn31.backgroundColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0 alpha:1];
    [btn31 setTitle:@"关闭" forState:UIControlStateNormal];
    [btn31 addTarget:self action:@selector(closeAdView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn31];
}

- (void)getKeywordsViewController
{
    [self showGetAdWithStr:@"开始请求广告"];
    @weakify(self)
    CTService *service = [CTService shareManager];
    [service getNativeADswithSlotId:KeywordsSlotId delegate:self imageWidthHightRate:CTImageWHRateOnePointNineToOne adcat:0 keyWords:@[@"games",@"tools"] isTest:YES success:^(CTNativeAdModel *nativeModel) {
        @strongify(self)
        ccview = [[CTView alloc]initWithFrame:CGRectMake(30, 130, XPWidth -60, (XPWidth -60)/1.9+20)];
        ccview.delegate = self;
        
        ccview.adNativeModel = nativeModel;
        
        ccview.titleLable.text = nativeModel.title;
        [self getImageFromURL:nativeModel.icon img:^(UIImage *ig) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ccview.iconImage.image = ig;
            });
        }];
        [self getImageFromURL:nativeModel.image img:^(UIImage *ig) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ccview.imageImage.image = ig;
            });
        }];
        
        ccview.descLable.text = nativeModel.desc;
        [ccview.button setTitle:nativeModel.button forState:UIControlStateNormal];
        ccview.starLable.text = [NSString stringWithFormat:@"%f",nativeModel.star];
        ccview.logoImage.image = nativeModel.ADsignImage;
        [self.view addSubview:ccview];
        XPLog(@"One Element 获取成功");
    } failure:^(NSError *error) {
        XPLog(@" element:这是怎么回事啊，怎么错啊！%@",error.description);
    }];
}
-(void)closeAdView
{
    [ccview removeFromSuperview];
    ccview.delegate = nil;
    ccview.adNativeModel = nil;
    ccview = nil;
}
-(void) getImageFromURL:(NSString *)fileURL img:(void(^)(UIImage *ig))image
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage * result;
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
        result = [UIImage imageWithData:data];
        image(result);
    });
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
-(void)CTNativeAdDidClick:(UIView *)nativeAd;
{
    XPLog(@"CTNativeAdDidClick");
}

-(void)CTNativeAdDidIntoLandingPage:(UIView *)nativeAd;
{
    XPLog(@"CTNativeAdDidIntoLandingPage");
}
-(void)CTNativeAdDidLeaveLandingPage:(UIView *)nativeAd;
{
    XPLog(@"CTNativeAdDidLeaveLandingPage");
}

-(void)CTNativeAdWillLeaveApplication:(UIView *)nativeAd;
{
    XPLog(@"CTNativeAdWillLeaveApplication");
}
- (void)CTNativeAdJumpfail:(UIView *)nativeAd
{
    XPLog(@"NativeAdJumpfail");
}
@end
