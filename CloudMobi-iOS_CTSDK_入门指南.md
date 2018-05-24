### CloudMobi - iOS CTSDK 对接指南

按照CloudMobi SDK对接指南，将我们的 SDK 集成到您的应用程序，方便您对接！这里引用的源代码可以在我们的公共 [demo](https://github.com/cloudmobi/CloudmobiSSP/blob/master/iOS-SDK-Demo.zip) 存储库中获得。

##### 目录

- [在您对接SDK之前需要注意以下几点](#begin)
- [将CloudMobi SDKt添加到Xcode项目中](#install)
- [SDK广告接口及其使用](#use)

###### <a name="begin">在您对接SDK之前需要注意以下几点</a>

- [CloudMobi iOS SDK（点击下载）](https://github.com/cloudmobi/CloudmobiSSP/blob/master/(CT)iOS-SDK.zip) 支持iOS7+，并支持32位和64位应用程序
- 集成需要 CloudMobi 账号，所以如果您目前还没有该账号的话，请联系我们的运营人员。

###### <a name="install">将CloudMobi iOS SDK添加到Xcode项目中</a>

1. 将[CloudMobi iOS SDK](https://github.com/cloudmobi/CloudmobiSSP/blob/master/(CT)iOS-SDK.zip)下载解压之后将 CTSDK.framework 放到 Frameworks 下的 Xcode 中。

2. 添加其他的必需的框架
   CloudMobi iOS SDK 需要一些其他本地框架来链接到您的项目，因此请点击您的项目，并前往：

   General > Linked Frameworks and Libraries
   许多这些框架已经包括在内，因为它们是大多数 Xcode 项目的默认框架，但请务必添加以下任何尚未包含在内的框架：

   - AdSupport.framework
   - AVFoundation.framework
   - Foundation.framework
   - StoreKit.framework
   - SystemConfiguration.framework
   - UIKit.framework
   - CTSDK.framework

   同时应该检查 [CTSDK](https://github.com/cloudmobi/CloudmobiSSP/blob/master/(CT)iOS-SDK.zip) 框架是否出现在链接框架和库下面。如果先前的拖放步骤没有自动链接，我们可以通过点击 '+' 然后'添加其他'手动添加它。

3. 添加 -ObjC 链接器标志
   这可以通过导航到构建设置并将 -ObjC 添加到其他链接器标志，前往Build Settings->Other Link Flags 进行添加

4. 应用程序传输安全 (ATS)
   从 iOS 9（使用 Xcode 7 构建）开始，应用程序传输安全性需要通过 HTTPS 保护的应用程序所做的所有网络流量。来自CloudMobi iOS SDK 的流量还有一部分未支持 HTTPS。在此之前，我们建议您将 NSAllowsArbitraryLoads 值设置为 YES。

   ```
    <key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
    ```

5. SDK的初始化
   务必尽快初始化 SDK，以确保广告SDK拉取配置并预先缓存。 对于我们的 [demo](https://github.com/cloudmobi/CloudmobiSSP/blob/master/iOS-SDK-Demo.zip)（以及我们对所有 iOS 项目的建议），我们会将初始化调用添加到主 AppDelegate 上的 didFinishLaunchingWithOptions 方法。

   **注意：**如果您尝试导入 并且找不到它，请删除该引用并再次添加它，并选择“根据需要复制项目”选项。

- **AppDelegate.h:**

```
#import <CTSDK/CTSDK.h>

```

- **AppDelegate.m : didFinishLaunchingWithOptions:**

```
NSString* slotid = @"你的CloudMobi账户当前App下的任意一个广告ID";
[[CTService shareManager] loadRequestGetCTSDKConfigBySlot_id:slotID];

```

**注意：** loadRequestGetCTSDKConfigBySlot_id 方法应只调用一次，如果您的APP中有激励视频广告，**请务必用激励视频广告位ID做初始化**。

###### <a name="use">CloudMobi iOS SDK广告接口及其使用</a>

我们支持的广告类型有以下几种：

- [元素广告](#native)
- [应用墙](#Appwall)
- [激励视频](#rewardvideo)
- [模板广告（包括条幅广告、插屏广告和原生模板广告）](#template)
- [原生视频广告](#nativevideo)
- [新插屏广告](#NewInterstitial)

------

**注意:**首先你应该通过CTSDK中CTService类提供的单例方法来获取单例对象。然后通过该对象请求不同的广告接口获取不同类型的广告。

------

<a name="native">获取元素(Native)广告</a>

```
通过CTNative接口来获取元素对象，通过该元素对象获取不同的广告元素自己拼接广告展示。

    /**
     * 获取元素广告对象,使用继承CTNativeAd广告视图定制广告展示,在显示之前添加到父视图
     * 由于GDPR，因此广告角标需要媒体手动添加touch事件，可以通过safai打开返回的choices_link_url。角标使用ADsignImage对象
     * @param slot_Id       Native元素广告SlotID
     * @param delegate      设置遵守 <CTNativeAdDelegate> 的代理对象
     * @param WHRate        设置获取广告元素中大图的图片比例1.9:1/1:1
     * @param isTest        是否开启Debug模式，保留参数
     * @param success       请求成功的回调接口，返回广告元素对象
     * @param failure       请求失败的回调接口，返回错误信息
     */
    -(void)getNativeADswithSlotId:(NSString *)slot_id
                     delegate:(id)delegate
          imageWidthHightRate:(CTImageWidthHightRate)WHRate
                       isTest:(BOOL)isTest
                      success:(void (^)(CTNativeAdModel *nativeModel))success
                      failure:(void (^)(NSError *error))failure;
/**
     * 获取多元素广告对象,使用继承CTNativeAd广告视图定制广告展示,在显示之前添加到父视图
     * 由于GDPR，因此广告角标需要媒体手动添加touch事件，可以通过safai打开返回的choices_link_url。角标使用ADsignImage对象
     * @param slot_Id       Native元素广告SlotID
     * @param num                要获取多少个元素对象
     * @param delegate      设置遵守 <CTNativeAdDelegate> 的代理对象
     * @param WHRate        设置获取广告元素中大图的图片比例1.9:1/1:1
     * @param isTest        是否开启Debug模式，保留参数
     * @param success       请求成功的回调接口，返回广告元素对象
     * @param failure       请求失败的回调接口，返回错误信息
     */
    -(void)getMultitermNativeADswithSlotId:(NSString *)slot_id
                             adNumbers:(NSInteger)num
                              delegate:(id)delegate
                   imageWidthHightRate:(CTImageWidthHightRate)WHRate
                                isTest:(BOOL)isTest
                               success:(void (^)(NSArray *nativeArr))success
                               failure:(void (^)(NSError *error))failure;
                               
    CTNativeAdDelegate 代理回调方法
    -(void)CTNativeAdDidClick:(UIView *)nativeAd;              //用户点击广告
    -(void)CTNativeAdDidIntoLandingPage:(UIView *)nativeAd;    //用户将要进入落地页
    -(void)CTNativeAdDidLeaveLandingPage:(UIView *)nativeAd;   //用户离开落地页
    -(void)CTNativeAdWillLeaveApplication:(UIView *)nativeAd;  //离开App


**示例代码如下，多广告接口以数组形式返回，数组中的对象是CTNativeAdModel**
    CTService *service = [CTService shareManager];
     [service getNativeADswithSlotId:@"260" delegate:self imageWidthHightRate:CTImageWHRateOnePointNineToOne isTest:NO success:^(CTNativeAdModel *nativeModel) {
        CTView *cview = [[CTView alloc]init]; //CTView是继承自CTNativeAd的View
        cview.adNativeModel = nativeModel;
        cview.frame = CGRectMake(30, 30, self.view.frame.size.width -60, 450);
        cview.titleLable.text = nativeModel.title;
        cview.iconImage.image = [self getImageFromURL:nativeModel.icon];
        cview.imageImage.image = [self getImageFromURL:nativeModel.image];
        cview.descLable.text = nativeModel.desc;
        [cview.button setTitle:nativeModel.button forState:UIControlStateNormal];
        cview.starLable.text = [NSString stringWithFormat:@"%f",nativeModel.star];
        cview.logoImage.image = nativeModel.ADsignImage;
        [self.view addSubview:cview];
        
    } failure:^(NSError *error) {
        NSLog(@"请求广告失败：%@",error);
    }];

```

<a name="Appwall">获取应用墙</a>

```
    /**
     * 获取应用墙控制器
     * 首先，你应该调用preloadAppWallWithSlotID接口来获取广告数据，然后在回调成功之后调用showAppWallViewController接口获取应用墙控制器并推出展示
     * @param slot_Id       Appwall广告SlotID
     * @param customColor   如果你想自定义UI颜色，需要创建出CTCustomColor对象并赋值相应颜色
     * @param delegate      设置遵守 <CTAppWallDelegate> 的代理对象
     * @param isTest        是否开启Debug模式，保留参数
     * @param success       请求数据成功
     * @param failure       请求数据失败
     */
     - (void)preloadAppWallWithSlotID:(NSString *)slot_id
                customColor:(CTCustomColor *)customColor
                   delegate:(id)delegate
                     isTest:(BOOL)isTest
                    success:(void(^)())success
                    failure:(void(^)(NSError *error))failure;
                    
     - (UIViewController *)showAppWallViewController;
     
     CTAppWallDelegate 代理回调方法 
     -(void)CTAppWallDidClick:(CTElementAd *)ElementAd;             //点击广告
     -(void)CTAppWallDidIntoLandingPage:(CTElementAd *)ElementAd;   //进入落地页
     -(void)CTAppWallDidLeaveLandingPage:(CTElementAd *)ElementAd;  //离开落地页
     -(void)CTAppWallWillLeaveApplication:(CTElementAd *)ElementAd; //离开应用
     -(void)CTAppWallClosed;                                        //关闭应用墙
    

```

<a name="rewardvideo">获取激励视频</a>

```
    /**
     * 获取激励视频
     * 首先，你需要调用loadRewardVideoWithSlotId:delegate:方法来获取RewardVideo，然后在成功的回调中通过show接口展示广告
     * @param slot_Id       RewardVideo广告SlotID
     * @param delegate      设置遵守 <CTRewardVideoDelegate> 的代理对象
     */
    - (void)loadRewardVideoWithSlotId:(NSString *)slot_id delegate:(id)delegate;
    /**
     展示激励视频
     @param viewController 设置用于推出激励视频的Viewcontroller
     */
    - (void)showRewardVideoWithPresentingViewController:(UIViewController *)viewController;
    /**
     展示广告之前再次检查广告是否可以播放
     */
    - (BOOL)checkRewardVideoIsReady;
    /**
    设置激励视频自定义参数
    @param customParams         自定义参数
    */
    - (void)setCustomParameters:(NSString *)customParams;
    
    CTRewardVideoDelegate 代理回调方法
    - (void)CTRewardVideoLoadSuccess;                       //激励视频请求成功
    - (void)CTRewardVideoDidStartPlaying;                   //激励视频开始播放
    - (void)CTRewardVideoDidFinishPlaying;                  //激励视频播放完成
    - (void)CTRewardVideoDidClickRewardAd;                  //激励视频点击代理
    - (void)CTRewardVideoWillLeaveApplication;              //激励视频将要离开应用
    - (void)CTRewardVideoJumpfailed;                        //激励视频点击跳转失败
    - (void)CTRewardVideoLoadingFailed:(NSError *)error;    //激励视频请求失败
    - (void)CTRewardVideoClosed;                            //关闭激励视频
    - (void)CTRewardVideoAdRewardedName:(NSString *)rewardName rewardAmount:(NSString *)rewardAmount customParams:(NSString*) customParams;//奖励回调接口

```

<a name="template">获取模板广告（包括横幅广告，插屏广告和原生模板广告）</a>

```
/**
 获取条幅广告
 @param slot_id         Banner广告SlotID
 @param delegate        设置遵守 <CTBannerDelegate> 的代理对象
 @param frame           设置广告Frame
 @param isNeedBtn       是否在右上角显示关闭按钮
 @param isTest          是否开启Debug模式，保留参数
 @param success         请求成功回调接口，并返回bannerView对象
 @param failure         请求失败回调接口
 */
- (void)getBannerADswithSlotId:(NSString *)slot_id
                      delegate:(id)delegate
                         frame:(CGRect)frame
               needCloseButton:(BOOL)isNeedBtn
                        isTest:(BOOL)isTest
                       success:(void (^)(UIView *bannerView))success
                       failure:(void (^)(NSError *error))failure;
                       
CTBannerDelegate 代理回调方法
-(void)CTBannerDidClick:(CTBanner*)banner;                  //点击广告
-(void)CTBannerDidIntoLandingPage:(CTBanner*)banner;        //进入落地页
-(void)CTBannerDidLeaveLandingPage:(CTBanner*)banner;       //离开落地页
-(void)CTBannerClosed:(CTBanner*)banner;                    //关闭广告
-(void)CTBannerWillLeaveApplication:(CTBanner*)banner;      //将要离开应用
-(void)CTBannerHtml5Closed:(CTBanner*)banner;               //关闭广告
-(void)CTBannerJumpfail:(CTBanner*)banner;                  //跳转失败

/**
 获取插屏广告，并返回InterstitialView对象
 @param slot_id         Interstitial广告SlotID
 @param delegate        设置遵守 <CTInterstitialDelegate> 的代理对象
 @param isFull          设置是否是全屏显示
 @param isTest          是否开启Debug模式，保留参数
 @param success         请求成功回调接口，并返回InterstitialView对象
 @param failure         请求失败回调接口
 */
- (void)preloadInterstitialWithSlotId:(NSString *)slot_id
                             delegate:(id)delegate
                         isFullScreen:(BOOL)isFull
                               isTest:(BOOL)isTest
                              success:(void (^)(UIView *InterstitialView))success
                              failure:(void (^)(NSError *error))failure;
/**
 展示插屏
 */
- (BOOL)interstitialShow;
/**
 关闭插屏
 */
- (BOOL)interstitialClose;
/**
 Interstitial Screen Direction
 如果使用了interstitialShow来展示广告，你可以通过以下接口来设置横竖屏
 */
- (void)ScreenIsVerticalScreen:(BOOL)isVerticalScreen;
/**
 通过Viewcontroller的形式展示广告
 */
- (BOOL)interstitialShowWithControllerStyleFromRootViewController:(UIViewController *)rootViewController;

CTInterstitialDelegate 代理回调方法
-(void)CTInterstitialDidClick:(CTInterstitial*)interstitialAD;              //点击广告
-(void)CTInterstitialDidIntoLandingPage:(CTInterstitial*)interstitialAD;    //进入落地页
-(void)CTInterstitialDidLeaveLandingPage:(CTInterstitial*)interstitialAD;   //离开落地页
-(void)CTInterstitialClosed:(CTInterstitial*)interstitialAD;                //关闭插屏
-(void)CTInterstitialWillLeaveApplication:(CTInterstitial*)interstitialAD;  //离开应用
-(void)CTInterstitialJumpfail:(CTInterstitial*)interstitialAD;              //跳转失败

/**
 请求NATemplate广告，并返回NaTemplateView对象
 @param slot_id         NATemplate广告SlotID
 @param delegate        设置遵守 <CTNaTemplateDelegate> 的代理对象
 @param frame           设置广告Frame
 @param isNeedBtn       是否在右上角显示关闭按钮
 @param isTest          是否开启Debug模式，保留参数
 @param success         请求成功回调接口，并返回NaTemplateView对象
 @param failure         请求失败回调接口
 */
- (void)getNaTemplateADswithSlotId:(NSString *)slot_id
                          delegate:(id)delegate
                             frame:(CGRect)frame
                   needCloseButton:(BOOL)isNeedBtn
                            isTest:(BOOL)isTest
                           success:(void (^)(UIView *NaTemplateView))success
                           failure:(void (^)(NSError *error))failure;
                           
CTNaTemplateDelegate 代理回调方法
-(void)CTNaTemplateDidClick:(CTNaTemplate*)naTemplate;              //点击广告
-(void)CTNaTemplateDidIntoLandingPage:(CTNaTemplate*)naTemplate;    //进入落地页
-(void)CTNaTemplateDidLeaveLandingPage:(CTNaTemplate*)naTemplate;   //离开落地页
-(void)CTNaTemplateClosed:(CTNaTemplate*)naTemplate;                //关闭广告
-(void)CTNaTemplateWillLeaveApplication:(CTNaTemplate*)naTemplate;  //将要离开应用
-(void)CTNaTemplateHtml5Closed:(CTNaTemplate*)naTemplate;           //关闭模板
-(void)CTNaTemplateJumpfail:(CTNaTemplate*)naTemplate;              //跳转失败
```
<a name="nativevideo">获取原生视频广告</a>
```
/**
 请求原生视频广告
 由于GDPR，因此广告角标需要媒体手动添加touch事件，可以通过safai打开返回的choices_link_url。角标使用ADsignImage对象
 @param slot_id         Native Video广告SlotID，否则会请求不到广告
 @param delegate        设置遵守 <CTNativeVideoDelegate> 的代理对象
 @param WHRate          设置获取广告元素中大图的图片比例1.9:1/1:1
 @param isTest          是否开启Debug模式，保留参数
 */
- (void)getNativeVideoADswithSlotId:(NSString*)slot_id
                           delegate:(id)delegate
                imageWidthHightRate:(CTImageWidthHightRate)WHRate
                             isTest:(BOOL)isTest;
			     
CTNativeVideoDelegate 代理回调方法
-(void)CTNativeVideoLoadSuccess:(CTNativeVideoModel *)nativeVideoModel;  //广告请求成功回调函数
-(void)CTNativeVideoLoadFailed:(NSError *)error;                         //广告请求失败回调函数
```


<a name="NewInterstitial">获取插屏(New)</a>

```
  /**
   预加载插屏广告.
 
 参数 slot_id         广告位
 参数 delegate        广告代理对象 <CTADInterstitialDelegate>
 参数 isTest          是否是测试模式(填入NO即可) 
 */
- (void)preloadInterstitialAdWithSlotId:(NSString *)slot_id
                             delegate:(id)delegate
                               isTest:(BOOL)isTest;

/**
 展示差评广告,会默认在app最上层UIViewController上present出广告
 在预加载接口返回成功后调用
 */
- (void)interstitialAdShow;

/**
 展示差评广告,会在app传入的UIViewController上present出广告,如果填写nil,则与interstitialAdShow功能相同.
 在预加载接口返回成功后调用
 */
- (void)interstitialAdShowWithController:(UIViewController *)VC;

/**
检查广告是否准备好了,如果返回了YES 就可以调用广告展示接口了.返回NO则广告没有准备好
 */
- (BOOL)interstitialAdIsReady;

广告返回代理接口<CTADInterstitialDelegate>,需app实现

//广告获取成功
-(void)CTADInterstitialGetAdSuccess;

//广告获取失败
-(void)CTADInterstitialGetAdFailed:(NSError *)error;

//广告展示失败
- (void)CTADInterstitialAdShowFailed:(NSError *)error;

//广告被点击
-(void)CTADInterstitialDidClick;

//广告跳到落地页
- (void)CTADInterstitialDidIntoLandingPage;

//广告跳往落地页失败
- (void)CTADInterstitialJumpFailed;

//广告被关闭
-(void)CTADInterstitialClosed;

```
