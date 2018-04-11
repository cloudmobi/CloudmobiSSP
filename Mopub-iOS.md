# Mopub Mediation Integration Guide

## <a name="start">Before You Start</a>  

* Support native, banner, interstitial (Fullscreen) and rewarded video.
* Support iOS 7.0+.
* The Mopub account is needed. 
* Make sure you have correctly integrated Mopub Rewarded Video or Interstitial(Fullscreen) or Banner or Native Mediation into your application.
* Please make sure you have signed up on Cloudmobi Platform to get your own slot id for test. If you haven't signed up, please contact us, email to sdk_support@yeahmobi.com.
* [Download Adapter](https://github.com/cloudmobi/CloudmobiSSP/raw/master/CTADSDKForMopub.zip)

## <a name="Docking">Integration</a>

### Step 1. Download the adpater

![image](https://user-images.githubusercontent.com/20314643/37516166-37e68bb4-2948-11e8-8418-d1e859c4a210.png)


The folders within the download include:

1. SDK Adapter for Mopub. Please put “CTSDK.framework” and the ad formats you’ll use into Mopub's Project.
2. Integration Guidance.
3. Demo.

### Step 2. Put the CTADSDK folder into the project

 ![image](https://user-images.githubusercontent.com/13117454/35846555-18b3bff0-0b52-11e8-9c58-84455dfe6863.png)
 ===

### Step 3.Add a Network on Mopub

![image](https://user-images.githubusercontent.com/13117454/35846618-565c845e-0b52-11e8-8397-639a0c0e4a3b.png)
![image](https://user-images.githubusercontent.com/13117454/35846744-d152ca9c-0b52-11e8-8b88-687e550b2cc1.png)
![image](https://user-images.githubusercontent.com/13117454/35846757-d92dab06-0b52-11e8-8cdf-b8b61533517e.png)

### Step 4.Configuration on Mopub

![image](https://user-images.githubusercontent.com/13117454/35846838-1f6768c8-0b53-11e8-9d58-0f15eb0e98d3.png)

```
'slotid':'number'
```

> The Number is the slot ID on Cloudmobi Platform

===
### Step 5.Get mopub Ad unit id
![image](https://user-images.githubusercontent.com/13117454/35846889-59f39fde-0b53-11e8-8c13-af823f31350a.png)
![image](https://user-images.githubusercontent.com/13117454/35846900-65d2c8fc-0b53-11e8-9729-fb94b4764b06.png)
![image](https://user-images.githubusercontent.com/13117454/35846910-77dbd8cc-0b53-11e8-97c0-6e90a9bccbd8.png)
### Step 6.Use Ad unit id
![image](https://user-images.githubusercontent.com/13117454/35846975-b426c9cc-0b53-11e8-90f3-d6f0fd06b8b1.png)
===

