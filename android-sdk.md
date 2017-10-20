* [Getting Started with AS](#start)
* [Integration Notes](#integration)
* [Native](#native)
    * [Element-Native](#common)
    * [Element-Native with imagePreload](#preload)
    * [Element-Native with adCache](#cache)
    * [Element-Native with keywords](#keywords)
    * [Element-Native for Multiple](#multi)
    * [Template-Native](#template)
* [Banner](#banner)
* [Interstitial](#interstitial)
* [Appwall](#appwall)
* [Basic Ad Mediation (Banner-Interstitial-Native)](#basic)
    * [facebook](#facebook)
    * [admob](#admob)
* [Reward Video](#reward)
* [Reward Video Mediation](#mediation)   
    * [applovin](#applovin)
    * [vungle](#vungle)
    * [unityads](#unityads)
    * [tapjoy](#tapjoy)
    * [adcolony](#adcolony)
* [Error Code For SDK](#error)
* [Release Notes](#release)
* [Getting Started with eclipse](#eclipse)

## <a name="start">Getting Started with AS</a>

* [Download the SDK](https://github.com/cloudmobi/CloudmobiSSP/raw/master/AndroidSDK.zip)
* Build tool：Gradle
* Select API 14: Android 4.0 or later.
* Add the Cloudssp SDK to your Project：

	| jar name           		    | jar function           | require(Y/N) |
	| ------------------ 		    | --------------------   | --------     |
	| cloudssp_xx.jar    		| basic functions(banner\interstitial\native ads)| Y|
	| cloudssp_imageloader_xx.jar | imageloader functions  |     N        |
	| cloudssp_appwall_xx.jar     | appwall ads functions      |     N        |
	| cloudssp_videoads_xx.jar    | video ads functions    |     N        |
	| cloudssp_mediation_xx.jar   | Rewarded Video Mediation |     N       | 

* Update the module's build.gradle for basic functions：

``` groovy
dependencies {
    compile files('libs/cloudssp_xx.jar')
}
```

* Update AndroidManifest.xml as below:

``` xml
<!--Necessary Permissions-->
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!--Optional Permissions-->
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>


   <!--Necessary-->
   <activity android:name="com.cloudtech.ads.view.InnerWebLandingActivity"
       android:launchMode="singleInstance">
       <intent-filter>
           <action android:name="com.cloudtech.action.InnerWebLanding" />
           <category android:name="android.intent.category.DEFAULT" />
       </intent-filter>
   </activity>
   
   <service
       android:name="com.cloudtech.ads.core.AdGuardService"
       android:permission="android.permission.BIND_JOB_SERVICE"/>

```


* **Init the SDK**

    You can init the SDK in your application as detailed below:

```java
   CTService.init(context, "one of your slotId");
```
 

*  **For ProGuard Users**

    If you are using ProGuard with the Cloudmobi SDK, you must add the following code to your ProGuard file:
    
``` java
    #for sdk
    -keep public class com.cloudtech.**{*;}
    -dontwarn com.cloudtech.**

    #for gaid
    -keep class **.AdvertisingIdClient$** { *; }

    #for js and webview interface
    -keepclassmembers class * {
        @android.webkit.JavascriptInterface <methods>;
    }

    #for not group facebook/admob ads
    -dontwarn com.google.android.**
    -dontwarn com.facebook.ads.**
```


## <a name="integration">Integration Notes</a>

* Two permises are need for Cloudmobi ads.
    
    1. **GooglePlay** is installed on your mobile.
    2. **VPN** is needed for ads.
    
* About the CTAdEventListerner.
   We suggest you define a class to implement the CTAdEventListener yourself , then you can just override the methods you need when you getBanner or getNative. just as follows:

``` java
public class MyCTAdEventListener implements CTAdEventListener {

    	@Override
    	public void onAdviewGotAdSucceed(CTNative result) {
        	showMsg("onAdviewGotAdSucceed");
    	}
    	
    	@Override
        public void onAdsVoGotAdSucceed(AdsNativeVO result) {
            showMsg("onAdsVoGotAdSucceed");
        }

    	@Override
    	public void onInterstitialLoadSucceed(CTNative result) {
        	showMsg("onInterstitialLoadSucceed");
    	}

	    @Override
    	public void onAdviewGotAdFail(CTNative result) {
       		showMsg(result.getErrorsMsg());
       		Log.i("sdksample", "errorMsg:" + result.getErrorsMsg());
    	}

	    @Override
    	public void onAdviewIntoLandpage(CTNative result) {
        	showMsg("onAdviewIntoLandpage");
    	}

    	@Override
    	public void onStartLandingPageFail(CTNative result) {
        	showMsg("onStartLandingPageFail");
    	}

    	@Override
    	public void onAdviewDismissedLandpage(CTNative result) {
        	showMsg("onAdviewDismissedLandpage");
    	}

    	@Override
    	public void onAdviewClicked(CTNative result) {
        	showMsg("onAdviewClicked");
    	}

    	@Override
    	public void onAdviewClosed(CTNative result) {
        	showMsg("onAdviewClosed");
    	}

	    @Override
    	public void onAdviewDestroyed(CTNative result) {
        	showMsg("onAdviewDestroyed");
    	}


    	private void showMsg(String msg){
        	Toast.makeText(context, msg, Toast.LENGTH_SHORT).show();
    	}
	}

```


## <a name="native">Native Ads Integration</a>

### <a name="common">Single elements-Native ads interface</a>

* The container and the layout for elements-Native ad:

```java
    ViewGroup container = (ViewGroup) view.findViewById(R.id.container);
    ViewGroup adLayout = (ViewGroup)View.inflate(context,R.layout.native_layout, null);
```

* The method to load elements-Native Ads:

``` java

    /**
     * @param slotId     cloudmobi id
     * @param context    context
     * @param imageType  the rate of image(1.9:1 or 1:1) 
     * @param adListener callback listener 
     * @return 
     */
 	CTService.getAdvanceNative("your slotid",context,
 	          CTImageRatioType.RATIO_19_TO_10,new MyCTAdEventListener(){
                  @Override
                  public void onAdviewGotAdSucceed(CTNative result) {
                      if (result == null){
                          return;
                      }
                      CTAdvanceNative ctAdvanceNative = (CTAdvanceNative) result;
                      showAd(ctAdvanceNative);
                      super.onAdviewGotAdSucceed(result);
                  }
        });
```

* Show the elements-Native ads

``` java
    private void showAd(CTAdvanceNative ctAdvanceNative) {
        ImageView img = (ImageView) adLayout.findViewById(R.id.iv_img);
        ImageView icon = (ImageView) adLayout.findViewById(R.id.iv_icon);
        TextView title = (TextView)adLayout.findViewById(R.id.tv_title);
        TextView desc = (TextView)adLayout.findViewById(R.id.tv_desc);
        Button click = (Button)adLayout.findViewById(R.id.bt_click);
        ImageView adChoice = (ImageView)adLayout.findViewById(R.id.choice_icon);
        
        //show the image and icon yourself 
        String imageUrl = ctAdvanceNative.getImageUrl();
        String iconUrl = ctAdvanceNative.getIconUrl();          
        title.setText(ctAdvanceNative.getTitle());
        desc.setText(ctAdvanceNative.getDesc());
        click.setText(ctAdvanceNative.getButtonStr());
        adChoice.setImageURI(ctAdvanceNative.getAdChoiceIconUrl());

        //Optional 1: add your view into ctAdvanceNative，and add the ctAdvanceNative into your container.
        ctAdvanceNative.addADLayoutToADContainer(adLayout);
        container.addView(ctAdvanceNative);
        
        //Optional 2：just register the click for your view, add your view into your container.
        ctAdvanceNative.registeADClickArea(adLayout);
        container.addView(adLayout); 
   }
   
```

### <a name="preload">Single elements-Native ads interface for imageProload</a>

``` java 
        
    // Update the module's build.gradle
    dependencies {
        compile files('libs/cloudssp_xx.jar')       
        compile files('libs/cloudssp_imageloader_xx.jar')   // for preload image
    }   

    //load ads
    /**
     * @param slotId        cloudmobi id
     * @param context       context
     * @param imageType     the rate of image(1.9:1 or 1:1)
     * @param autoLoadImage is image preload 
     * @param adListener    callback listener
     * @return
     */
    CTService.getAdvanceNative("your slotid", context,
            CTImageRatioType.RATIO_19_TO_10, true, new MyCTAdEventListener() {
                @Override
                public void onAdviewGotAdSucceed(CTNative result) {
                    if (result == null) {
                        return;
                    }
                    CTAdvanceNative ctAdvanceNative = (CTAdvanceNative) result;
                    showAd(ctAdvanceNative);
                    super.onAdviewGotAdSucceed(result);
                }
            });
            
    //show ads
    private void showAd(CTAdvanceNative ctAdvanceNative) {
        ImageView img = (ImageView) adLayout.findViewById(R.id.iv_img);
        ImageView icon = (ImageView) adLayout.findViewById(R.id.iv_icon);
        TextView title = (TextView)adLayout.findViewById(R.id.tv_title);
        TextView desc = (TextView)adLayout.findViewById(R.id.tv_desc);
        Button click = (Button)adLayout.findViewById(R.id.bt_click);
        ImageView adChoice = (ImageView)adLayout.findViewById(R.id.choice_icon);
        
        //show the preload image and icon through sdk api 
        ctAdvanceNative.setIconImage(icon);
        ctAdvanceNative.setLargeImage(img);
        title.setText(ctAdvanceNative.getTitle());
        desc.setText(ctAdvanceNative.getDesc());
        click.setText(ctAdvanceNative.getButtonStr());
        adChoice.setImageURI(ctAdvanceNative.getAdChoiceIconUrl());

        //Optional 1: 
        ctAdvanceNative.addADLayoutToADContainer(adLayout);
        container.addView(ctAdvanceNative);
        
        //Optional 2：
        ctAdvanceNative.registeADClickArea(adLayout);
        container.addView(adLayout); 
   }
   
```

### <a name="cache">Single elements-Native ads interface for AdCache</a>

* get Ads for cache

```java
        
    /**
     * @param slotId     cloudmobi id
     * @param context    context
     * @param imageType  the rate of image(1.9:1 or 1:1)
     * @param adListener callback listener 
     * @return
     */
    CTService.getAdvanceNativeForCache("your slotid",context,
            CTImageRatioType.RATIO_19_TO_10, new MyCTAdEventListener() {
                @Override
                public void onAdsVoGotAdSucceed(AdsNativeVO result) {
                    if (result == null) {
                        return;
                    }
                    AdsNativeVO adNativeVO = result;
                    super.onAdsVoGotAdSucceed(result);
                }
            });

```

* show ads from cache

```java
      
      CTAdvanceNative ctAdvanceNative = new CTAdvanceNative(getContext());

      AdsNativeVO nativeVO = adNativeVO;

       if (nativeVO != null) {
           ctAdvanceNative.setNativeVO(nativeVO);
    
           ctAdvanceNative.setSecondAdEventListener(new MyCTAdEventListener(){
               @Override
               public void onAdviewClicked(CTNative result) {
                   super.onAdviewClicked(result);
               }
           });
           
           showAd(ctAdvanceNative);
       }

```
 


### <a name="keywords">Single elements-Native ads interface for keywords</a>

``` java

    List<String> keywords = new ArrayList<>();
    keywords.add("tools");
    keywords.add("games");

    /**
     * @param slotId     cloudmobi id
     * @param context    context
     * @param imageType  the rate of image(1.9:1 or 1:1)
     * @param adsCat     the type of ads 
     * @param keywords   the keywords for ads
     * @param adListener callback listener 
     * @return
     */
    CTService.getAdvanceNativeByKeywords("your slotid", context,
    		 CTImageRatioType.RATIO_19_TO_10, CTAdsCat.TYPE_TOOL, keywords,
    		 	new MyCTAdEventListener(){
               @Override
               public void onAdviewGotAdSucceed(CTNative result) {
                   if (result == null){
                       return;
                   }

                   CTAdvanceNative ctAdvanceNative = (CTAdvanceNative) result;
                   showAd(ctAdvanceNative);
                   super.onAdviewGotAdSucceed(result);

               }
            });
```

### <a name="multi">Multi elements-Native ads interface</a>

* The method to load multi Native ads

``` java

    /**
     * @param reqAdNumber request ads num
     * @param slotId      cloudmobi id
     * @param context     context
     * @param imageType   the rate of image(1.9:1 or 1:1)
     * @param adListener  callback listener 
     * @return
     */
	CTService.getMultiNativeAds(required_num, "your slotid",context,
	   CTImageRatioType.RATIO_19_TO_10,new MultiAdsEventListener() {
            public void onMultiNativeAdsSuccessful(List<CTAdvanceNative> res) {
                //use the List<CTAdvanceNative> in listview or recycleview
            }

            @Override
            public void onAdviewGotAdFail(CTNative result) {

            }
        });
```

### <a name="template">Template-Native ads interface</a>

* The method to load templat-Native Ads:(the template is set up in ssp.)

``` java
	ViewGroup container = (ViewGroup) view.findViewById(R.id.container);

    /**
     * @param slotId            cloudmobi id
     * @param isShowCloseButton close button switch 
     * @param context           context
     * @param adListener        callback listener 
     * @return
     */
 	CTService.getNative("your slotid", false, context,
                new MyCTAdEventListener(){
                    @Override
                    public void onAdviewGotAdSucceed(CTNative result) {
                        if (result != null) {
                            container.removeAllViews();
                            container.addView(result);
                        }
                        super.onAdviewGotAdSucceed(result);
                    }
                });
                
```

## <a name="banner">Banner Ads Integration</a>

* The method to load Banner Ads:

``` java
	ViewGroup container = (ViewGroup) view.findViewById(R.id.container);

    /**
     * @param slotId            cloudmobi id
     * @param isShowCloseButton close button switch 
     * @param context           context
     * @param adListener        callback listener 
     * @return
     */
  	CTService.getBanner("your slotid", false, context,
  	 		new MyCTAdEventListener(){

                    @Override
                    public void onAdviewGotAdSucceed(CTNative result) {
                        if (result != null){
                            container.removeAllViews();
                            container.addView(result);
                        }
                        super.onAdviewGotAdSucceed(result);
                    }

                    @Override
                    public void onAdviewGotAdFail(CTNative result) {
                        super.onAdviewGotAdFail(result);
                    }

                    @Override
                    public void onAdviewClicked(CTNative result) {
                        super.onAdviewClicked(result);
                    }

                    @Override
                    public void onAdviewClosed(CTNative result) {
                        container.removeAllViews();
                        super.onAdviewClosed(result);
                    }
                });
```

## <a name="interstitial">Interstitial Ads Integration</a>

* update AndroidManifest.xml for Interstitial Ads

 ``` xml
        <activity
            android:name="com.cloudtech.ads.view.InterstitialActivity"
            android:launchMode="singleInstance"
            android:screenOrientation="portrait"
            android:multiprocess="true">
        </activity>
        
        the multiprocess attribute is optional.
 ```

* The method to show Interstitial Ads

``` java

    /**
     * @param slotId            cloudmobi id
     * @param isShowCloseButton close button switch 
     * @param isFullScreen      full screen switch 
     * @param context           context
     * @param adListener        callback listener 
     * @return
     */
   CTService.preloadInterstitial("your slotid",true,false,context,
    		  new MyCTAdEventListener(){
                   @Override
                   public void onInterstitialLoadSucceed(CTNative result) {
                       super.onInterstitialLoadSucceed(result);
                   }
    
                   @Override
                   public void onAdviewGotAdSucceed(CTNative result){
                    	if (result != null && result.isLoaded()){
                           CTService.showInterstitial(result);
                       }
                       super.onAdviewGotAdSucceed(result);
                   }
    
                   @Override
                   public void onAdviewClosed(CTNative result) {
                       super.onAdviewClosed(result);
                   }

            });
                
```

## <a name="appwall">Appwall integration</a>

* Update the module's build.gradle for Appwall：

``` groovy
	dependencies {
        compile files('libs/cloudssp_xx.jar')
        compile files('libs/cloudssp_appwall_xx.jar')       // for appwall        
        compile files('libs/cloudssp_imageloader_xx.jar')   // imageloader for appwall
	}

```

* Update the AndroidManifest.xml for Appwall

``` xml
	 <activity
        android:name="com.cloudtech.appwall.AppwallActivity"
        android:launchMode="singleInstance"
        android:screenOrientation="portrait"
        android:multiprocess="true"/>
        
        the multiprocess attribute is optional.
```

* Preload appwall

    It‘s better to preload ads for Appwall before show it. 
    
``` java

    AppwallHelper.init(context, "your slotid");
```

* Customize the appwall color theme(optional).

``` java
    CustomizeColor custimozeColor = new CustomizeColor();
    custimozeColor.setMainThemeColor(Color.parseColor("#ff0000ff"));
    AppwallHelper.setThemeColor(custimozeColor);
```

* Show Appwall.

``` java
    AppwallHelper.showAppwall(context, "your slotid");
```

## <a name="basic">Basic Ad Mediation</a> [Banner-Interstitial-Native]

### <a name="facebook">Facebook</a>

* [Facebook advertisement](https://developers.facebook.com/docs/audience-network)
* Set up the facebook placementId in Cloudmobi platform.
* Update the module's build.gradle as below:

``` groovy
	dependencies {
    	compile 'com.facebook.android:audience-network-sdk:4.23.0'
	}
```

### <a name="admob">Google Admob</a>

* [Google Admob advertisement](https://firebase.google.com/docs/admob/android/quick-start)
* Set up the admob unitId in Cloudmobi platform.
* Update the module's build.gradle ad bolow:

``` groovy
	dependencies {
    	compile 'com.google.firebase:firebase-ads:9.0.2'
	}
```

* Update AndroidManifest.xml for admob ads:

```xml
    <meta-data
        android:name="com.google.android.gms.version"
        android:value="@integer/google_play_services_version" />
    
    <activity 
        android:name="com.google.android.gms.ads.AdActivity"
        android:configChanges="keyboard|keyboardHidden|orientation|
            screenLayout|uiMode|screenSize|smallestScreenSize"
        android:theme="@android:style/Theme.Translucent" />
```

## <a name="reward">Reward Video Ad Integration</a>

* **Google Play Services**

    1、Google Advertising ID
    
    The RewardVideo requires access to the Google Advertising ID in order to operate properly. See this guide on how to integrate [Google Play Services](https://developers.google.com/android/guides/setup).
    
    2、Google Play Services in Your Android Manifest

    Add the following  inside the <application> tag in your AndroidManifest:
    
    ```
    <meta-data android:name="com.google.android.gms.version"
              android:value="@integer/google_play_services_version" />
    ```
    
    3、If you have integrated the admob-sdk for basic ads, it's not necessary to do this.


* Update the module's build.gradle for Reward Video：

``` groovy
	dependencies {
        compile files('libs/cloudssp_xx.jar')
        compile files('libs/cloudssp_videoads_xx.jar')
        compile files('libs/cloudssp_imageloader_xx.jar')
        compile files('libs/cloudssp_mediation_xx.jar')
	}
```

* Update the AndroidManifest.xml for Reward Video:

``` xml    
    <activity 
        android:name="com.cloudtech.videoads.api.CTInterstitialActivity"
        android:screenOrientation="landscape"
        android:launchMode="singleInstance"/>

```

* Set the listener for Reward Video

    Implement the Rewarded Video Listener, and the SDK will notify your listener of all possible events listed below:

```java
    CloudmobiSDK.setRewardedVideoListener(new RewardedVideoListener() {
            /**
             * Invoked when the RewardedVideo ad view has opened.
             */
            @Override
            public void onRewardedVideoAdOpened() {
            }

            /*
             *Invoked when the RewardedVideo ad view is about to be closed.
             */
            @Override
            public void onRewardedVideoAdClosed() {
            }
            
            /**
             * Invoked when there is a change in the ad availability status.
             *
             * @param - available 
             *   - value will change to true when rewarded videos are *available.
             *   - Value will change to false when no videos are available.
             * You can then show the video by calling showRewardedVideo().
             */
            @Override
            public void onRewardedVideoAvailabilityChanged(boolean isAvailable) {
            }

            /**
             * Invoked when the video ad starts playing.
             */
            @Override
            public void onRewardedVideoAdStarted() {
            }

            /*
             *Invoked when the video ad finishes playing.
             */
            @Override
            public void onRewardedVideoAdEnded() {
            }

            /**
             * Invoked when the user completed the video and should be rewarded.
             *
             * @param - placement - the Placement the user completed a video from.
             */
            @Override
            public void onRewardedVideoAdRewarded(Reward reward) {
                /** here you can reward the user according to the given amount.
                String rewardName = reward.getRewardName();
                int rewardAmount = reward.getRewardAmount();
                */
            }

            /* 
             * Invoked when RewardedVideo call to show a rewarded video has failed
             * CloudmobiError contains the reason for the failure.
             */
            @Override
            public void onRewardedVideoAdShowFailed(CloudmobiError error) {
            }
        });
    
```

* Set UserID to Verify AdRewarded Transactions(Optional)

    This parameter helps verify AdRewarded transactions and must be set before calling initRewardVideo.

```java
    CloudmobiSDK.setUserId("userID");
```

* Preload the Reward Video

    It‘s better to preload ads for Reward Video before show it. 
    
``` java

    CloudmobiSDK.initRewardVideo(activity);
```

* Show Reward Video to Your Users

By implementing the RewardedVideoListener, you can receive the availability status through the onVideoAvailabilityChanged callback.
    
```java
    public void onVideoAvailabilityChanged(boolean available)
```

Alternatively, ask for ad availability directly by calling:

```java
    boolean available = CloudmobiSDK.isRewardedVideoAvailable(slotId);;
```

Once you get an available Reward Video, you are ready to show this video ad to your users by calling the showRewardedVideo() method like following:

```java
    CloudmobiSDK.showRewardedVideo(slotId);
```
    
*  Reward the User

The Cloudmobi SDK will fire the onRewardedVideoAdRewarded event each time the user successfully completes a video. The RewardedVideoListener will be in place to receive this event so you can reward the user successfully.

The Reward object contains both the Reward Name & Reward Amount of the SlotId as defined in your Cloudmobi ssp:


```java
    public void onRewardedVideoAdRewarded(Reward reward) {
        //TODO - here you can reward the user according to the given amount
        String rewardName = reward.getRewardName();
        int rewardAmount = reward.getRewardAmount();
    }
    
```

## <a name="mediation">Reward Video Ad Mediation</a>

Before You Start

1. Make sure you have correctly integrated Cloudmobi's Rewarded Video into your application. 
2. You shoud configure the following platform's Parameters(appId\placementName) into Cloudmoni platform.

### <a name="applovin">applovin</a>

* [applovin-7.3.2](https://www.applovin.com/integration#androidIntegration)
    
* Add the Applovin-SDK to Your Build
        
   ```groovy
       dependencies {
           compile files('libs/applovin-sdk-7.3.2.jar')
       }
   ```
        
* Update AndroidManifest.xml
    
   ```xml
   Manifest Permissions:
   <uses-permission android:name="android.permission.INTERNET"/>
   <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"       
                    android:maxSdkVersion="18" />
   <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />


   Manifest activities:
   <activity
       android:name="com.applovin.adview.AppLovinInterstitialActivity"/>
   <activity
       android:name="com.applovin.adview.AppLovinConfirmationActivity"/>
   
   for SDK versions >= 6.4.0  add the configChanges for better performance:
   <activity 
       android:name="com.applovin.adview.AppLovinInterstitialActivity"         
       android:configChanges="orientation|screenSize"/>
   <activity 
       android:name="com.applovin.adview.AppLovinConfirmationActivity" 
       android:configChanges="orientation|screenSize"/>
   ```
    
* For Proguard Users Only
    
    ```
   #applovin
   -keep class com.applovin.sdk.**{
       *;
   }
    ```

### <a name="vungle">vungle</a>

* [vungle-5.1.0](https://dashboard.vungle.com/sdk)

* Add the Vungle-SDK to Your Build：
            
    ```groovy
    Via Gradle:
    Open the project-level build.gradle, and add maven URL in the all project section.
       allprojects {
          repositories {
              maven {
                  url 'https://jitpack.io'
              }
          }
       }
       
    Open the app-level build.gradle file for your app, and add compile dependencies in the dependencies section.
    
        dependencies {
        	   compile 'com.github.vungle:vungle-android-sdk:5.1.0'
        }
    
    
    Via ohters:
    Download Vungle SDK, copy all the jars and add it to your project library.
    Open the project-level build.gradle, and update the repositories section.
    
        allprojects {
            repositories {
                jcenter()
            }
        }
        
    Open the app-level build.gradle file for your app, and add other dependencies in dependencies section. 

        dependencies {
            compile files('libs/dagger-2.7.jar')
            compile files('libs/javax.inject-1.jar')
            compile files('libs/eventbus-2.2.1.jar')
            compile files('libs/publisher-sdk-android-5.1.0.jar')
            compile files('libs/rxjava-1.2.0.jar')
        }
    
    ``` 
       
        
* Update AndroidManifest.xml

    ```xml    
    Manifest Permissions：
    <uses-permission 
        android:name="android.permission.WRITE_EXTERNAL_STORAGE"        
        android:maxSdkVersion="18"/>
    <uses-permission
        android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    
    Manifest Activities:
    <activity 
        android:name="com.vungle.publisher.VideoFullScreenAdActivity"
        android:configChanges="keyboardHidden|orientation|screenSize|screenLayout|smallestScreenSize"
        android:theme="@android:style/Theme.NoTitleBar.Fullscreen"/>
    <activity 
        android:name="com.vungle.publisher.MraidFullScreenAdActivity"
        android:configChanges="keyboardHidden|orientation|screenSize|screenLayout|smallestScreenSize"
        android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen"/>
    <activity 
        android:name="com.vungle.publisher.FlexViewAdActivity"          
        android:configChanges="keyboardHidden|orientation|screenSize|screenLayout|smallestScreenSize"
        android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen"/>

    ```

* For Proguard Users Only

    ```
        # Vungle
        -dontwarn com.vungle.**
        -dontnote com.vungle.**
        -keep class com.vungle.** { *; }
        -keep class javax.inject.*
        
        # GreenRobot
        -dontwarn de.greenrobot.event.util.**
        
        # RxJava
        -dontwarn rx.internal.util.unsafe.**
        -keepclassmembers class rx.internal.util.unsafe.*ArrayQueue*Field* {
           long producerIndex;
           long consumerIndex;
        }
        -keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueProducerNodeRef {
           rx.internal.util.atomic.LinkedQueueNode producerNode;
        }
        -keepclassmembers class rx.internal.util.unsafe.BaseLinkedQueueConsumerNodeRef {
           rx.internal.util.atomic.LinkedQueueNode consumerNode;
        }
        -keep class rx.schedulers.Schedulers { public static <methods>; }
        -keep class rx.schedulers.ImmediateScheduler { public <methods>; }
        -keep class rx.schedulers.TestScheduler { public <methods>; }
        -keep class rx.schedulers.Schedulers { public static ** test(); }
        
        # MOAT
        -dontwarn com.moat.**
        -keep class com.moat.** {
           public protected private *;
        }
    
    ```


### <a name="unityads">unityads</a>

* [Unityads-2.1.1](https://github.com/Unity-Technologies/unity-ads-android/releases)

* Integrate Unity Ads with Android Studio:

    ```
    Download the unity-ads.aar, copy the aar and add it to your project library.
    Open the project-level build.gradle, update the repositories section.               
        
        repositories {
            flatDir {
                dirs 'libs'
            }
        }
        
    Open the app-level build.gradle file for your app, and add the dependencies in dependencies section.
        
        dependencies {
            compile(name: 'unity-ads', ext: 'aar')
        }
    
    This is all what you should do for integration unity-ads.
        
    ```


* Integrating without Android Studio
   
    If you can't use the AAR packages with your build system, you can do as this:
    
    1、 Download the  unity-ads.zip, and include classes.jar in your build;
    2、 update the AndroidManifest.xml
    
    ```xml
    Manifest Permissions：  
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
        <uses-permission android:name="android.permission.INTERNET" />
    
    
    Manifest Activities:
        <activity
            android:name="com.unity3d.ads.adunit.AdUnitActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="true"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />
    
        <activity
            android:name="com.unity3d.ads.adunit.AdUnitSoftwareActivity"
            android:configChanges="fontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen"
            android:hardwareAccelerated="false"
            android:theme="@android:style/Theme.NoTitleBar.Fullscreen" />

    ```
    
    3、 For Proguard Users Only
    
    ```
        # Keep filenames and line numbers for stack traces
        -keepattributes SourceFile,LineNumberTable
        
        # Keep JavascriptInterface for WebView bridge
        -keepattributes JavascriptInterface
        
        # Sometimes keepattributes is not enough to keep annotations
        -keep class android.webkit.JavascriptInterface {
           *;
        }
        
        # Keep all classes in Unity Ads package
        -keep class com.unity3d.ads.** {
           *;
        }
    ```

### <a name="tapjoy">tapjoy</a>

* [tapjoy-11.11.0](https://ltv.tapjoy.com/s/59ae541e-2d18-8000-8000-72469900001d/onboarding#guide/basic?os=android)

* Add the Applovin-SDK to Your Build：
    
```groovy
    dependencies { 
        compile files('libs/tapjoyconnectlibrary.jar') 
    }
```

* Update AndroidManifest.xml

```xml
Manifest Permissions
    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
    

Manifest Activities
    <activity
        android:name="com.tapjoy.TJAdUnitActivity"
        android:configChanges="orientation|keyboardHidden|screenSize"
        android:hardwareAccelerated="true"
        android:theme="@android:style/Theme.Translucent.NoTitleBar.Fullscreen" />
    <activity
        android:name="com.tapjoy.mraid.view.ActionHandler"
        android:configChanges="orientation|keyboardHidden|screenSize" />
    <activity
        android:name="com.tapjoy.mraid.view.Browser"
        android:configChanges="orientation|keyboardHidden|screenSize" />
    <activity
        android:name="com.tapjoy.TJContentActivity"
        android:configChanges="orientation|keyboardHidden|screenSize"
        android:theme="@android:style/Theme.Translucent.NoTitleBar"
        android:hardwareAccelerated="true" />
```


### <a name="adcolony">adcolony</a>

* [adcolony-3.2.1](https://github.com/AdColony/AdColony-Android-SDK-3/wiki/Project-Setup)

* Add the Adcolony-SDK to Your Build:
    
```xml
Via Gradle:

    Add the following Maven configuration to your build.gradle file that contains your application's or module's 'repositories' configuration block:
    
    repositories {
        maven {
          url  "https://adcolony.bintray.com/AdColony"      
        }
    }
    
    Add the following lines to your 'dependencies' configuration within your module's build.gradle:
    
    dependencies {
        compile 'com.adcolony:sdk:3.2.1'
    }
    
  
    
Via others:
    
    Download our SDK distribution. 
    Place adcolony.jar into your project's "libs" folder.
    Place the armeabi, armeabi-v7a, arm64-v8a, x86_64, and x86 folders into your    
project's "libs" folder as necessary. 
    Add the following to your module's build.gradle under 'dependencies':

        dependencies {
          compile fileTree(dir: 'libs', include: ['*.jar'])
        }
        
    And the following in your module's build.gradle under 'android':

        android {
          sourceSets {
            main {
              jniLibs.srcDirs = ['libs']
            }
          }
        }
```

* Update AndroidManifest.xml
    
    ```xml
    Manifest Permissions
        <uses-permission android:name="android.permission.INTERNET" />
        <uses-permission        
            android:name="android.permission.WRITE_EXTERNAL_STORAGE" /> 
        <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" /> 


    Manifest Activities
        <activity 
            android:name="com.adcolony.sdk.AdColonyInterstitialActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:hardwareAccelerated="true"/>
        <activity 
            android:name="com.adcolony.sdk.AdColonyAdViewActivity"
            android:configChanges="keyboardHidden|orientation|screenSize"
            android:hardwareAccelerated="true"/>
    
    ```

* For ProGuard Users Only 

    ```
    # For communication with AdColony's WebView
    -keepclassmembers class * { 
        @android.webkit.JavascriptInterface <methods>; 
    }
    
    # Keep ADCNative class members unobfuscated
    -keepclassmembers class com.adcolony.sdk.ADCNative** {
        *;
     }
  
    -keep class com.adcolony.sdk.**{
        *;
     }
    ```


## <a name="error">Error Code For SDK</a>

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
| ERR\_010\_APK_DOWNLOAD_URL     | Application package download failed            |
| ERR\_011\_APK_INSTALL     | Application install failed                |
| ERR\_012\_VIDEO_LOAD     | Load the video exception              |
| ERR\_013\_PAGE_LOAD     | Load the html5 page failed               |
| ERR\_014\_JAR_UPDATE_VERSION     | Check the update jar failed        |
| ERR\_015\_GET_GAID     | Cannot get google advertisement id failed |
| ERR\_016\_GET_AD_CONFIG     | Cannot get the account configuration or template |
| ERR\_017\_INTERSTITIAL_SHOW_NO_AD     | Try to load the interstitial advertisement, but the advertisement is not ready  |
| ERR\_018\_AD_CLOSED  |Ad slotId has been closed|
| ERR\_999\_OTHERS     | All other errors  |


## <a name="release">Release Notes</a>

*  Version 1.4.0  [release date: 2017-02-21]

    1. Use the new Ad server address.
    2. Add a new api in CTAdvanceNative for unregister click area.

* Version 1.4.6 [release data: 2017-03-08]
    
    1. Admob advance native ads don't send impressions.
    2. Fix a accidental crash bug when android api version is 4.0.4.
    3. Appwall don't load ads, when use the appwall function only.

* Version 1.4.8 [release data: 2017-03-17]

    1. Feature: add the video ads module
    2. Feature: video ads support reward video ad

* Version 1.5.0 [release data: 2017-03-30]

    1. Fix bug: do a workaround for Oppo phone's crash.
    2. Fix bug: resolve the bug about ConcurrentModification.
    3. Feature: Update impression logic.
    4. Feature: Add animation support when show app wall. 

* Version 1.6.0 [release data: 2017-05-05]

    1. Upgrade video ad with cache feature.
    2. Support more vast track events.
    3. Interstitisl-ads support two sizes: fullscreen\notfullscreen
    4. Fix bug: the template can be null for advanceNative slotid.

* Version 1.6.5 [release data: 2017-05-15]

    1. support facebook-audience-network 4.22.0
    2. Fix bug: Reward Video continue play when back from background.

* Version 1.6.6 [release data: 2017-05-17]

    1. Fix two bugs for reward video
    2. update the eclpise sample

* Version 1.6.7 [release data: 2017-05-24]

    1. add preload image cache for Advance Native Ad

* Version 1.7.0 [release data: 2017-06-02]

    1. update layout for reward video finish

* Version 1.7.2 [release data: 2017-06-20]

    1. Fix bugs: Reward video progress bar.
    2. Fix bugs: not show dialog after Reward video finished.

* Version 1.7.3 [release data:2017-07-03]

    1. Support cache the ads by getAdvanceNativeFroCache()
    2. Provide adapter for Mopub with Cloudmobi sdk.

* Version 1.7.6 [relase data:2017-07-25]

    1. Optimize multithreading issues;
    2. Support multiple processes;
    3. Optimize templates and configuration request;
    4. Optimize ContextHolder,TrackUtil,Utils and so on
    5. Fix the occasional crash when request on android 4;
    6. Fix the problem when video restore from minimization;
    7. Fix bug: Gridview first Item not work in appwall;
    8. Fix bug: the interface for proladImage stop when load facebook ads.

* Version 2.0.0 [release data:2017-09-22]

    1. Optimize the base function jar
    2. public the Reward Video mediation function jar
    
* Version 2.0.2 [release data:2017-09-28]

    1. Fix bug: Thread Pool Exception

* Version 2.0.3 [release data:2017-10-10]
    
    1. Fix bug: compatible the template request url version
    2. upload log of RewardVideo Mediation for important node
    3. remove the facebook/admob error msg for not group facebook/admob ads
    
## <a name="eclipse">Getting Started with eclipse</a>

* [Download the SDK](https://github.com/cloudmobi/CloudmobiSSP/raw/master/AndroidSDK.zip)
* Build tool：Ant
* Add the Cloudssp SDK into target project folder /libs/ , and Add them to build path.
* If you need group facebook/admob ads by Cloudssp SDK, you should add the related dependence in your project and add the corresponding id.

 ```java 
    //for basic sdk
    cloudssp_xx.jar
    
    //for imageloader
    cloudssp_imageloader_xx.jar
    
    //for appwall
    cloudssp_appwall_xx.jar
 
 	  //for facebook ads
	   AudienceNetwork.jar

	   //for admob ads
	   google-play-services-ads-lite.jar
	   google-play-services-basement.jar
	
	//notes
	If you need facebook or admob ads， please add facebook placement id and admob ad unit id in ssp.
	If you don't need the facebook or Admob ADs,the related dependence is not needed

 ```

*  Update AndroidManifest.xml as below:

``` xml
	<!--Necessary Permissions-->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>

    	<!--Necessary-->
        <activity android:name="com.cloudtech.ads.view.InnerWebLandingActivity"
            android:launchMode="singleInstance">
            <intent-filter>
                <action android:name="com.cloudtech.action.InnerWebLanding" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </activity>
        
        <service
            android:name="com.cloudtech.ads.core.AdGuardService"
            android:permission="android.permission.BIND_JOB_SERVICE"/>

		<!--for cloudssp interstitial ads-->
        <activity android:name="com.cloudtech.ads.view.InterstitialActivity"
            android:theme="@android:style/Theme.Translucent.NoTitleBar"
            android:launchMode="singleInstance">
        </activity>

        <!--for cloudssp appwall-->
        <activity
        	android:name="com.cloudtech.appwall.AppwallActivity"
        	android:label="@string/app_name"
        	android:screenOrientation="portrait"
        	android:theme="@style/Theme.AppCompat.Light.NoActionBar">
     	</activity>

		<!--for admob interstitial ads-->
        <meta-data android:name="com.google.android.gms.version"
            android:value="@integer/google_play_services_version" />
        <activity android:name="com.google.android.gms.ads.AdActivity"
        	android:configChanges="keyboard|keyboardHidden|orientation|
        			screenLayout|uiMode|screenSize|smallestScreenSize"
            android:theme="@android:style/Theme.Translucent" />
```

* Add below rules for code obfuscation in proguard-project.txt:

```
	#for sdk
    -keep public class com.cloudtech.**{*;}

    #for gaid
    -keep class **.AdvertisingIdClient$** { *; }

    #for js and wwebview interface
    -keepclassmembers class * {
        @android.webkit.JavascriptInterface <methods>;
    }

    #for not group facebook/admob ads
    -dontwarn com.google.android.**
    -dontwarn com.facebook.ads.**

```


