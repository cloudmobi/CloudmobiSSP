# FAQs for Yeahmobi SDK integration and Dashboard

 

## FAQs for Dashboard

1. What time standard does the reporting system use?

- We use UTC time.

2. How often does the reporting system update?

- The data is updated each hour. The complete report of the previous day is available at 7:00 AM UTC time.

3. Which slot ID should I choose for initialization?

- If you are using Rewarded Video ads, you must use a Rewarded Video slot ID for initialization.
- Otherwise, you may use any of your app’s slot IDs for initialization.
- Please note that all slot IDs used in one app must be under the same app ID or you will not receive ads.

## FAQs for Android Integration

1. Why can’t I get Rewarded Video Ads (Error: “No ads”)?

- If you’ve just opened the app: Please wait a moment and try to preload again, as the video may not be downloaded yet.
- If you’ve already seen ads today: Try changing IDFA to get the ad. In order to ensure a positive user experience, our ads are provided with frequency controls. If you’ve reached the max ad frequency, you will need to  change the IDFA to get more ads.
- Settings block ad category (Dashboard): You can reduce or clear the block ad category (category blacklisting) to get more ads. We recommend having no blocked ad categories during testing to ensure the integration works as intended. 
- Not using the Rewarded Video slot ID to initialize sdk: You must initialize the SDK using a Rewarded Video slot ID in order to receive Rewarded Video ads.

2. Why can’t I get any type of ads?

- Google Play service is required for displaying any ads in Android. If the device does not support the Google Play service, please download Google Play or change to another device.

3. Why is the ad stuck after clicking the ad?

- Since nearly all ad campaigns we serve on Android lead to the Google Play Store, the ad may be stuck if the Google Play Store is not installed or disabled.
- If the Google Play Store is installed and enabled, but the ad is still stuck after clicking, please contact our support team at sdk_support@yeahmobi.com for assistance.

4. Why is the error “Error ERR_016_Obtain Config Failed” reported?

- The error occurs while getting templates and ad priority configuration information.
- First, please check the network connection of the device. If the network is active and the error still occurs, please contact our support team at sdk_support@yeahmobi.com for help checking the slot configuration on the dashboard.

5. Why is the error “ERR_019_No Corresponding Template” reported?

- Please double-check that all the slot IDs used in the app are under the same app id (if not, you will not get ads).

## FAQs for iOS Integration

1. Why can’t I get Rewarded Video Ads (Error: “No ads”)?

- If you’ve just opened the app: Please wait a moment and try to preload again as the video may not be downloaded yet.
- If you’ve already seen ads today: Try changing IDFA to get the ad. In order to ensure a positive user experience, our ads are provided with frequency controls. If you’ve reached the max ad frequency, you can change the IDFA to get more ads.
- Settings block ad category (Dashboard): You can reduce or clear the ad category blacklist to get more ads. We suggest no blacklist during testing to ensure the integration works as intended. If the fill rate doesn’t reach your expectation after setting the desired ad category, please contact us (Email: sdk_support@yeahmobi.com).
- Rewarded Video ads will not serve unless you initialize using a Rewarded Video slot ID: For Rewarded Video initialization, make sure to use the correct Rewarded Video slot ID to initialize sdk. Otherwise, Rewarded Video ads will not serve.

2. Why is the ad stuck after clicking the ad?

Several reasons could lead to this problem:

- The most likely cause is a poor network connection (weak or nonexistent connection to wifi or data). Please check your network connection.
- If you are using a simulator: The simulator for debugging doesn’t install the iOS app store, meaning a click-through won’t properly lead to the app store.
- The link or click-through URL of the advertisement itself could be invalid. In this case, please contact us via email ( sdk_support@yeahmobi.com ) to check it.

3. Why is the error “Error:Error Domain=CTSDK:The slot XXXX and the slot for SDK initialization are not in the same app. Code=10005 "(null)” reported?

- The slot IDs used in the title are not under the same app id. Please correct it (make the slot IDs under the same app id), or you can’t get ads.

If the answers above didn’t solve your problems, please feel free to contact us.

You can always contact our Business Managers or Operations team members directly, or you can contact us via email or skype, per the below:

Email: sdk_support@yeahmobi.com

Skype：sdk_support@yeahmobi.com
