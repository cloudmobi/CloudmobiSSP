# AdColony Mediation Integration Guide

This guide instructs you step-by-step on how to set AdColony as an Ad Network on the CloudMobi SSP platform.

## Step 1. Create an AdColony Account

1. Create an account with AdColony. You can do so [here](https://clients.adcolony.com/signup).
2. Once your account has been verified, you can log in to their partner login [here](https://clients.adcolony.com/login).



## Step 2. Create **an **Application and Ad Zone in AdColony

To gain access to AdColony’s inventory within CloudMobi SSP platform, you must first add your app and set up Ad Zones in your AdColony account.

1. **Add Your App** 

   a. Log into your AdColony account and select ‘**Setup New App**’:

   ![image](https://user-images.githubusercontent.com/20314643/30854378-6fd665a8-a27f-11e7-9571-a09b45399bf0.png)

   b. Define the settings of your app:

   ​     i.  **Platform** – iOS or Android

   ​    ii.  **App localized to a specific store**- If your app is only alive in some country，please select the specific country

   ​    iii.  **App Name** – Add the App Name in AppStore or Google Play. If your app is not live yet, you can also enter a temporary name manually.

   ​     iii.  **COPPA **– Select if your app is targeted to users under the age of 13 for COPPA compliancy.

   ​      iv.  **Ad Settings** – You can customize which Ad Categories you want to utilize.Once you’ve entered all your information, select ‘**Create**’ to finish.

   ![image](https://user-images.githubusercontent.com/20314643/30856469-783c43e6-a286-11e7-8b6d-be8953a8e1ff.png)

2. **Create an Ad Zone**
   Once your application has been added, you can create an Ad Zone. In AdColony’s system Ad Zones are**Placements** to which AdColony delivers ads. This will be the placement in your app where you have configured the CloudMobi Rewarded Video to trigger.

   a.  Select ‘**Setup New Ad Zone’**

   ![image](https://user-images.githubusercontent.com/20314643/30856730-3e0c9922-a287-11e7-998f-a1bc5de0edc3.png)

   b. Create the Ad Zone settings:

   ​     **Rewarded Video**:
   ​     Zone is active?**‘Yes’**

   ​     Zone Type: ‘**Value Exchange/V4VC**’ 

   ​     Client Side Only: ‘**Yes**‘

   ![image](https://user-images.githubusercontent.com/20314643/30857272-15e18a1e-a289-11e7-9adf-3d47600d5fd6.png)


   Show test ads only (for dev or debug)?:**'No'**

   When finished, click** ‘Create’**.

   ![image](https://user-images.githubusercontent.com/20314643/30857372-75addf38-a289-11e7-80e2-7f2577975129.png)

​          



## Step 3. Activate AdColony in Your CloudMobi SSP Inventory Module

There are a few pieces parameters from your AdColony account which need to be inserted into your CloudMobi Setup Module in order for AdColony to work correctly in connection with CloudMobi:

| **App ID**            | This is the unique identifier of your Application in AdColony’s system. |
| --------------------- | ---------------------------------------- |
| **Zone ID**           | This is the unique Zone which AdColony will deliver ads to. |
| **Read-Only API Key** | This is a unique identifier for your AdColony account, which allows the CloudMobi SSP to import performance data from your AdColony account to use in reporting & optimization. |

   Once you obtain this information, you must **configure AdColony’s Parameters in your CloudMobi Account**. By adding the above information correctly, you will be able to take full advantage of AdColony’s ad inventory and reporting data on the CloudMobi SSP.

1.    **App ID** Navigate back to the ‘**Apps**‘ tab and you will locate the ‘**AdColony App ID**‘.

      ![image](https://user-images.githubusercontent.com/20314643/30857649-95a712ae-a28a-11e7-98ba-76f1610f37be.png)

2. **Zone ID** Navigate to ‘Monetization’ ➣ Select the ‘App’ you created ➣ Then select the ‘**Zone**‘ you created and you will be directed to the below page, where you will find the ‘**Zone ID**‘.

      ![image](https://user-images.githubusercontent.com/20314643/30857715-d512a8f4-a28a-11e7-82c1-aee6c500df74.png)

3. **Read-Only API Key**

      Select the Drop-down menu on the top right of their dashboard, and you will find the ‘**Account Settings**’ link.

      ![image](https://user-images.githubusercontent.com/20314643/30857817-2a497f1e-a28b-11e7-85b7-e78c82ccb17f.png)

On the settings page you will find the ‘**Read-Only API Key**’.

![输入图片说明](https://git.oschina.net/uploads/images/2017/0926/193051_c6a58aa7_866297.png "屏幕截图.png")

​      



## Step 4. Configure AdColony’s Parameters into CloudMobi Account

Once you have all of these parameters, log in to your CloudMobi account and in the left sidebar, navigate to ‘Inventory‘ ➣ ‘Your APP‘ ➣ ‘Edit Your Rewarded video slot➣ ‘‘‘.  networks.

![image](https://user-images.githubusercontent.com/20314643/30694136-bf2b371a-9ea0-11e7-8775-2315e01176ff.png)

​      

![image](https://user-images.githubusercontent.com/20314643/30694253-3420dd36-9ea1-11e7-9627-23573f04854e.png)

​      

![输入图片说明](https://git.oschina.net/uploads/images/2017/0926/193529_ca87c0a6_866297.png "屏幕截图.png")

​      

![输入图片说明](https://git.oschina.net/uploads/images/2017/0926/193620_33ee8416_866297.png "屏幕截图.png")

Setting AdColony’s priority in CloudMobi Account

click “Ad Network Priority”![输入图片说明](https://git.oschina.net/uploads/images/2017/0926/193731_a258a912_866297.png "屏幕截图.png")