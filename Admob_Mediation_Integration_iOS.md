# Admob Mediation Integration Guide




## <a name="start">Before You Start</a>


* please make sure you have correctly integrated Admob Rewarded Video or Interstitial or Banner Mediation into your application. 
* support banner, interstitial and rewarded video;
* support both of 32 bit and 64 bit operation system;
* support iOS 7.0+;
* Please make sure you have signed up in CloudMobi Platform. If you haven't signed up,please contact us, email: sdk_support@yeahmobi.com
* please make sure you have added an app and at leaset one ad slot in CloudMobi Platform
* [click here to download mediation adapter](https://github.com/cloudmobi/CloudmobiSSP/blob/master/iOS_CTSDK_Adapter-For-Admob.zip)




## <a name="step 2">Set Up CloudMobi as your ad sources in Admob</a>

#### 1. Create apps and ad unit id in Admob console, as below

> ADD APP

![image](https://user-images.githubusercontent.com/7203578/32546617-5102037a-c445-11e7-85e0-aff096505e7e.png)

> ADD AD UNIT 

![image](https://user-images.githubusercontent.com/7203578/32546656-73167126-c445-11e7-818e-a20e7ea49670.png)

-------



#### 2. Create Mediation Group, as below

![image](https://user-images.githubusercontent.com/7203578/32546363-75018e9a-c444-11e7-897b-dfff28811266.png)

------



#### 3. Create the related between Cloudmobi slot id and Admob ad unit id, as below

![image](https://user-images.githubusercontent.com/7203578/32546982-63059b44-c446-11e7-97e5-04e4c03f918a.png)

-------



####  4. Add Cloudmobi custom event in Admob console, as below

![image](https://user-images.githubusercontent.com/7203578/32547141-da20e616-c446-11e7-8698-ea61827d4909.png)

![image](https://user-images.githubusercontent.com/7203578/32547248-3a9321bc-c447-11e7-8f41-41d8e383507f.png)

```
Class Name: GADMAdapterCloudMobi (example)
Parameter: 260 (Cloudmobi slot id)
```

-------



#### 5. Copy GADMAdapterCloudMobi.h and GADMAdapterCloudMobi.m into your code folder

Add files to your project !!!

#### 6. Admob RewardedVIdeo Integrate 

See this [link](https://developers.google.com/admob/android/rewarded-video)

Done!
You are now all set to deliver CloudMobi Ads within your application!