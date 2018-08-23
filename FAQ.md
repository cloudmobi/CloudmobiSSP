# FAQs for Yeahmobi SDK integration and Dashboard
 
## FAQs for Dashboard

### 1. What time zone does the report use?
UTC.
### 2. What is the frequency of data updates?
The data is updated every hour. To ensure the accuracy of the data, generally the complete data report of the previous day can be seen after 7:00 AM UTC.
### 3. What shall I pay attention to when using Slot ID to initialize the app?
Please use one of the Slot IDs of the app under which the Slots are created to initialize it. Please notice that all the Slot IDs used in one title should match the App, under which the Slots are created. Or you cannot get ads.



## FAQs for Android Integration

### 1. Why do I fail to request ads after integrating SDK?  
•	When you are based in China and request ads overseas, a VPN is needed.   
•	The VPN in use is unstable when you are based in China and request ads overseas, you’d better change another VPN service.  
•	If the device does not support Google Play service, please go to Google Play service guide to figure it out.  
### 2. Why can't it jump to next step after I click on the ad?  
•	Almost all of campaigns we’re serving are leading to Google Play store, thus, it could happen when Google Play Store is not installed.  
•	If Google Play Store is disabled, it won't jump.  
•	In few cases, there could be some unknown problems with the ads. Please email to our support team immediately for support. The email address is sdk_support@yeahmobi.com.  
### 3. What is the minimum system version supported by the SDK?  
It’s the Android API 14 and above.  
### 4. Why is the error “Error ERR_016_Obtain Config Failed” reported?  
The error occurs on getting templates and ad priority configuration information.   
Solutions: 
(1) Please check whether it’s a network problem; 
(2) Please contact our operation manager via email ( sdk_support@yeahmobi.com ) to check whether there’s something wrong with the configuration of ad placements on the dashboard.
### 5. Why is the error “ERR_019_No Corresponding Template” reported?
The Slot IDs used in the title don’t match the app, under which the slots are created. Please correct it, or ads cannot be obtained.




## FAQs for iOS Integration

### 1. Why doesn't it fail to jump to next step after I click on the ad?
Several reasons could lead to this problem:  
(1) Poor network conditions can’t support the feature run smoothly;   
(2) The simulator for debugging doesn’t install iOS app store;   
(3) The link of the advertisement itself could be not correct. In this case, please contact our operation manager via email ( sdk_support@yeahmobi.com ) to check about it.  
### 2. What is the minimum system version supported by the SDK?
iOS 7 and above.
### 3. Special notes about Native element interface.
Before adding an auto view that inherits CTNativeAd to the main view, you should ensure that the custom view already has a frame and that view.AdNativeModel has already been assigned.
### 4. Why is the error “Error:Error Domain=CTSDK:The slot 1234 and the slot for initializes SDK are not in the same app. Code=10005 "(null)” reported?
The Slot IDs used in one title don’t match the app, under which the slots are created. Please correct it, or ads cannot be obtained.

