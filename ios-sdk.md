
###index
* [SDK download and setup](#install)
* [SDK API reference](#api)
* [SDK error code table](#errorcode)
* [Sample code](#sample)
* [How to apply Facebook/Admob advertisement](#reference)


###<a name="install">SDK download and setup</a>
* According to the [How to apply Facebook/Admob advertisement](#reference) import relevant Framework , add a static link to: Build Settings -> Other Linker Flags -> $(OTHER_LDFLAGS) -ObjC.

		FBAudienceNetwork.framework
		FirebaseAnalytics.framework  
		FirebaseInstanceID.framework
		GoogleInterchangeUtilities.framework
	    GoogleSymbolUtilities.framework
		GoogleUtilities.framework
		Firebase.h
		GoogleService-Info.plist
		GoogleMobileAds.framework
		CTSDK.framework 

* In Build Phases -> Link Binary With Libraries -> add AdSupport.framework and libsqlite3.0.tbd 
* In Info.plist added the NSAppTransportSecurity, the type for Dictionary.
In NSAppTransportSecurity added the NSAllowsArbitraryLoads the Boolean,setting the YES
* Import the hearder file : #import &lt;CTSDK/CTService.h&gt;

###<a name="api">SDK API reference</a>：

```
 
    /**
     * Get Banner Ad View
     *
     * @param slot_Id -> Cloud Tech Banner AD ID
     * @param fb_id -> Facebook Native Placement ID
     * @param mob_id ->  Admob Banner AD ID
     * @param delegate -> Set Delegate of Ad event
     * @param frame -> Set Ad Frame
     * @param isNeedBtn -> show close button at the top-right corner of the advertisement
     * @param isTest -> Use test advertisement or not
     * @param success -> The request is successful Block, return Banner Ad View
     * @param failure -> The request failed Block, retuen error
     */
     
    +(void)getBannerADswithSlotId:(NSString*)slot_id
                         fbId:(NSString*)fb_id
                      admobId:(NSString*)mob_id
                     delegate:(id)delegate
                        frame:(CGRect)frame
              needCloseButton:(BOOL)isNeedBtn
                       isTest:(BOOL)isTest
                      success:(void (^)(UIView* bannerView))success
                      failure:(void (^)(NSError *error))failure;
 

    /**
     * Get Interstitial Ad View
     *
     * @param slot_Id -> Cloud Tech Intersitital AD ID
     * @param fb_id -> Facebook Native Placement ID
     * @param mob_id ->  Admob Interstitial AD ID
     * @param delegate -> Set Delegate of Ad event
     * @param frame -> Set Ad Frame
     * @param isNeedBtn -> show close button at the top-right corner of the advertisement
     * @param isTest -> Use test advertisement or not
     * @param success -> The request is successful Block, return Interstitial Ad View
     * @param failure -> The request failed Block, retuen error
     */
    +(void)preloadInterstitialWithSlotId:(NSString*)slot_id
                                fbId:(NSString*)fb_id
                             admobId:(NSString*)mob_id
                            delegate:(id)delegate
                              isTest:(BOOL)isTest
                             success:(void (^)(UIView* InterstitialView))success
                             failure:(void (^)(NSError *error))failure;

    /**
     * Show interstitial advertisement
     *
     * Request success, call this method show Ad View
     */
    +(BOOL)interstitialShow;

    /**
     * Close the interstitial advertisement
     *
     * call this method close Ad View
     */
	+(BOOL)interstitialClose;   


    /**
     * Get Native Ad View
     *
     * @param slot_Id -> Cloud Tech Native AD ID
     * @param fb_id -> Facebook Native Placement ID
     * @param mob_id ->  Admob Native AD ID
     * @param delegate -> Set Delegate of Ad event
     * @param frame -> Set Ad Frame
     * @param isNeedBtn -> show close button at the top-right corner of the advertisement
     * @param isTest -> Use test advertisement or not
     * @param success -> The request is successful Block, return Interstitial Ad View
     * @param failure -> The request failed Block, retuen error
     */
    +(void)getNativeADswithSlotId:(NSString*)slot_id
                         fbId:(NSString*)fb_id
                      admobId:(NSString*)mob_id
                     delegate:(id)delegate
                        frame:(CGRect)frame
              needCloseButton:(BOOL)isNeedBtn
                       isTest:(BOOL)isTest
                      success:(void (^)(UIView* NativeView))success
                      failure:(void (^)(NSError *error))failure;

    
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
    -(void)CTNativeDidClick:(CTNative*)native;

    /**
     * Advertisement landing page will show.
     */
    -(void)CTNativeDidIntoLandingPage:(CTNative*)native;

    /**
     * User left the advertisement landing page. 
     */
    -(void)CTNativeDidLeaveLandingPage:(CTNative*)native;

    /**
     * User close the advertisement.
     */
    -(void)CTNativeClosed:(CTNative*)native;

    /**
     * Leave App
     */
    -(void)CTNativeWillLeaveApplication:(CTNative*)native;

 
```

###### CTNativeDelegate Class Methods：Call back interface for the advertisement loading process.

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

#### Banner advertisement：
```
- (void)addBannerAd {
    [CTService getBannerADswithSlotId:@"7" fbId:@"119578928469786_119603761800636" admobId:@"ca-app-pub-4316706184733141/9204698312" delegate:self frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100) needCloseButton:YES isTest:NO success:^(UIView *NativeView) {
    //Requset successful,Add NativeView to parentView
        [self.view addSubview:NativeView];
    } failure:^(NSError *error) {
    //Request failed
        NSLog(@"No request to the advertising success：%@",error);
    }];
}

```

#### Interstitial advertisement：
```
- (void)addInterstitialAd{
    [CTService preloadInterstitialWithSlotId:@"9" fbId:@"119578928469786_141326032961742" admobId:@"ca-app-pub-4316706184733141/1681431517" delegate:self isTest:YES success:^(UIView *InterstitialView) {
        dispatch_async(dispatch_get_main_queue(), ^{
        //Requset successful,Add InterstitialView to parentView
            [self.view addSubview:InterstitialView];
        //call the interstitialShow show ad view
            [CTService interstitialShow];
        });
    } failure:^(NSError *error) {
    	//Request failed
        NSLog(@"No request to the advertising success：%@",error);
    }];
}

```

#### Native advertisement：
```
    [CTService getNativeADswithSlotId:@"8" fbId:@"119578928469786_119603761800636" admobId:@"ca-app-pub-2095463017322759/8628270629" delegate:self frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300) needCloseButton:NO isTest:YES success:^(UIView *NativeView) {
    	//Requset successful,Add NativeView to parentView
            [cell addSubview:NativeView];
        } failure:^(NSError *error)
        {
		//Request failed
        NSLog(@"No request to the advertising success：%@",error);
     }]; 

```

###<a name="reference">How to apply Facebook/Admob advertisement：</a>：
* [Facebook Ad SDK Insert Description](https://developers.facebook.com/docs/audience-network)
* [Google Admob Ad SDK Insert Description](https://firebase.google.com/docs/ios/setup)
