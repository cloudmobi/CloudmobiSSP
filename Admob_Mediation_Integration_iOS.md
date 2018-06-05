# Admob Mediation Integration Guide




## <a name="start">Before You Start</a>


* Please make sure you have correctly integrated Admob Rewarded Video or Interstitial or Banner Mediation into your application. 
* Support banner, interstitial and rewarded video;
* Support both of 32 bit and 64 bit operating systems;
* Support iOS 7.0+;
* Please make sure you have signed up on Cloudmobi Platform to get your own slot id for test. If you haven't signed up, please contact us, email to sdk_support@yeahmobi.com.
* Please make sure you have added an app and at least one ad slot in Cloudmobi Platform
* [click here to download the mediation adapter](https://github.com/cloudmobi/iOS-SDK/blob/master/iOS_CTSDK_Adapter-For-Admob.zip)




## <a name="step 2">Set Up Cloudmobi as your ad sources in Admob</a>

#### 1. Create apps and ad unit id in Admob console, as below

> ADD APP

![image](https://user-images.githubusercontent.com/7203578/32546617-5102037a-c445-11e7-85e0-aff096505e7e.png)

> ADD AD UNIT 

![image](https://user-images.githubusercontent.com/7203578/32546656-73167126-c445-11e7-818e-a20e7ea49670.png)

-------



#### 2. Create Mediation Group, as below

![image](https://user-images.githubusercontent.com/7203578/32546363-75018e9a-c444-11e7-897b-dfff28811266.png)

------



#### 3. Create the Ad Unit in your Admob dashboard that corresponds to your Cloudmobi slot ID 

![image](https://user-images.githubusercontent.com/7203578/32546982-63059b44-c446-11e7-97e5-04e4c03f918a.png)

-------



####  4. Add Cloudmobi custom event in Admob console, as below

![image](https://user-images.githubusercontent.com/7203578/32547141-da20e616-c446-11e7-8698-ea61827d4909.png)

![image](https://user-images.githubusercontent.com/7203578/32547248-3a9321bc-c447-11e7-8f41-41d8e383507f.png)

```
Class Name: GADMAdapterCloudmobi (example)
Parameter: 260 (Cloudmobi slot id)
```

-------



#### 5. Copy GADMAdapterCloudmobi.h and GADMAdapterCloudmobi.m into your code folder

Add files to your project !!!

#### 6. Admob Rewarded Video Integration 

See this [link](https://developers.google.com/admob/android/rewarded-video)

Done!
You are now all set to deliver Cloudmobi Ads within your application!
