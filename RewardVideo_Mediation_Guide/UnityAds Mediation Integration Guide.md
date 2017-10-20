# UnityAds Mediation Integration Guide

This guide will instruct you step-by-step on how to set UnityAds live as an Ad Network on the CloudMobi SSP platform.

## Step 1. Create an UnityAds Account

1. Create an account with UnityAds. You can do so [here](https://unityads.unity3d.com/admin/#signup).
2. Once your account has been verified you can log in at their partner login [here](https://unityads.unity3d.com/admin/#login).

## Step 2. Create an Application and Placement in UnityAds

Follow these steps to create your UnityAds application:

1. **Create Application**

     a. Once you login, click on ‘**ADD NEW PROJECT**‘:

     ​    i. If you are new to Unity Ads,  you will see  ‘**ADD NEW PROJECT**‘ in the middle of this page

     ![image](https://user-images.githubusercontent.com/20314643/30740601-aa6af436-9f5f-11e7-97c5-827f2193c44e.png)

     ​    ii. If you have created project before, you will see  ‘**ADD NEW PROJECT**‘ in the right bottom of this page

     ![image](https://user-images.githubusercontent.com/20314643/30791103-4289d546-a17e-11e7-8552-c8ce8b8cacee.png)

     b. Define the settings of your app:
     i. Enter your app’s name under **Project Name**.
     ii. Choose your app’s platform and enter the AppStore or Google Play URL of your application under **Select Platforms**. If your app is not live yet, please leave it empty.
     iii. **Platform** – iOS or Android
     iv. **App URL** – enter the AppStore or Google Play URL of your application. If your app is not live yet, please leave it empty.
     v.**Target Age** – check the box if your app is directed to users under the age of 13.

     ![image](https://user-images.githubusercontent.com/20314643/30791251-3d47d3e8-a17f-11e7-9530-f4d3191eee67.png)

     vi. Once you have filled in all the information, click ‘**Continue**‘ on the top right to finish.
     c. Skip the Instructions by clicking ‘OK, got it!‘:

     ![image](https://user-images.githubusercontent.com/20314643/30791309-a0c65d2c-a17f-11e7-898d-c9c7bb1c875d.png)

2. **Create Placement**
     UnityAds creates a default Rewarded Video placement. The default placement comply with the CloudMobi SSP. To view your placements or create a designated placement to run with CloudMobi:

     a. Go to your main dashboard and select the relevant project:

     ![image](https://user-images.githubusercontent.com/20314643/30791449-8a05be10-a180-11e7-93cd-8bfb54aef27e.png)

b. Click on the app with which you wish to run UnityAds with CloudMobi SSP Mediation.

![image](https://user-images.githubusercontent.com/20314643/30791532-0cec373c-a181-11e7-9a18-4018e01f6135.png)

c. Next, you will see a summary of your default placements with all their information under the **Ad Placement** tab. If you’d like to add another placement other then the default units, click on ‘**Add a New Placement’**:

![image](https://user-images.githubusercontent.com/20314643/30791616-b7815358-a181-11e7-9007-306dca27b9c4.png)

d. The below window will appear and you must fill in the following info:

  i. select **Rewarded Video**.

  ii. Enter a name for this specific placement (for example, Between Levels), and click ‘**Save**‘.

![image](https://user-images.githubusercontent.com/20314643/30791733-7a25b64c-a182-11e7-81eb-7cac686168d3.png)



e.After clicking ‘**Save**‘, you should see your manually added placement under your default placements:

![image](https://user-images.githubusercontent.com/20314643/30791768-ddc14f40-a182-11e7-9a20-8983646174b3.png)



## Step 3. Mediating Unity Ads on CloudMobi SSP  
There are a few pieces of data from your Unity Ads account which need to be inserted into your CloudMobi SSP Inventory Module in order for  Unity Ads to work correctly in connection with CloudMobi:



| **Game ID**      | This is the unique identifier of your application in Unity Ad’s system. |
| ---------------- | ---------------------------------------- |
| **API Key**      | This is the unique identifier for the read only report showing in CloudMobi |
| **Placement ID** | This is the unique Ad slot Name  which Unity Ads will deliver ads through. |

Once you obtain this information, you must **configure Unity Ad’s Parameters in your CloudMobi Account**. By adding the above information correctly, you will be able to take full advantage of Unity Ad’s ad inventory and reporting data on CloudMobi SSP platform.

**1.Game ID**
Go to your main monetization dashboard and select the relevant project in which you’ve added the app that you’d like to serve UnityAds through the CloudMobi SSP platform.
![image](https://user-images.githubusercontent.com/20314643/30798207-b3b12ed6-a1a6-11e7-954b-bf226e483f5f.png)


You will then see a list of all added apps in that project as well as their respective Game IDs:

![image](https://user-images.githubusercontent.com/20314643/30798356-55c3e16e-a1a7-11e7-8fd1-677dde530a21.png)

2. **APP ID** On the same page as the SDK Key, simply navigate to the ‘**API Keys**‘ tab. There you will find a **Publisher Reporting API Key**:
   ![image](https://user-images.githubusercontent.com/20314643/30693627-7318e298-9e9e-11e7-9fa5-3c6e41eda9a7.png)

3.**API Key**
Navigate to the main monetization dashboard and you click on API KEYS. You will then see your API Key.

![image](https://user-images.githubusercontent.com/20314643/30798565-1a1ccc2e-a1a8-11e7-9ee6-2834c688928e.png)


## step 4. Configure UnityAd’s Parameters into CloudMobi Account
Once you have all of these parameters, log in to your CloudMobi account and in the left sidebar, navigate to ‘Inventory‘ ➣ ‘Your APP‘ ➣ ‘Edit Your Rewarded video slot➣ ‘‘‘.  networks.

![image](https://user-images.githubusercontent.com/20314643/30694136-bf2b371a-9ea0-11e7-8775-2315e01176ff.png)



![image](https://user-images.githubusercontent.com/20314643/30694253-3420dd36-9ea1-11e7-9627-23573f04854e.png)



![image](https://user-images.githubusercontent.com/20314643/30852480-e2bf281c-a279-11e7-92df-e1636fd797a2.png)



![image](https://user-images.githubusercontent.com/20314643/30852542-19405d66-a27a-11e7-9f22-b656b3e46675.png)



Setting Unity Ad’s priority in CloudMobi Account
click “Ad Network Priority”

![image](https://user-images.githubusercontent.com/20314643/30852603-4ef56096-a27a-11e7-9d76-47afeaffa150.png)