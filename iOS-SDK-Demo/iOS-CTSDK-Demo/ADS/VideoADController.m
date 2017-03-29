//
//  VideoADController.m
//  CTSDK_iOS
//
//  Created by 兰旭平 on 2017/2/14.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "VideoADController.h"
#import <CTSDK/CTService.h>
#import <CTSDK/CTVideoDelegate.h>
@interface VideoADController ()
@property (nonatomic, strong)UIView *videoV;
@end

@implementation VideoADController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Video";
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:1 alpha:1];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor colorWithRed:115/255.0 green:74/255.0 blue:18/255.0 alpha:1];
    button.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width , 50);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"RequestAd"] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(getVideo) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* btn31 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn31.frame = CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 50);
    btn31.backgroundColor = [UIColor colorWithRed:255/255.0 green:165/255.0 blue:0 alpha:1];
    [btn31 setTitle:@"关闭" forState:UIControlStateNormal];
    [btn31 addTarget:self action:@selector(closeAdView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn31];
}
- (void)getVideo
{
    [[CTService shareManager] getVideoADswithSlotId:@"260" delegate:self frame:CGRectMake(20, 100, self.view.frame.size.width - 40, (self.view.frame.size.width - 40)/1.8) isTest:YES success:^(UIView *videoView) {
        NSLog(@"%@",NSStringFromCGRect(videoView.frame));
        self.videoV = videoView;
        [self.view addSubview:videoView];
    } failure:^(NSError *error) {
        
    }];
}
- (void)CTVideoStartPlay:(UIView *)videoView
{
    [[CTService shareManager] videoViewPlay:self.videoV isMute:NO];
}
- (void)closeAdView
{
    [self.videoV removeFromSuperview];
    self.videoV = nil;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    self.videoV.frame = CGRectMake(10, 200, 200, 200);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
