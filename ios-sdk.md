
###index
* [SDK download and setup](#install)
* [SDK Advanced API reference](#advancedApi)
* [SDK Basic API reference](#basicApi)
* [SDK error code table](#errorcode)
* [Sample code](#sample)
* [How to apply Facebook/Admob advertisement](#reference)


###<a name="install">SDK download and setup</a>
* According to the [How to apply Facebook/Admob advertisement](#reference) import relevant Framework , add a static link to: Build Settings -> Other Linker Flags -> $(OTHER_LDFLAGS) -ObjC.

		FBAudienceNetwork.framework
		GoogleMobileAds.framework
		CTSDK.framework 

* In Build Phases -> Link Binary With Libraries -> add AdSupport.framework and libsqlite3.0.tbd 
* In Info.plist added the NSAppTransportSecurity, the type for Dictionary.
In NSAppTransportSecurity added the NSAllowsArbitraryLoads the Boolean,setting the YES
* Import the hearder file : #import &lt;CTSDK/CTService.h&gt;
* If you use Admob ADs,you should import Firebase SDK,then introduced the AppDelegate header file # import &lt;Firebase. H&gt;,And then call methods in didFinishLaunchingWithOptions [FIRApp configure];


###<a name="advancedApi">SDK Advanced API reference</a>

```
	We recommend use CTNative Interface！！！
	//You should pass the singleton method to create the object, then calls the requests of the different types of ads.
	+(instancetype)shareManager;
	
 	/**
     * Get CTNative Ad 
     *
     * @param slot_Id 		Cloud Tech Native AD ID
     * @param delegate		Set Delegate of Ad event(<CTNativeAdDelegate>)
     * @param WHRate 		Set Image Rate
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block, return Native Element Ad
     * @param failure		The request failed Block, retuen error
     */
	-(void)getNativeADswithSlotId:(NSString *)slot_id
                     delegate:(id)delegate
          imageWidthHightRate:(CTImageWidthHightRate)WHRate
                       isTest:(BOOL)isTest
                      success:(void (^)(CTNativeAdModel *nativeModel))success
                      failure:(void (^)(NSError *error))failure;                                                                                                             

	
    /**
     * Get Multiterm Element Native ADs 
     *
     * @param slot_Id		Cloud Tech Native AD ID
     * @param num			Request Ads number
     * @param delegate		Set Delegate of Ads event(<CTNativeAdDelegate>)
     * @param WHRate		Set Image Rate
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block, return Native Element Ad
     * @param failure		The request failed Block, retuen error
     */
    -(void)getMultitermNativeADswithSlotId:(NSString *)slot_id
                             adNumbers:(NSInteger)num
                              delegate:(id)delegate
                   imageWidthHightRate:(CTImageWidthHightRate)WHRate
                                isTest:(BOOL)isTest
                               success:(void (^)(NSArray *nativeArr))success
                               failure:(void (^)(NSError *error))failure;
	
	
	/**
     * Get Keywords Element Native ADs 
     *
     * @param slot_Id		Cloud Tech Native AD ID
     * @param delegate		Set Delegate of Ads event(<CTNativeAdDelegate>)
     * @param WHRate		Set Image Rate
     * @param adcat			Set Ad Type
     * @param keyWords		Set Ad Keywords
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block, return Native Keywords Element Ad
     * @param failure		The request failed Block, retuen error
     */
    -(void)getNativeADswithSlotId:(NSString *)slot_id
              			  delegate:(id)delegate
         	  imageWidthHightRate:(CTImageWidthHightRate)WHRate
                	        adcat:(NSInteger)cat
               	     	 keyWords:(NSArray *)keyWords
                 	       isTest:(BOOL)isTest
                 	      success:(void (^)(CTNativeAdModel *nativeModel))success
                   	      failure:(void (^)(NSError *error))failure;

```

###<a name="basicApi">SDK Basic API reference</a> 
 

```                      
                    
    /**
     * Get Banner Ad View
     *
     * @param slot_Id		Cloud Tech Banner AD ID
     * @param delegate		Set Delegate of Ad event(<CTBannerDelegate>)
     * @param frame			Set Ad Frame
     * @param isNeedBtn		show close button at the top-right corner of the advertisement
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block, return Banner Ad View
     * @param failure		The request failed Block, retuen error
     */
     
    -(void)getBannerADswithSlotId:(NSString *)slot_id
                     delegate:(id)delegate
                        frame:(CGRect)frame
              needCloseButton:(BOOL)isNeedBtn
                       isTest:(BOOL)isTest
                      success:(void (^)(UIView *bannerView))success
                      failure:(void (^)(NSError *error))failure;
 

    /**
     * Get Interstitial Ad View
     *
     * @param slot_Id		Cloud Tech Intersitital AD ID
     * @param delegate		Set Delegate of Ad event(<CTInterstitialDelegate>)
     * @param isFull		If is Screen，set Yes,else set No
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block, return Interstitial Ad View
     * @param failure		The request failed Block, retuen error
     */
     
    -(void)preloadInterstitialWithSlotId:(NSString*)slot_id
                            delegate:(id)delegate
                        isFullScreen:(BOOL)isFull
                              isTest:(BOOL)isTest
                             success:(void (^)(UIView* InterstitialView))success
                             failure:(void (^)(NSError *error))failure;
                             
    /**
     * Show interstitial advertisement by present VC stryle
     */
    -(BOOL)interstitialShowWithControllerStyle;
    
    /**
     * Show interstitial advertisement
     *
     * Request success, call this method show Ad View
     */
    -(BOOL)interstitialShow;
    
    /**
     * If you use interstitialShow,you can use this method Support the relation screen
     */
    -(void)ScreenIsVerticalScreen:(BOOL)isVerticalScreen;

    /**
     * Close the interstitial advertisement
     *
     * call this method close Ad View
     */
	-(BOOL)interstitialClose;   


    /**
     * Get NaTemplate Ad View
     *
     * @param slot_Id		Cloud Tech Native AD ID
     * @param delegate		Set Delegate of Ad event(<CTNaTemplateDelegate>)
     * @param frame			Set Ad Frame
     * @param isNeedBtn		show close button at the top-right corner of the advertisement
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block, return Native Ad View
     * @param failure		The request failed Block, retuen error
     */
     
    -(void)getNaTemplateADswithSlotId:(NSString *)slot_id
                     delegate:(id)delegate
                        frame:(CGRect)frame
              needCloseButton:(BOOL)isNeedBtn
                       isTest:(BOOL)isTest
                      success:(void (^)(UIView *NaTemplateView))success
                      failure:(void (^)(NSError *error))failure;


	/**
     * Get AppWall ViewController
     * First,you must should Call preloadAppWallWithSlotID method,Then get successs,call showAppWallViewController method show Appwall！
     * @param slot_Id		Cloud Tech Native AD ID
     * @param customColor	If you want set custom UI,you should create CTCustomColor object
     * @param delegate		Set Delegate of Ads event (<CTAppWallDelegate>)
     * @param isTest		Use test advertisement or not
     * @param success		The request is successful Block
     * @param failure		The request failed Block, retuen error
     */
    
    -(void)preloadAppWallWithSlotID:(NSString *)slot_id
                customColor:(CTCustomColor *)customColor
                   delegate:(id)delegate
                     isTest:(BOOL)isTest
                    success:(void(^)())success
                    failure:(void(^)(NSError *error))failure;
                    
    -(UIViewController *)showAppWallViewController;
	
```



###### CTNativeAdDelegate Class Methods：Call back interface for the advertisement loading process.

```
    /**
	 * User click the advertisement.
 	 */
	-(void)CTNativeAdDidClick:(UIView *)nativeAd;
	/**
	 * Advertisement landing page will show.
	 */
	-(void)CTNativeAdDidIntoLandingPage:(UIView *)nativeAd;
	/**
 	 * User left the advertisement landing page.
 	 */
	-(void)CTNativeAdDidLeaveLandingPage:(UIView *)nativeAd;
	/**
	 * Leave App
	 */
	-(void)CTNativeAdWillLeaveApplication:(UIView *)nativeAd;

 
```


###### CTAppWallDelegate Class Methods：Call back interface for the advertisement loading process.

```
    /**
	 * User click the advertisement.
	 */
	-(void)CTAppWallDidClick:(CTElementAd *)ElementAd;
	/**
	 * Advertisement landing page will show.
	 */
	-(void)CTAppWallDidIntoLandingPage:(CTElementAd *)ElementAd;
	/**
	 * User left the advertisement landing page.
	 */
	-(void)CTAppWallDidLeaveLandingPage:(CTElementAd *)ElementAd;
	/**
	 * Leave App
	 */
	-(void)CTAppWallWillLeaveApplication:(CTElementAd *)ElementAd;
	/**
	 * User close the advertisement.
	 */
	-(void)CTAppWallClosed;
	
 
```

###### CTBannerDelegate Class Methods：Call back interface for the advertisement loading process.

```
    /**
     * User click the advertisement. 
     */
    -(void)CTBannerDidClick:(CTBanner*)banner;

    /**
     * Advertisement landing page will show.
     */
    -(void)CTBannerDidIntoLandingPage:(CTBanner*)banner;

    /**
     * User left the advertisement landing page. 
     */
    -(void)CTBannerDidLeaveLandingPage:(CTBanner*)banner;

    /**
     * User close the advertisement.
     */
    -(void)CTBannerClosed:(CTBanner*)banner;

    /**
     * Leave App
     */
    -(void)CTBannerWillLeaveApplication:(CTBanner*)banner;

 
```


###### CTInterstitialDelegate Class Methods：Call back interface for the advertisement loading process.

```
    /**
     * User click the advertisement. 
     */
    -(void)CTInterstitialDidClick:(CTInterstitial*)interstitialAD;

    /**
     * Advertisement landing page will show.
     */
    -(void)CTInterstitialDidIntoLandingPage:(CTInterstitial*)interstitialAD;

    /**
     * User left the advertisement landing page. 
     */
    -(void)CTInterstitialDidLeaveLandingPage:(CTInterstitial*)interstitialAD;

    /**
     * User close the advertisement.
     */
    -(void)CTInterstitialClosed:(CTInterstitial*)interstitialAD;

    /**
     * Leave App
     */
    -(void)CTInterstitialWillLeaveApplication:(CTInterstitial*)interstitialAD;

 
```

###### CTNaTemplateDelegate Class Methods：Call back interface for the advertisement loading process.

```
    /**
 	* User click the advertisement.
	*/
	-(void)CTNaTemplateDidClick:(CTNaTemplate*)naTemplate;
	/**
	 * Advertisement landing page will show.
	 */
	-(void)CTNaTemplateDidIntoLandingPage:(CTNaTemplate*)naTemplate;
	/**
	 * User left the advertisement landing page.
	 */
	-(void)CTNaTemplateDidLeaveLandingPage:(CTNaTemplate*)naTemplate;
	/**
	 * User close the advertisement.
	 */
	-(void)CTNaTemplateClosed:(CTNaTemplate*)naTemplate;
	/**
	 * Leave App
	 */
	-(void)CTNaTemplateWillLeaveApplication:(CTNaTemplate*)naTemplate;
	/**
	 * User close the Html5.
	 */
	-(void)CTNaTemplateHtml5Closed:(CTNaTemplate*)naTemplate;


 
```


###<a name="errorcode">Error Code From SDK</a>：

| Erro Code               | Description                   |
| ------------------ | -------------------- |
| ERR\_000\_TRACK  | Track exception              |
| ERR\_001\_INVALID_INPUT     | Invalid parameter            |
| ERR\_002\_NETWORK | Network exception                 |
| ERR\_003\_REAL_API     | Error from Ad Server            |
| ERR\_004\_INVALID_DATA     | Invalid advertisement data                |
| ERR\_005\_RENDER_FAIL     | Advertisement render failed               |
| ERR\_006\_LANDING_URL     | Landing failed         |
| ERR\_007\_TO_DEFAULT_MARKET     | Implicitly lading failed            |
| ERR\_008\_DL_URL     | Deep-Link exception        |
| ERR\_009\_DL_URL_JUMP     | Deep-Link jump exception        |
| ~~ERR\_010\_APK_DOWNLOAD_URL~~     | ~~Application package download failed~~            |
| ~~ERR\_011\_APK_INSTALL~~     | ~~Application install failed~~                |
| ERR\_012\_VIDEO_LOAD     | Load the video exception              |
| ERR\_013\_PAGE_LOAD     | Load the html5 page failed               |
| ~~ERR\_014\_JAR_UPDATE_VERSION~~     | ~~Check the update jar failed~~        |
| ~~ERR\_015\_GET_GAID~~     | ~~Cannot get google advertisement id failed~~ |
| ERR\_016\_GET_AD_CONFIG     | Cannot get the account configuration or template |
| ERR\_017\_INTERSTITIAL_SHOW_NO_AD     | Try to load the interstitial advertisement, but the advertisement is not ready  |
| ERR\_018\_AD_CLOSED  |Ad slotId has been closed|
| ERR\_999\_OTHERS     | All other errors  |
|                    |                      |


###<a name="sample">Sample code</a>


#### CTNative advertisement：


First, you should create an inheritance in CTNativeAd view, and carries on the controls within the view layout

```
	
	#import <CTSDK/CTSDK.h>
	#import <CTSDK/CTNativeAd.h>
	@interface CTView : CTNativeAd
	@property (nonatomic, strong)UIImageView *logoImage;
	@property (nonatomic, strong)UILabel *titleLable;
	@property (nonatomic, strong)UIImageView *iconImage;
	@property (nonatomic, strong)UIImageView *imageImage;
	@property (nonatomic, strong)UILabel *descLable;
	@property (nonatomic, strong)UIButton *button;
	@property (nonatomic, strong)UILabel *starLable;
	@end
```

Layout for example:


```
	#import "CTView.h"
    @implementation CTView
    - (instancetype)initWithFrame:(CGRect)frame
    {
        if (self = [super initWithFrame:frame]) 
        {
            self.backgroundColor = [UIColor grayColor];
            self.logoImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 16, 0, 16, 16)];
            self.titleLable = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, frame.size.width-65, 50)];
            self.iconImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            self.imageImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50, frame.size.width, 120)];
            self.descLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 170, frame.size.width/2.0, 30)];
            self.button = [UIButton buttonWithType:UIButtonTypeCustom];
            self.button.frame = CGRectMake(frame.size.width/2.0, 170, frame.size.width/2.0, 30);
            [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self addSubview:self.logoImage];
            [self addSubview:self.titleLable];
            [self addSubview:self.iconImage];
            [self addSubview:self.imageImage];
            [self addSubview:self.descLable];
            [self addSubview:self.button];
            [self addSubview:self.starLable];
        }
        return self;
    }
    @end

```

Then call to The method to load ads:

```
	CTService *service = [CTService shareManager];
	[service getNativeADswithSlotId:@"260" delegate:self imageWidthHightRate:CTImageWHRateOnePointNineToOne isTest:NO success:^(CTNativeAdModel *nativeModel)
	{
		CTView *cview = [[CTView alloc]init];
		cview.adNativeModel = nativeModel;
		cview.backgroundColor = [UIColor grayColor];
		cview.frame = CGRectMake(30, 30, self.view.frame.size.width -60, 450);
		[self.view addSubview:cview];
		cview.titleLable.text = nativeModel.title;
		cview.iconImage.image = [self getImageFromURL:nativeModel.icon];
		cview.imageImage.image = [self getImageFromURL:nativeModel.image];
		cview.descLable.text = nativeModel.desc;
		[cview.button setTitle:nativeModel.button forState:UIControlStateNormal];
		cview.starLable.text = [NSString stringWithFormat:@"%f",nativeModel.star];
		cview.logoImage.image = nativeModel.ADsignImage;
	} failure:^(NSError *error)
	{
	  	//Request failed
	    NSLog(@"No request to the advertising success：%@",error);
	}]; 

```

#### Multiterm Element CTNative advertisement：

First, you should create an inheritance in CTElementAd view, and carries on the controls within the view layout

```
	CTService *service = [CTService shareManager];
	[service getMultitermElementNativeADswithSlotId:@"265" adNumbers:2 delegate:self imageWidthHightRate:CTImageWHRateOnePointNineToOne keyWords:nil isTest:NO success:^(NSArray *elementArr) {
	    CTView *cview = [[CTView alloc]initWithFrame:CGRectMake(30, 30, 	self.view.frame.size.width -60, 200)];
	    cview.adElementmodel = [elementArr objectAtIndex:0];
	    cview.backgroundColor = [UIColor grayColor];
	    [self.view addSubview:cview];		        
	    cview.titleLable.text = cview.adElementmodel.title;
	    cview.descLable.text = cview.adElementmodel.desc;
	    [cview.button setTitle:cview.adElementmodel.button forState:UIControlStateNormal];
	    cview.starLable.text = [NSString stringWithFormat:@"%f",cview.adElementmodel.star];
	    cview.logoImage.image = cview.adElementmodel.ADsignImage;
	    CTView *cview1 = [[CTView alloc]initWithFrame:CGRectMake(30, 250, self.view.frame.size.width -60, 200)];
	    cview1.adElementmodel = [elementArr objectAtIndex:1];
	    cview1.backgroundColor = [UIColor grayColor];
	    [self.view addSubview:cview1];
	    cview1.titleLable.text = cview1.adElementmodel.title;
	    cview1.descLable.text = cview1.adElementmodel.desc;
	    [cview1.button setTitle:cview1.adElementmodel.button forState:UIControlStateNormal];
	    cview1.starLable.text = [NSString stringWithFormat:@"%f",cview1.adElementmodel.star];
	    cview1.logoImage.image = cview1.adElementmodel.ADsignImage;
	} failure:^(NSError *error) {
	    //Request failed
	    NSLog(@"No request to the advertising success：%@",error);
	}];

```

#### Keywords Element CTNative advertisement：

First, you should create an inheritance in CTElementAd view, and carries on the controls within the view layout

```
	CTService *service = [CTService shareManager];
	[self.ctService getNativeADswithSlotId:@"260" delegate:self imageWidthHightRate:CTImageWHRateOnePointNineToOne adcat:0 keyWords:@[@"one",@"two"] isTest:YES success:^(CTNativeAdModel *nativeModel) {
        CTView *cview = [[CTView alloc]init];
		cview.adNativeModel = nativeModel;
		cview.backgroundColor = [UIColor grayColor];
		cview.frame = CGRectMake(30, 30, self.view.frame.size.width -60, 450);
		[self.view addSubview:cview];
		cview.titleLable.text = nativeModel.title;
		cview.iconImage.image = [self getImageFromURL:nativeModel.icon];
		cview.imageImage.image = [self getImageFromURL:nativeModel.image];
		cview.descLable.text = nativeModel.desc;
		[cview.button setTitle:nativeModel.button forState:UIControlStateNormal];
		cview.starLable.text = [NSString stringWithFormat:@"%f",nativeModel.star];
		cview.logoImage.image = nativeModel.ADsignImage;
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];

```


#### AppWall advertisement View：
```
	//Custom UI
    CTCustomColor *customUI = [[CTCustomColor alloc]init];
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
    //First,you should call preloadAppWallWithSlotID method
    CTService *service = [CTService shareManager];
	[service preloadAppWallWithSlotID:@"260" customColor:customUI delegate:self isTest:YES success:^() {
        NSLog(@"Success");
    } failure:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    //Then,get appwall success ,show appwall and presentViewController
    [self presentViewController:[service showAppWallViewController] animated:YES completion:nil];  

```

#### Banner advertisement：
```
	CTService *service = [CTService shareManager];
	[service getBannerADswithSlotId:@"7" delegate:self frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100) needCloseButton:YES keyWords:nil isTest:NO success:^(UIView *bannerView) {
		//Requset successful,Add bannerView to parentView
	    [self.view addSubview:bannerView];
	} failure:^(NSError *error) {
		//Request failed
	    NSLog(@"No request to the advertising success：%@",error);
	}];

```

#### Interstitial advertisement：
```
	CTService *service = [CTService shareManager];
	[service preloadInterstitialWithSlotId:@"9" delegate:self isFullScreen:NO keyWords:nil isTest:YES success:^(UIView *InterstitialView) {
	    dispatch_async(dispatch_get_main_queue(), ^{
	    //Requset successful,Add InterstitialView to parentView
	        [self.view addSubview:InterstitialView];
	    //call the interstitialShow show ad view
	        [CTService interstitialShow];
	    });
	    /*
	     *if you use PresentVC style，you should use this method，but don't use [self.view addSubview:InterstitialView];
	    [service interstitialShowWithControllerStyle];
	     */
	} failure:^(NSError *error) {
		//Request failed
	    NSLog(@"No request to the advertising success：%@",error);
	}];

```

#### NaTemplateAD advertisement：
```
	CTService *service = [CTService shareManager];
	[service getNaTemplateADswithSlotId:@"8"  delegate:self frame:CGRectMake(60, 100, self.view.frame.size.width - 120, (self.view.frame.size.width - 120) / 1.9 + 40) needCloseButton:YES isTest:YES success:^(UIView *NaTemplateView)  {
		//Requset successful,Add NaTemplateView to parentView
	    [self.view addSubview:NaTemplateView];
	   } failure:^(NSError *error)
	   {
		//Request failed
	    NSLog(@"No request to the advertising success：%@",error);
	}]; 

```



###<a name="reference">How to apply Facebook/Admob advertisement：</a>：
* [Facebook Ad SDK Insert Description](https://developers.facebook.com/docs/audience-network)
* [Google Admob Ad SDK Insert Description](https://firebase.google.com/docs/ios/setup)


