# Mopub Mediation Integration Guide

## <a name="start">Before You Start</a>  

* Support native, banner, interstitial (Fullscreen) and rewarded video.
* Support iOS 7.0+.
* Mopub Platform account needed. 
* Make sure you have correctly integrated Mopub Rewarded Video or Interstitial(Fullscreen) or Banner or native Mediation into your application.
* Please make sure you have signed up on the CloudMobi Platform. If you haven't signed up, please contact us via email: sdk_support@yeahmobi.com
* please make sure you have added an app and at least one ad slot in CloudMobi Platform.
* [Download Adapter](https://github.com/cloudmobi/CloudmobiSSP/raw/master/CTADSDKForMopub.zip)

## <a name="Docking">Integration</a>

### 1.Drag the CTADSDK folder into the project
 ![image](https://user-images.githubusercontent.com/13117454/35846555-18b3bff0-0b52-11e8-9c58-84455dfe6863.png)
 ===

### 2.Add a Network on Mopub

![image](https://user-images.githubusercontent.com/13117454/35846618-565c845e-0b52-11e8-8397-639a0c0e4a3b.png)
![image](https://user-images.githubusercontent.com/13117454/35846744-d152ca9c-0b52-11e8-8b88-687e550b2cc1.png)
![image](https://user-images.githubusercontent.com/13117454/35846757-d92dab06-0b52-11e8-8cdf-b8b61533517e.png)

### ３.Configuration on Mopub

![image](https://user-images.githubusercontent.com/13117454/35846838-1f6768c8-0b53-11e8-9d58-0f15eb0e98d3.png)

```
'slotid':'number'
```

> The Number is the slot ID on Cloudmobi Platform

===
### ４.Get mopub Ad unit id
![image](https://user-images.githubusercontent.com/13117454/35846889-59f39fde-0b53-11e8-8c13-af823f31350a.png)
![image](https://user-images.githubusercontent.com/13117454/35846900-65d2c8fc-0b53-11e8-9729-fb94b4764b06.png)
![image](https://user-images.githubusercontent.com/13117454/35846910-77dbd8cc-0b53-11e8-97c0-6e90a9bccbd8.png)
### ５.Use Ad unit id
![image](https://user-images.githubusercontent.com/13117454/35846975-b426c9cc-0b53-11e8-90f3-d6f0fd06b8b1.png)
===
### ６.NativeAd note
The NativeAdView provided to the mopub framework needs to inherit CTNativeAd, and the dealloc method adds the following code:  
  
```
[self removeObserver:self forKeyPath:@"adNativeModel"];
``` 


