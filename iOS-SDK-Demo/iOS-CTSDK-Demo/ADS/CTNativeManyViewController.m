//
//  CTNativeManyViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "CTNativeManyViewController.h"
#import "Tools.h"
#import <CTSDK/CTService.h>
#import "CTView.h"
#import <CTSDK/CTADExternalDelegate.h>
@interface CTNativeManyViewController ()<CTNativeAdDelegate>
@property (nonatomic, strong)CTView *cview;
@property (nonatomic, strong)CTView *cview1;
@property (nonatomic, strong)ZCJHUD *hud;
@end

@implementation CTNativeManyViewController
@synthesize cview;
@synthesize cview1;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MultitermNativeAD获取";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:115/255.0 green:74/255.0 blue:18/255.0 alpha:1];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width , 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"RequestAd"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getCTMany_ElementViewController) forControlEvents:UIControlEventTouchUpInside];
    UIButton* btn31 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn31.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50);
    btn31.backgroundColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0 alpha:1];
    [btn31 setTitle:@"关闭" forState:UIControlStateNormal];
    [btn31 addTarget:self action:@selector(closeAdView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn31];
}

- (void)getCTMany_ElementViewController
{
    [self showGetAdWithStr:@"开始请求广告"];
    @weakify(self)
    CTService *service = [CTService shareManager];
    [service getMultitermNativeADswithSlotId:TwoNativeSlotId adNumbers:2 delegate:service imageWidthHightRate:CTImageWHRateOnePointNineToOne isTest:YES success:^(NSArray *nativeArr) {
        @strongify(self)
        cview = [[CTView alloc]initWithFrame:CGRectMake(30, 70, XPWidth -60, (XPWidth -60)/1.9+20)];
        if ([nativeArr isKindOfClass:[NSNull class]] && nativeArr == nil)
        {
            return ;
        }
        if (nativeArr.count >= 1)
        {
            cview.adNativeModel = [nativeArr objectAtIndex:0];
            cview.delegate = self;
            cview.backgroundColor = [UIColor grayColor];
            [self.view addSubview:cview];
            cview.titleLable.text = cview.adNativeModel.title;
            cview.descLable.text = cview.adNativeModel.desc;
            [cview.button setTitle:cview.adNativeModel.button forState:UIControlStateNormal];
            cview.starLable.text = [NSString stringWithFormat:@"%f",cview.adNativeModel.star];
            cview.logoImage.image = cview.adNativeModel.ADsignImage;
            [self getImageFromURL:cview.adNativeModel.icon img:^(UIImage *ig) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cview.iconImage.image = ig;
                });
            }];
            [self getImageFromURL:cview.adNativeModel.image img:^(UIImage *ig) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cview.imageImage.image = ig;
                });
            }];
        }
        
        if (nativeArr.count >= 2)
        {
            cview1 = [[CTView alloc]initWithFrame:CGRectMake(30, (XPWidth -60)/1.9+20 + 80, XPWidth -60, (XPWidth -60)/1.9+20)];
            cview1.adNativeModel = [nativeArr objectAtIndex:1];
            cview1.backgroundColor = [UIColor grayColor];
            cview1.delegate = self;
            [self.view addSubview:cview1];
            cview1.titleLable.text = cview1.adNativeModel.title;
            cview1.descLable.text = cview1.adNativeModel.desc;
            [cview1.button setTitle:cview1.adNativeModel.button forState:UIControlStateNormal];
            cview1.starLable.text = [NSString stringWithFormat:@"%f",cview1.adNativeModel.star];
            cview1.logoImage.image = cview1.adNativeModel.ADsignImage;
            [self getImageFromURL:cview1.adNativeModel.icon img:^(UIImage *ig) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cview1.iconImage.image = ig;
                });
            }];
            [self getImageFromURL:cview1.adNativeModel.image img:^(UIImage *ig) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    cview1.imageImage.image = ig;
                });
            }];
        }
        
        XPLog(@"Many Element 获取成功");
    }  failure:^(NSError *error) {
        XPLog(@" MultitermElement:这是怎么回事啊，怎么错啊！%@",error.description);
    }];
}
-(void)closeAdView
{
    [cview removeFromSuperview];
    cview.delegate = nil;
    cview.adNativeModel = nil;
    cview = nil;
    [cview1 removeFromSuperview];
    cview1.delegate = nil;
    cview1.adNativeModel = nil;
    cview1 = nil;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
