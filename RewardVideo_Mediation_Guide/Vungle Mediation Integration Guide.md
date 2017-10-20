# Vungle Mediation Integration Guide

This guide will instruct you step-by-step on how to set Vungle live as an Ad Network on the CloudMobi SSP.

## Step 1. Create a Vungle Account

1. Create an account with Vungle. You can do so [here](https://v.vungle.com/dashboard/login#newUser).
2. Once your account has been verified you can log in at their partner login [here](https://v.vungle.com/dashboard/login).

## Step 2. Create an Application in Vungle

1. Once you log in, go to the **Pub/Management** drop-down in the upper-left corner.
   Select ‘**Management**’ and scroll down the page till you see the below module. Select ‘**Add New Application**’:

   ![image](https://user-images.githubusercontent.com/20314643/30905518-0ebd6d06-a343-11e7-8666-1e4468a63099.png)

2. Define the settings of your app:

   ![image](https://user-images.githubusercontent.com/20314643/30906027-8c1c3c68-a344-11e7-960b-03ac01120935.png)

   **Platform** – iOS or Android

   **Application Name** – Enter the name of your application. If it is live in the AppStore or Google Play, Vungle will automatically import most of the settings and auto-fill the form on your behalf.
   **Category** – You can select the application Category.
   **Type** – Select Free or Paid.
   **Orientation** – Select Landscape.


3. Define **Ad Customization**Here you can define custom settings for the controls of your video ads from Vungle:

   **Frequency Cap** – We recommend 0 cap. This can be controlled for ALL Mediated Networks via CloudMobi server.

   **Force View** – We recommend keeping the ‘Force View’ settings. These improve conversion and eCPM.

   **Maximum Ad Duration** – We recommend 60+. This increases the amount of available video inventory Vungle can serve and increases total revenue potential.

   **Callback URL** – Please Leave this empty.

4. Select ‘**Submit**’ to finish:

## Step 3.  Add a Placement

Click on the relevant app from the application list and on the app’s dedicated page, click ‘**Add New Placement**‘:

![image](https://user-images.githubusercontent.com/20314643/30908903-2576f792-a34d-11e7-88bd-6a547deeaf0c.png)

Input the necessary details to create a Vungle placement:

- **Name**: Fill in the name for the placement. Vungle generates a Reference ID based on the placement name and you will not be able to edit this once you click submit.
- **Ad Unit**: Please check the **Rewarded?** box. 

![image](https://user-images.githubusercontent.com/20314643/30909067-c8c6a870-a34d-11e7-941d-1024f19106e3.png)

Then click ‘**Submit**‘. You will then see your **Reference ID **in the third column. Reserve this piece of data as you will need to enter it on our platform.

## Step 4. Activate Vungle in Your CloudMobi SSP Inventory Module

There are 3 pieces of Data from the Vungle account which need to be inserted into your CloudMObi SSP Inventory in order for Vungle to work correctly in connection with CloudMobi:

| **Vungle App ID**          | This is the unique identifier of your application in Vungle’s system. |
| -------------------------- | ---------------------------------------- |
| **Reporting API Key**      | This is a unique identifier for your Vungle account. Along with the Reporting API ID, this will allow your CloudMobi SSP to import performance data from your Vungle account. |
| **Placement Reference ID** | This is the unique Ad slot Name  which Vungle will deliver ads through. |

Once you obtain this information, you must **configure Vungle’s parameters in CloudMobi SSP.** By adding the above information correctly, you will be able to take full advantage of Vungle’s ad inventory and reporting data on CloudMobi SSP.

#### 1. Vungle Application ID

Select ‘**Details**‘ from the top Navigation panel. You will see your ‘**Account Stage**‘. Select your account and the app that you want to run Vungle Ads on through CloudMobi:

![image](https://user-images.githubusercontent.com/20314643/30910068-5a5f5752-a351-11e7-95c9-802c808d9b16.png)


![image](https://user-images.githubusercontent.com/20314643/30910253-f54ade26-a351-11e7-9e68-eca36eb247cc.png)

You will be redirected to the specific app’s page where you will be able to collect your ‘**Vungle Application ID**‘:

![image](https://user-images.githubusercontent.com/20314643/30960775-0f9c254e-a412-11e7-8a5f-fb54477bcced.png)



#### 2. Reporting API Key

Select ‘**Details**‘ from the top Navigation panel once again. You will see your ‘**Account Stage**‘. Scroll to the bottom of this page and you will spot the ‘**Users**‘ section. Here you can view the ‘**Reporting API**‘:

![image](https://user-images.githubusercontent.com/20314643/30910974-cd7f2638-a354-11e7-870b-145dd3612af0.png)



![image](https://user-images.githubusercontent.com/20314643/30911021-f5dd5e88-a354-11e7-9e96-4fdf4e3e4b1d.png)

#### 3.Reference ID
Navigate to the **Pub/Management** page and select the relevant application.

![image](https://user-images.githubusercontent.com/20314643/30911179-a1ae488a-a355-11e7-94e8-68f6d6b59d33.png)

There you will see a list of all the ad units created for this app with their placement name and Reference ID:

![image](https://user-images.githubusercontent.com/20314643/30911268-f7898ec2-a355-11e7-9b29-9b758077bd1a.png)

## Step 5. Configure Vungle’s Parameters into CloudMobi Account
   Once you have all of these parameters, log in to your CloudMobi account and in the left sidebar, navigate to ‘Inventory‘ ➣ ‘Your APP‘ ➣ ‘Edit Your Rewarded video slot➣ ‘‘‘.  networks.

![image](https://user-images.githubusercontent.com/20314643/30694136-bf2b371a-9ea0-11e7-8775-2315e01176ff.png)



![image](https://user-images.githubusercontent.com/20314643/30694253-3420dd36-9ea1-11e7-9627-23573f04854e.png)


![image](https://user-images.githubusercontent.com/20314643/30911534-00ef7e76-a357-11e7-903f-b6731ddb1c46.png)



![image](https://user-images.githubusercontent.com/20314643/30911557-1e845b64-a357-11e7-8834-285c3446c50b.png)



Setting  Vungle’s priority in CloudMobi Account
click “Ad Network Priority”

![image](https://user-images.githubusercontent.com/20314643/30911653-800cb688-a357-11e7-9be1-eb864e974ba2.png)