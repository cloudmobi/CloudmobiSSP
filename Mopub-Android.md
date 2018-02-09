
# Mopub Mediation Integration Guide


## <a name="start">Before You Start</a>  

* Support native, banner, interstital and reward video.
* Support API 14(Android 4.0 or later)
* Mopub Platform account needed. 
* Make sure you have correctly integrated Mopub Rewarded Video or Interstitial(Fullscreen) or Banner or native Mediation into your application.
* Please make sure you have signed up in CloudMobi Platform. If you haven't signed up,please contact us, email: sdk_support@yeahmobi.com
* please make sure you have added an app and at leaset one ad slot in CloudMobi Platform
* [Download Adapter](https://github.com/cloudmobi/CloudmobiSSP/blob/master/AndroidSDK_Adapter-For-Mopub.zip)

## <a name="Docking">Intergation</a>

### １. Add CloudSSP network in Mopub console

![image](https://user-images.githubusercontent.com/11080337/27760048-e9f81802-5e70-11e7-93ba-7c186467b5df.png)

### ２. Create apps and ad unit id in Mopub console

![image](https://user-images.githubusercontent.com/11080337/27760203-4b21ec86-5e74-11e7-8d0d-ef8328a5c4cc.png)

### 3. Cnfigeration on Mopub


![image](https://user-images.githubusercontent.com/11080337/27760260-b71bf0c0-5e75-11e7-9d1c-afc25200a902.png)

|Android class full name|com.mopub.mobileads.CTAdapterFullScreen|
|--|--|
||com.mopub.mobileads.CTAdapterNative|
||com.mopub.mobileads.CTAdapterBanner|
||com.mopub.mobileads.CTAdapterRewardVideo|
|ClpudSSP Slot ID|{"CT_SLOTID":"slot ID"}|

> The Number is the slot ID on Cloudmobi Platform

### 4. Copy related code from the Sample code (in our adapter), place the source code into your source code folder: com.mopub.mobileads. 

![image](https://user-images.githubusercontent.com/11080337/27760298-9673bcee-5e76-11e7-8d60-dffadf402cef.png)

### 5. Update the android manefest to support fullscreen AD and RewardedVideo AD.

```
        <!--for cloudssp interstitial ads-->
        <activity android:name="com.cloudtech.ads.view.InterstitialActivity"
            android:theme="@android:style/Theme.Translucent.NoTitleBar"
            android:launchMode="singleInstance"
            android:screenOrientation="portrait">
        </activity>

        <!--for cloudssp rewarded video-->
        <activity android:name="com.cloudtech.videoads.api.CTInterstitialActivity"
            android:screenOrientation="landscape"/>

        <!--for better Ad revenue-->
        <service
            android:name="com.cloudtech.ads.core.AdGuardService"
            android:permission="android.permission.BIND_JOB_SERVICE"/>

        <!--for non google play Ad-->
        <activity android:name="com.cloudtech.ads.view.InnerWebLandingActivity"
            android:launchMode="singleInstance">
            <intent-filter>
                <action android:name="com.cloudtech.action.InnerWebLanding" />
                <category android:name="android.intent.category.DEFAULT" />
            </intent-filter>
        </activity>

```
