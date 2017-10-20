# Tapjoy Mediation Integration Guide

This guide will instruct you step-by-step on how to set Tapjoy as an Ad Network on the CloudMobi SSP platform.

## Step 1. Create an Tapjoy Account

1. Create an account with Tapjoy. You can do so [here](https://ltv.tapjoy.com/s/l#session/signup).

2. Click on the link in the confirmation email to verify your account. Once your account has been verified, you can log in to their partner login [here](https://ltv.tapjoy.com/s/l#session/login).

## Step 2. Create **an **Application in Tapjoy

To gain access to Tapjoy’s inventory within CloudMobi SSP platform, you must first add your app and set up Ad Placements in your Tapjoy account.

#### Add Your App

a. Log into your Tapjoy account.

   i.  If you are a new user on Tapjoy you will be presented with this window, and can simply select ‘**Create App**‘:

   ![image](https://user-images.githubusercontent.com/20314643/30686961-d268bc3a-9e87-11e7-97ed-651e098ed66a.png)





   ii. If you are a registered user, add an app by clicking on the top-right corner and select ‘**+Add App**‘:

   ![image](https://user-images.githubusercontent.com/20314643/30686666-f521dc1c-9e86-11e7-970c-7dd86ad13e4c.png)


   b. Define the settings of your app:

   i. **Platform** – iOS or Android or both
   **Note**: While Tapjoy allows you to create your app with both platforms, you will need a unique Tapjoy SDK Key per platform (iOS + Android) to enable it in your CloudMobi account. If you use a combined Dashboard on Tapjoy it will give you both an iOS and Android SDK key.

   ii. **App Name**

   iii.**Orientation **

   iv. **Time ZoneCurrency**

   v.  Select ‘**Create Now**’ to finish.

![image](https://user-images.githubusercontent.com/20314643/30686786-4f4c9150-9e87-11e7-9840-0c853eca88c4.png)


## Step 3. Add Placement, Virtual Currency and Content

#### 1. Ad Placement

Once your application has been added, Tapjoy will create default placements for you. Please don't use any default placements.

**Important!** Placements must be **user-initiated** to work in conjunction with CloudMobi SSP platform.

a. Go to the **Monetization** tab in the top menu and in the left side bar select ‘**Placements**‘.Click **Create Placement** on top right corner:

![image](https://user-images.githubusercontent.com/20314643/30691489-db200cee-9e95-11e7-8398-e0cab726fe4c.png)

b. If you are serving several Tapjoy’s Video, you will need to create separate placements for mediation in CloudMobi SSP.

![image](https://user-images.githubusercontent.com/20314643/30690450-46dfe9b2-9e92-11e7-8e06-1f818f25f019.png)

Next, set the placement **Type **to ‘**a fixed location outside of gameplay (in-app store, settings etc.)**‘. This will ensure this ad placement is **user-initiated**. Click ‘**Save**‘.

c. Enter the name and description for this placement. Set the placement **Type **to ‘**a fixed location outside of gameplay (in-app store, settings etc.)**‘. This will ensure this ad placement is **user-initiated**. Click ‘**Create**‘.

![输入图片说明](https://git.oschina.net/uploads/images/2017/0921/181345_19d9762c_866297.png "屏幕截图.png")


​        

#### 2. **Virtual Currency**

Next, you need to add a virtual currency to your Tapjoy account. All content units on Tapjoy must be associated with a virtual currency. Learn more on [creating a Tapjoy Virtual currency](http://dev.tapjoy.com/virtual-currency/#setting_up_virtual_currency_in_the_tapjoy_dashboard) on the Tapjoy Knowledge Center.

a. In the Monetization tab, navigate to the **Virtual Currency **section.

![image](https://user-images.githubusercontent.com/20314643/30692090-1069ba06-9e98-11e7-915b-fb53b345c663.png)


b. Select the ‘Create Virtual Currency’ button on the top right.

![image](https://user-images.githubusercontent.com/20314643/30692126-33dcad54-9e98-11e7-8fcc-87070be59869.png)

c.  The below window will appear. Remain on the Tapjoy Managed area, as your virtual currency on Tapjoy should be a managed currency in order to work in conjunction with CloudMobi SSP platform. Fill in the relevant details:

i. **Platform**: iOS or Android

ii. **Currency Name,** e.g. coins, gold, chips, etc.

iii. **Currency Usage Description**

iv. **Exchange Rate**

v. **Initial Balance**, the currency amount your user is given when s/he starts using your app.

vi. **In-app virtual currency exchange to real world resources**: no
You can disregard the other steps as they are not required fields; leave them as is.

![image](https://user-images.githubusercontent.com/20314643/30692309-f64f8f0a-9e98-11e7-98cf-fd2934c460eb.png)


d. Click ‘**Create Now**‘ and you will then see your defined virtual currency as **Enabled **on your Virtual Currency dashboard.

![image](https://user-images.githubusercontent.com/20314643/30692404-61e637aa-9e99-11e7-9e55-d0bb9cf4395d.png)





#### 3. **Content Unit**

Lastly, you must add the relevant content card to the placement. CloudMobi SSP platform **only** supports Rewarded Video content for Tapjoy.

a. To add content to your placements, go to ‘**Monetization**‘ on the top menu bar. Navigate to ‘**Create Content**‘ on the left sidebar. You will then see the list of Tapjoy’s Monetization products. 

![输入图片说明](https://git.oschina.net/uploads/images/2017/0921/185525_a1b83f62_866297.png "屏幕截图.png")

b. Next, select the relevant ad unit you’d like to serve through CloudMobi SSP platform.

Select **Monetize**，to serve **Rewarded Video**, select **Video **by clicking ‘**Create**‘.
**Do not** select Mediated Video, as this is geared to Tapjoy’s communication within their mediation SDK.

![输入图片说明](https://git.oschina.net/uploads/images/2017/0921/185819_67264801_866297.png "屏幕截图.png")


c. Next, fill out the following form:

i. **Content Name & Description**

ii. **Platform**– if your app supports both platforms, create two separate content units for each platform.

![输入图片说明](https://git.oschina.net/uploads/images/2017/0921/190222_a9f466e0_866297.png "屏幕截图.png")

iii. **Targeting**– leave this section as is.

iv. **Placement**– select the relevant placement created to run in conjuction with CloudMobi SSP Platform.

![image](https://user-images.githubusercontent.com/20314643/30692824-257beb50-9e9b-11e7-91c2-1c48c6d152ef.png)

v. **Schedule & Frequency**– leave this section as is.

vi. **Virtual Currency**– select the virtual currency created in the former step.
**Note**: Tapjoy Content Units must be associated with a virtual currency, even if you are using CloudMobi rewards to reward your users. Learn more on [creating a Tapjoy Virtual currency](http://dev.tapjoy.com/virtual-currency/#setting_up_virtual_currency_in_the_tapjoy_dashboard) on the Tapjoy Knowledge Center.

vii. Click ‘**Save**‘.

## Step 4. Mediating Tapjoy on CloudMobi SSP  
There are a few pieces of data from your Tapjoy account which need to be inserted into your CloudMobi SSP Inventory Module in order for Tapjoy to work correctly in connection with CloudMobi:



| **SDK Key**                     | This is the unique identifier of your application in Tapjoy’s system. |
| ------------------------------- | ---------------------------------------- |
| **Publisher Reporting API Key** | This is the unique identifier for the read only report showing in CloudMobi |
| **APP ID**                      | This is the unique identifier for your application |
| **Placement Name**              | This is the unique Ad slot Name  which Tapjoy will deliver ads through. |

Once you obtain this information, you must **configure Tapjoy’s Parameters in your CloudMobi Account**. By adding the above information correctly, you will be able to take full advantage of Tapjoy’s ad inventory and reporting data on CloudMobi SSP platform.



#### 1.SDK Key

**Navigate to the ‘**Settings**‘ tab on the top menu and choose **App Settings** from the dropdown. On the **App Info **page, scroll down to the bottom of the page. Under **Application Platforms**, you’ll find the **SDK Key** for the app you want to run Tapjoy’s Video ads with on the CloudMobi SSP:



![image](https://user-images.githubusercontent.com/20314643/30693347-1e3f0f50-9e9d-11e7-8df1-9fff0a073be4.png)





#### 2. **APP ID**

On the same page as the SDK Key, simply navigate to the ‘**API Keys**‘ tab. There you will find a **Publisher Reporting API Key**:
![image](https://user-images.githubusercontent.com/20314643/30693627-7318e298-9e9e-11e7-9fa5-3c6e41eda9a7.png)



#### 3.**Reporting API Key**

On the same page as the SDK Key, simply navigate to the ‘**API Keys**‘ tab. There you will find a **Publisher Reporting API Key**:

![image](https://user-images.githubusercontent.com/20314643/30693465-b8e9a2ea-9e9d-11e7-90a2-cbfaec6726e4.png)






#### 4.**Placement Name**
Under ‘**Monetization**‘, navigate to ‘**Placements**‘ ➣ **User Initiated**tab. There you will see the **Placement Name**.
![image](https://user-images.githubusercontent.com/20314643/30693762-023f324c-9e9f-11e7-8fd5-c251add1cddc.png)



## Step 5 Configure Tapjoy’s Parameters into CloudMobi Account

Once you have all of these parameters, log in to your CloudMobi account and in the left sidebar, navigate to ‘Inventory‘ ➣ ‘Your APP‘ ➣ ‘Edit Your Rewarded video slot➣ ‘‘‘.  networks.

![image](https://user-images.githubusercontent.com/20314643/30694136-bf2b371a-9ea0-11e7-8775-2315e01176ff.png)



![image](https://user-images.githubusercontent.com/20314643/30694253-3420dd36-9ea1-11e7-9627-23573f04854e.png)



![image](https://user-images.githubusercontent.com/20314643/30694340-8ec16e72-9ea1-11e7-8f51-8080f48e1cb1.png)



![image](https://user-images.githubusercontent.com/20314643/30694384-bc0de86a-9ea1-11e7-83e7-bb907d8bf5f2.png)



Setting Tapjoy’s priority in CloudMobi Account
click “Ad Network Priority”

![image](https://user-images.githubusercontent.com/20314643/30694503-4232a1ba-9ea2-11e7-94dc-ad9b312abd75.png)