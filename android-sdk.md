
###<a name="index">Index</a>
* [Release Notes](#release_notes)
* [SDK download and Setup AndroidStudio](#install)
* [Setup Eclipse without Gradle](#eclipse)
* [SDK API reference](#api)
* [SDK error code table](#errorcode)
* [Sample code](#sample)
* [Integrate AD appwall in Android Studio](#appwall)
* [How to apply Facebook/Admob advertisement](#reference)

###<a name="release_notes">Release Notes</a>
* Release version: 1.1.2
* Release date: Nov-26-2016
* Release notes：
    1. Improve the Ad landing performance.
    2. Fix a crash bug for Admob user.

###<a name="install">SDK download and Setup AndroidStudio</a>

* [Download the SDK](https://github.com/cloudmobi/CloudmobiSSP/raw/master/AndroidSDK.zip)
* Build tool：Gradle
* Select API 15: Android 4.0.3 or later.
* After download, copy file cloudssp_x.jar into target project folder:[ModuleName]/libs/cloudssp_x.jar
* Update the project's build.gradle with below code:

```
    classpath 'com.google.gms:google-services:3.0.0'  
``` 

* Update the module's build.gradle with dependency：

```
	apply plugin: 'com.google.gms.google-services'

	dependencies {
    		compile 'com.google.firebase:firebase-ads:9.0.0'
    		compile 'com.facebook.android:audience-network-sdk:4.13.0'
    		compile files('libs/cloudssp_x.jar')
    		
    	//If you need facebook or admob ads， please add facebook placement id and admob ad unit id in ssp.
    	//If you don't need the facebook or Admob ADs,the related dependence is not needed.
	}
	
```

* Update AndroidManifest.xml as below:

```
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    
		
        <activity android:name="com.cloudtech.ads.view.InnerWebLandingActivity"
            android:launchMode="singleInstance">
            <intent-filter>
                <action android:name="com.cloudtech.action.InnerWebLanding" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </activity>

        <activity android:name="com.cloudtech.ads.view.InterstitialActivity"
            android:theme="@android:style/Theme.Translucent.NoTitleBar"
            android:launchMode="singleInstance">
        </activity>

        <activity android:name="com.google.android.gms.ads.AdActivity"
      		android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
            android:theme="@android:style/Theme.Translucent" />
            
       
```

* Add below rules for code obfuscation in proguard-rules.pro:

```
	-keepclassmembers class * {
   		@android.webkit.JavascriptInterface <methods>;
	}
	
	-keep class **.AdvertisingIdClient$** { *; }

```

###<a name="eclipse">Setup Eclipse without gradle</a>：
* [Download four jars for eclipse as follows :](https://github.com/cloudmobi/CloudmobiSSP/raw/master/AndroidSDK.zip)
 cloudssp_x.jar , AudienceNetwork.jar , google-play-services-ads-lite.jar , google-play-services-basement.jar
 
	（If you need facebook or admob ads， please add facebook placement id and admob ad unit id in ssp.  If you don't need the facebook or Admob ADs,the related dependence is not needed.）

* Build tool：Ant
* Copy the four jars into target project folder /libs/ , and Add them to build path.
*  Add the follows in strings.xml

```
    <integer name="google_play_services_version">9256000</integer>
```
*  Update AndroidManifest.xml as below:

```
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    
    
        <meta-data android:name="com.google.android.gms.version"                 
            android:value="@integer/google_play_services_version" />
            
        <activity android:name="com.cloudtech.ads.view.InnerWebLandingActivity"
            android:launchMode="singleInstance">
            <intent-filter>
                <action android:name="com.cloudtech.action.InnerWebLanding" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </activity>

        <activity android:name="com.cloudtech.ads.view.InterstitialActivity"
            android:theme="@android:style/Theme.Translucent.NoTitleBar"
            android:launchMode="singleInstance">
        </activity>

        <activity android:name="com.google.android.gms.ads.AdActivity"                    
        android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize"
            android:theme="@android:style/Theme.Translucent" />
       
```
* Add below rules for code obfuscation in proguard-project.txt:

```
	-keepclassmembers class * {
   		@android.webkit.JavascriptInterface <methods>;
	}
	
	-keep class **.AdvertisingIdClient$** { *; }

```


###<a name="api">SDK API reference</a>：


##### CTService: The calling interface for the SDK.

```
	
    /**
     * get advanceNative advertisement(namely,get the elements of ads)
     * @param slotId  			the id for cloudssp-ads
     * @param context  			context Activity or application context.
     * @param CTImageType  		the imageType you want(1.9:1 or 1:1)
     		(CTImageType.TYPE_19_TO_10 / CTImageType.TYPE_1_TO_1)
     * @param adListener  		Callback for the advertisement load process
     * @return				the object to get the elements
     */
    public static CTAdvanceNative getAdvanceNative(String slotId,
                                                   Context context,
                                                   CTImageType imageType,
                                                   CTAdEventListener adListener) 
						   
						  
    /**
     * get advanceNative ads by keywords or category
     * @param slotId  			the id for cloudssp-ads
     * @param context  			context Activity or application context
     * @param imageType  		the imageType you want(1.9:1 or 1:1)
     		(CTImageType.TYPE_19_TO_10 / CTImageType.TYPE_1_TO_1)
     * @param adsCat     		the adsCategory you want(default,games,tools)
     		(TYPE_DEFAULT  /  TYPE_GAME  /  TYPE_TOOL)
     * @param keywords   		get ads by keywords，fill null if not need
     * @param adListener   		callback for ads load process
     * @return  			the object to get the elements
     */
    public static CTAdvanceNative getAdvanceNativeByKeyword(String slotId,
                                                   Context context,
                                                   CTImageType imageType,
                                                   CTAdsCat adsCat,
                                                   List<String> keywords,
                                                   CTAdEventListener adListener)

	
	
    /**
     * Get banner style advertisement.
     * @param slotId 				banner advertisement space id
     * @param isShowCloseButton 	the switch of close-button 
     * @param context				Activity or application context.
     * @param adListener 			Callback for the advertisement load process.
     * @return 					An container view which include advertisement.
     */
    public static CTNative getBanner(String slotId,
                                      boolean isShowCloseButton,
                                      Context context,
                                      CTAdEventListener adListener)



    /**
     * Preload interstitial advertisement
     * @param slotId 				interstitial advertisement space id
     * @param isShowCloseButton 	the switch of close-button 
     * @param context 				Activity or application context.
     * @param adListener 			Callback for the advertisement load process.
     * @return 					An container view which include advertisement.
     */
    public static CTNative preloadInterstitial(String slotId,
                                               boolean isShowCloseButton,
                                               Context context,
                                               CTAdEventListener adListener)


    /**
     * Get native advertisement
     * @param slotId 				natvie advertisement space id
     * @param isShowCloseButton 	the switch of close-button      
     * @param context 				Activity or application context.
     * @param adListener 			Callback for the advertisement load process.
     * @return 					An container view which include advertisement.
     */
    public static CTNative getNative(String slotId,
                                     boolean isShowCloseButton,
                                     Context context,
                                     CTAdEventListener adListener) 
                                     
           
           
    /**
     * Get the specified number of Ads. The actual number will decied by server side, between [1,reqAdNumber]
     * @param reqAdNumber  the number of request Ads
     * @param slotId     cloudtech Ads slot id
     * @param context    Android context
     * @param imageType  Image type for the picture.
     * @param adListener Callback for the advertisement load process.
     *
     * @return
     */
    public static void getMultiNativeAds(int reqAdNumber, 
                                         String slotId, 
                                         Context context, 
                                         CTImageType imageType, 
                                         MultiAdsEventListener adListener)


    /**
     * Show interstitial advertisement after you get it success.
     * @param adView The advertisement container which return by preload
     */
    public static void showInterstitial(CTNative adView)


    /**
     * Close the interstitial advertisement
     * @param adView The advertisement container which return by preload
     */
    public static void closeInterstitial(CTNative adView) 
   
```


##### CTNative: A framelayout container view which hold the advertisement.

```
   
    /**
     * Get all error logs which return by the advertisement query process.
     * @return Error List
     */
    public List<CTError> getErrors()


    /**
     * Is current advertisement load successfully.
     * @return
     */
    public boolean isLoaded()
```



##### CTAdvanceNative: An object which hold the elements of advertisment.

```
	
    /**
     * get the imageUrl of ads
     */
    public String getImageUrl() 

    /**
     * get the iconUrl of ads.
     */
    public String getIconUrl()
    
    /**
	 * get the title of ads
	 */
    public String getTitle() 
    
    /**
	 * get the desc of ads
	 */
    public String getDesc() 
    
    /**
	 * get the callToAction of ads
	 */
    public String getButtonStr()
    
    /**
	 * get the rates of ads
	 */
    public String getRate() 
    
    /**
	 * get the adchoiceIconUrl of ads
	 */
    public String getAdChoiceIconUrl() 
    
	/**
	 * get the adChoiceLinkUrl of ads
	 */
    public String getAdChoiceLinkUrl()  
    
    /**
     * Add AD layout to AD container
     * Mandatory. Add the customized ad layout  to ad container. the caller must call this method to defince click behavior.
     *
     * @param adLayout
     */
    public void addADLayoutToADContainer(View adLayout)  
    
    /*
     * Define the AD click/interaction area
     * Optional. Set the ad click area. the default click area is the whole ad layout.
     *
     * @param v
     */
    public void registeADClickArea(View v) 
	
```


##### CTAdEventListener: Call back interface for the advertisement loading process.

```

    /**
     * Load and render advertisement successful.
     */
    public void onAdviewGotAdSucceed(CTNative result);

    /**
     * Load and render interstitial advertisement successful.
     */
    public void onInterstitialLoadSucceed(CTNative result);

    /**
     * Load and render advertisement failed.
     */
    public void onAdviewGotAdFail(CTNative result);

    /**
     * Advertisement landing page will show.
     */
    public void onAdviewIntoLandpage(CTNative result);

    /**
     * Try to go to advertisement landing page, but failed.
     */
    public void onStartLandingPageFail(CTNative result);

    /**
     * User left the advertisement landing page. 
     */
    public void onAdviewDismissedLandpage(CTNative result);

    /**
     * User click the advertisement.
     */
    public void onAdviewClicked(CTNative result);

    /**
     * User close the advertisement.
     */
    public void onAdviewClosed(CTNative result);

    /**
     * When the advertisement has been destroyed or garbage collected.
     */
    public void onAdviewDestroyed(CTNative result);
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
|                    |                      |


###<a name="sample">Sample code</a>		

* About CTAdEventListerner
   
   We suggest you define a class to implement the CTAdEventListener yourself , then you can just override the methods you need when you getBanner or getNative. just as follows:
    
```
public class MyCTAdEventListener implements CTAdEventListener {
   
    @Override
    public void onAdviewGotAdSucceed(CTNative result) {
        showMsg("onAdviewGotAdSucceed");
    }

    @Override
    public void onInterstitialLoadSucceed(CTNative result) {
        showMsg("onInterstitialLoadSucceed");
    }

    @Override
    public void onAdviewGotAdFail(CTNative result) {
        showMsg(result.getErrorsMsg());
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

        Toast.makeText(ContextHolder.getContext(), msg, Toast.LENGTH_SHORT).show();
    }
}
```         

##### Banner advertisement：
```
  
  	 CTService.getBanner(Config.slotIdBanner, true, ContextHolder.getContext(),
               	 new MyCTAdEventListener(){
                    @Override
                    public void onAdviewGotAdSucceed(CTNative result) {
                        if (result != null){
                            container.setVisibility(View.VISIBLE);
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
                        container.setVisibility(View.GONE);
    
                        super.onAdviewClosed(result);
                    }
                });
```

##### Interstitial advertisement：
```
    CTService.preloadInterstitial(Config.slotIdInterstitial,true,
    		 ContextHolder.getContext(), new MyCTAdEventListener(){
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
                });    
```

##### Native advertisement：

```
    CTService.getNative(Config.slotIdNative, false, ContextHolder.getContext(), 
    			new MyCTAdEventListener(){
                    @Override
                    public void onAdviewGotAdSucceed(CTNative result) {
                        if (result != null) {
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


##### Advance Native advertisement：

The container and the layout for ad:

```
	ViewGroup container = (ViewGroup) view.findViewById(R.id.container);                                                     	
	ViewGroup adLayout = (ViewGroup)View.inflate(ContextHolder.getContext(),R.layout.advance_native_layout, null);
	
```

The method to load ads:

```

 	CTService.getAdvanceNative(Config.slotIdNative, ContextHolder.getContext(), 
 			 CTImageType.TYPE_19_TO_10, new MyCTAdEventListener(){
                    @Override
                    public void onAdviewGotAdSucceed(CTNative result) {
                        if (result == null){
                            return;
                        }
                        CTAdvanceNative ctAdvanceNative = (CTAdvanceNative) result;
                        showAd(ctAdvanceNative);

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

                });
                                      
                
```

The layout defined for the Ad UI：

```   
 
	<?xml version="1.0" encoding="utf-8"?>
	<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    	xmlns:fresco="http://schemas.android.com/apk/res-auto"
    	android:layout_width="match_parent"
    	android:layout_height="match_parent">



    <com.facebook.drawee.view.SimpleDraweeView
        android:id="@+id/iv_img"
        android:layout_width="match_parent"
        android:layout_height="200dp"
        android:background="@mipmap/ic_launcher"
        fresco:placeholderImage="@mipmap/ic_launcher" />


    <RelativeLayout
        android:id="@+id/rl_title"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_below="@id/iv_img"
        android:layout_margin="5dp">

        <com.facebook.drawee.view.SimpleDraweeView
            android:id="@+id/iv_icon"
            android:layout_width="50dp"
            android:layout_height="50dp"
            android:background="@mipmap/ic_launcher"
            fresco:placeholderImage="@mipmap/ic_launcher" />


        <TextView
            android:id="@+id/tv_title"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginLeft="5dp"
            android:layout_toRightOf="@id/iv_icon"
            android:singleLine="true"
            android:text="title"
            android:textColor="@android:color/darker_gray"
            android:textSize="18dp" />


    </RelativeLayout>


    <TextView
        android:id="@+id/tv_desc"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_below="@id/rl_title"
        android:layout_margin="5dp"
        android:lines="5"
        android:text="desc"
        android:textColor="@android:color/darker_gray"
        android:textSize="15dp" />

    <Button
        android:id="@+id/bt_click"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:layout_alignParentBottom="true"
        android:layout_margin="10dp" />

    <com.facebook.drawee.view.SimpleDraweeView
        android:id="@+id/ad_choice_icon"
        android:layout_alignParentRight="true"
        android:layout_alignParentTop="true"
        android:layout_width="20dp"
        android:layout_height="20dp"
        fresco:placeholderImage="@mipmap/ic_launcher" />
	
	</RelativeLayout>

``` 

Show the ads

``` 

    private void showAd(CTAdvanceNative ctAdvanceNative) {

	SimpleDraweeView img = (SimpleDraweeView)adLayout.findViewById(R.id.iv_img);
        SimpleDraweeView icon = (SimpleDraweeView)adLayout.findViewById(R.id.iv_icon);
        TextView title = (TextView)adLayout.findViewById(R.id.tv_title);
        TextView desc = (TextView)adLayout.findViewById(R.id.tv_desc);
        Button click = (Button)adLayout.findViewById(R.id.bt_click);
        SimpleDraweeView ad_choice_icon = (SimpleDraweeView)adLayout.findViewById(R.id.ad_choice_icon);


        img.setImageURI(Uri.parse(ctAdvanceNative.getImageUrl()));
        icon.setImageURI(Uri.parse(ctAdvanceNative.getIconUrl()));
        title.setText(ctAdvanceNative.getTitle());
        desc.setText(ctAdvanceNative.getDesc());
        click.setText(ctAdvanceNative.getButtonStr());
        ad_choice_icon.setImageURI(ctAdvanceNative.getAdChoiceIconUrl());


        // Mandatory. Add the customized ad layout to ad container,the caller must call this method to defince click behavior.
	ctAdvanceNative.addADLayoutToADContainer(adLayout);
	//Optional. Set the ad click area,the default click area is the whole ad layout.
	ctAdvanceNative.registeADClickArea(adLayout);


        ad_choice_icon.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                Toast.makeText(getContext(), ctAdvanceNative.getAdChoiceLinkUrl(), Toast.LENGTH_LONG).show();
            }
        });

        container.removeAllViews();
        container.addView(ctAdvanceNative);
   }
		

```


###<a name="appwall">Integrate AD appwall in Android Studio</a>：

##### Setup the build.gradle:
Copy the cloudssp_appwall_x.aar and cloudssp_x.jar to foloder libs. and add below code to build.gradle.

``` 

repositories {
    flatDir {
        dirs 'libs'
    }
}

dependencies {
    compile 'com.android.support:appcompat-v7:24.2.1'
    compile 'com.android.support:cardview-v7:24.0.+'
    compile 'com.squareup.picasso:picasso:2.5.2'
    compile(name: 'appwall_x', ext: 'aar')
    compile files('libs/cloudssp_x.jar')

}

```

#####API Reference:  AppwallHelper

``` 

    /**
     * Start the app wall UI.
     * @param Context context
     * @param slotId     cloudtech Ads slot id
     *
     */
    public static void showAppwall(Context context, String slotId) 


```

#####Sample code

``` 
    AppwallHelper.showAppwall(context, slotId);

```

###<a name="reference">How to apply Facebook/Admob advertisement</a>：
* [Apply Facebook advertisement](https://developers.facebook.com/docs/audience-network)
* [Apply Google Admob advertisement](https://firebase.google.com/docs/admob/android/quick-start)
