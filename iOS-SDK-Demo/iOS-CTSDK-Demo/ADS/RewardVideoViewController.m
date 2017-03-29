//
//  RewardVideoViewController.m
//  CTSDK_iOS
//
//  Created by 兰旭平 on 2017/3/10.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "RewardVideoViewController.h"
#import <CTSDK/CTService.h>
#import <CTSDK/CTRewardVideoDelegate.h>
#import "Tools.h"
@interface RewardVideoViewController ()<CTRewardVideoDelegate>

@end

@implementation RewardVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[CTService shareManager] loadRewardVideoWithSlotId:@"260" delegate:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)CTRewardVideoLoadSuccess
{
    XPLog(@"CTRewardVideoLoadSuccess");
    [[CTService shareManager] showRewardVideo];
}

/**
 *  CTRewardVideo bigin playing Ad
 **/
- (void)CTRewardVideoDidStartPlaying
{
    XPLog(@"CTRewardVideoDidStartPlaying");
}

/**
 *  CTRewardVideo playing Ad finish
 **/
- (void)CTRewardVideoDidFinishPlaying
{
    XPLog(@"CTRewardVideoDidFinishPlaying");
}

/**
 *  CTRewardVideo Click Ads
 **/
- (void)CTRewardVideoDidClickRewardAd
{
    XPLog(@"CTRewardVideoDidClickRewardAd");
}

/**
 * CTRewardVideo will leave Application
 **/
- (void)CTRewardVideoWillLeaveApplication
{
    XPLog(@"CTRewardVideoWillLeaveApplication");
}

/**
 *  CTRewardVideo jump AppStroe failed
 **/
- (void)CTRewardVideoJumpfailed
{
    XPLog(@"CTRewardVideoJumpfailed");
}

/**
 *  CTRewardVideo loading failed
 **/
- (void)CTRewardVideoLoadingFailed:(NSError *)error
{
    XPLog(@"出错了%@",error.description);
}

- (void)CTRewardVideoClosed
{
    XPLog(@"CTRewardVideoClosed");
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
