//
//  ViewController.m
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import "ViewController.h"
#import "BannerViewController.h"
#import "InterstitialViewController.h"
#import "NaTemplateViewController.h"
#import "CTNativeOneViewController.h"
#import "CTNativeManyViewController.h"
#import "KeyWordsViewController.h"
#import "AppWallViewController.h"
#import "VideoADController.h"
#import "RewardVideoViewController.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *adListArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSArray *)adListArr
{
    if (!_adListArr) {
        _adListArr = @[@"getBannerADswithSlotId 接口",
                       @"preloadInterstitialWithSlotId 接口",
                       @"getNaTemplateADswithSlotId 接口",
                       @"getNativeADswithSlotId 接口",
                       @"getMultitermNativeADswithSlotId 接口",
                       @"getNativeADswithSlotId(keywords) 接口",
                       @"preloadAppWallWithSlotID 接口",
                       @"getVideoWithSlotID 接口",
                       @"getRewardVideoWithSlotID 接口"];
    }
    return _adListArr;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.adListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = self.adListArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self requestAdsWithTypeIndex:indexPath.row];
}
- (void)requestAdsWithTypeIndex:(NSInteger)typeIndex
{
    if (typeIndex == 0)
    {
        BannerViewController *vc = [[BannerViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 1){
        InterstitialViewController *vc = [[InterstitialViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 2){
        NaTemplateViewController *vc = [[NaTemplateViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 3){
        CTNativeOneViewController *vc = [[CTNativeOneViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 4){
        CTNativeManyViewController *vc = [[CTNativeManyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 5){
        KeyWordsViewController *vc = [[KeyWordsViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 6){
        AppWallViewController *vc = [[AppWallViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 7){
        VideoADController *vc = [[VideoADController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (typeIndex == 8){
        RewardVideoViewController *vc = [[RewardVideoViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
