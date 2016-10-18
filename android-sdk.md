
###<a name="index">Index</a>
* [SDK download and setup](#install)
* [Setup Eclipse without Gradle](#eclipse)
* [SDK API reference](#api)
* [SDK error code table](#errorcode)
* [Sample code](#sample)
* [How to apply Facebook/Admob advertisement](#reference)

###<a name="install">SDK download and setup</a>

* [Download the SDK](https://raw.githubusercontent.com/cloudmobi/CloudmobiSSP/master/AndroidSDK.zip)
* Build tool：Gradle
* After download, copy file cloudssp_x.jar into target project folder:[ModuleName]/libs/cloudssp_x.jar
* Update the project's build.gradle with below code:

```
    //buildscript::dependencies
    classpath 'com.google.gms:google-services:3.0.0'  
``` 

* Update the module's build.gradle with dependency：

```
	apply plugin: 'com.google.gms.google-services'

	dependencies {
    	compile fileTree(include: ['*.jar'], dir: 'libs')
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

###<a name="eclipse">Setup Eclipse without gradle</a>：
* [Download four jars for eclipse as follows :](https://raw.githubusercontent.com/cloudmobi/CloudmobiSSP/master/AndroidSDK.zip)
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


###<a name="api">SDK API reference</a>：

##### CTService: The calling interface for the SDK.

```
	
    /**
     * Get banner style advertisement.
     * @param slotId 				banner advertisement space id
     * @param isShowCloseButton 	the switch of close-button 
     * @param context				Activity or application context.
     * @param isTest 				Use test advertisement or not
     * @param adListener 			Callback for the advertisement load process.
     * @return 					An container view which include advertisement.
     */
    public static CTNative getBanner(String slotId,
                                      boolean isShowCloseButton,
                                      Context context,
                                      Boolean isTest,
                                      CTAdEventListener adListener)


    /**
     * Preload interstitial advertisement
     * @param slotId 				interstitial advertisement space id
     * @param isShowCloseButton 	the switch of close-button 
     * @param context 				Activity or application context.
     * @param 						isTest Use test advertisement or not
     * @param adListener 			Callback for the advertisement load process.
     * @return 					An container view which include advertisement.
     */
    public static CTNative preloadInterstitial(String slotId,
                                               boolean isShowCloseButton,
                                               Context context,
                                               Boolean isTest,
                                               CTAdEventListener adListener)


    /**
     * Get native advertisement
     * @param slotId 				natvie advertisement space id
     * @param isShowCloseButton 	the switch of close-button      
     * @param context 				Activity or application context.
     * @param isTest				Use test advertisement or not
     * @param adListener 			Callback for the advertisement load process.
     * @return 					An container view which include advertisement.
     */
    public static CTNative getNative(String slotId,
                                     boolean isShowCloseButton,
                                     Context context,
                                     Boolean isTest,
                                     CTAdEventListener adListener) 
                                     
           
                                     
    /**
     * get advanceNative advertisement(namely,get the elements of ads)
     * @param slotId  			the id for cloudssp-ads
     * @param context  			context Activity or application context.
     * @param CTImageType  		the imageType you want(1.9:1 or 1:1)
     		(CTImageType.TYPE_19_TO_10 / CTImageType.TYPE_10_TO_10)
     * @param isTest   			Use test advertisement or not
     * @param adListener  		Callback for the advertisement load process
     * @return				the object to get the elements
     */
    public static CTAdvanceNative getAdvanceNative(String slotId,
                                                   Context context,
                                                   Boolean isTest,
                                                   CTImageType imageType,
                                                   CTAdEventListener adListener)  
                                                   

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
     * get image Bitmap 
     * @return
     */
    public Bitmap getImageBitmap()

	/**
	 * get the iconUrl of ads.
	 */
    public String getIconUrl()

    /**
     * get icon Bitmap
     * @return
     */
    public Bitmap getIconBitmap()
    
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
	 * get the choicesLinkUrl of ads
	 */
    public String getChoicesLinkUrl()  
    
    /**
     * setup your ad Layout
     * @param adLayout
     */
    public void setupAdLayout(View adLayout)  
    
    /**
     * register your ad view for click
     * @param v
     */
	public void registerViewForInteraction(View v) 
	
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
                false, new MyCTAdEventListener(){
                    @Override
                    public void onAdviewGotAdSucceed(CTNative result) {
                        if (result != null){
                            container.setVisibility(View.VISIBLE);
                            container.removeAllViews();
                            container.addView(result);   //把广告添加到容器
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
    		 ContextHolder.getContext(), false, new MyCTAdEventListener(){
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
    			false, new MyCTAdEventListener(){
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
 			false, CTImageType.TYPE_19_TO_10, new MyCTAdEventListener(){
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
    	android:layout_width="match_parent"
    	android:layout_height="match_parent">

    	<ImageView
        	android:id="@+id/iv_img"
       		android:layout_width="match_parent"
        	android:layout_height="200dp"
        	fresco:placeholderImage="@mipmap/ic_launcher"/>

    	<RelativeLayout
       		android:id="@+id/rl_title"
        	android:layout_below="@id/iv_img"
        	android:layout_width="match_parent"
        	android:layout_height="wrap_content"
        	android:layout_margin="5dp">

        	<ImageView
            	android:id="@+id/iv_icon"
            	android:layout_width="50dp"
            	android:layout_height="50dp"
            	fresco:placeholderImage="@mipmap/ic_launcher"/>

        	<TextView
            	android:id="@+id/tv_title"
            	android:layout_width="match_parent"
            	android:layout_height="wrap_content"
            	android:singleLine="true"
            	android:layout_marginLeft="5dp"
            	android:layout_toRightOf="@id/iv_icon"
            	android:text="title"
            	android:textColor="@android:color/darker_gray"
            	android:textSize="18dp"/>
            
    	</RelativeLayout>

    	<TextView
        	android:id="@+id/tv_desc"
        	android:layout_below="@id/rl_title"
        	android:layout_width="match_parent"
        	android:layout_height="wrap_content"
        	android:lines="5"
        	android:layout_margin="5dp"
        	android:text="desc"
        	android:textColor="@android:color/darker_gray"
        	android:textSize="15dp" />

    	<Button
        	android:id="@+id/bt_click"
        	android:layout_width="match_parent"
        	android:layout_height="wrap_content"
        	android:layout_margin="10dp"
        	android:layout_alignParentBottom="true"/>

	</RelativeLayout>

``` 

Show the ads

``` 

	private void showAd(CTAdvanceNative ctAdvanceNative) {

        ImageView img = (ImageView)adLayout.findViewById(R.id.iv_img);
        ImageView icon = (ImageView)adLayout.findViewById(R.id.iv_icon);
        TextView title = (TextView)adLayout.findViewById(R.id.tv_title);
        TextView desc = (TextView)adLayout.findViewById(R.id.tv_desc);
        Button click = (Button)adLayout.findViewById(R.id.bt_click);


        img.setImageBitmap(ctAdvanceNative.getImageBitmap());
        icon.setImageBitmap(ctAdvanceNative.getIconBitmap());
        title.setText(ctAdvanceNative.getTitle());
        desc.setText(ctAdvanceNative.getDesc());
        click.setText(ctAdvanceNative.getButtonStr());

		//register your adLayout for click
        ctAdvanceNative.setupAdLayout(adLayout);
        //IMPORTANT: add CTAdvanceNative into your UI instead adLayout defined by yourself.
        ctAdvanceNative.registerViewForInteraction(adLayout);
        

        container.removeAllViews();
        container.addView(ctAdvanceNative);

    }

```


###<a name="reference">How to apply Facebook/Admob advertisement</a>：
* [Apply Facebook advertisement](https://developers.facebook.com/docs/audience-network)
* [Apply Google Admob advertisement](https://firebase.google.com/docs/admob/android/quick-start)
