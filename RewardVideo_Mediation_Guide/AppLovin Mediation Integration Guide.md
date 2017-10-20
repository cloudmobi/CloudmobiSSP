# AppLovin Mediation Integration Guide

This guide will instruct you step-by-step on how to set AppLovin live as an Ad Network on the CloudMobi SSP platform.

## Step 1. Create an AppLovin Account

1. Create an account with AppLovin. You can do so [here](https://www.applovin.com/signup).
2. Once your account has been verified you can login at their partner login [here](https://www.applovin.com/login).

## Step 2. Retrieve Your AppLovin SDK/Application Key

AppLovin automatically creates an application in your account after the first Ad Request is made with their SDK in your app, so you don’t need to specifically create one on their Admin site. The App package name in your account must be the same as the app package name defined in your **CloudMobi SSP** Inventory APP Page.

The next step is to grab your ‘**SDK Key**‘ from your AppLovin account and add the AppLovin Adapter to your build.

1. Log in to your AppLovin account and select ‘**Get Started**’:

![image](https://user-images.githubusercontent.com/20314643/30895286-3c69d342-a317-11e7-8313-5a023238f2d4.png)

2. Select the **Platform** your application is built on:

![image](https://user-images.githubusercontent.com/20314643/30898769-e809d1bc-a32a-11e7-961c-87bf074e31b4.png)

3. On the following page you will see your ‘**SDK Key**‘ listed:

![image](https://user-images.githubusercontent.com/20314643/30899269-35c12fc0-a32d-11e7-97bc-9c4a7bf76be5.png)

With this key in hand, you can easily add AppLovin to your CloudMobi SSP account.

4. Setting rewarded video on AppLovin

   i. Turn on the rewarded video

   ii. Display pre-video model: **No**

   iii.Display post-video model: **No**

   vi.Callback Options:**client side callback only**

![image](https://user-images.githubusercontent.com/20314643/30904938-6c814a90-a341-11e7-9a30-99986f313f24.png)

## Step 3. Activate AppLovin on the CloudMobi SSP

There are 2 pieces of data from the AppLovin account which need to be inserted into your CloudMobi Ad Network mediation Module in order for AppLovin to work correctly in connection with CloudMobi:

| **Report API Key**           | This is a unique identifier for your AppLovin account, which allows your CloudMobi SSP Platform to import performance data from your AppLovin account to use in reporting & optimization. |
| ---------------------------- | ---------------------------------------- |
| **SDK Key**                  | This is a unique identifier for your AppLovin account. This is used by the CloudMobi SDK to Init the AppLovin Adapter for your apps. |
| **Placement Name(optional)** | This is the unique Ad slot Name  which AppLovin will deliver ads through |

Once you obtain this information, you must **configure the AppLovin parameters in your CloudMobi Account.** By adding the above information correctly, you will be able to take full advantage of AppLovin’s ad inventory and reporting data on CloudMobi’s Mediation platform.

* Note please keep your package name in CloudMobi SSP is the same with the package name in AppLovin

  ![image](https://user-images.githubusercontent.com/20314643/30904770-eb64a966-a340-11e7-9a0c-6f80992b480c.png)

1. #### Report Key

   To find the ‘Report Key’, go to the ‘Account’ tab and select ‘Keys’ from the left side menu.

![image](https://user-images.githubusercontent.com/20314643/30899589-7b39c35e-a32e-11e7-97cd-067fe4f9455c.png)

2. #### SDK Key

   To find the ‘**SDK** **Key**‘, go to the ‘**Account**‘ tab and select ‘**Keys**‘ from the left side menu.

   ![image](https://user-images.githubusercontent.com/20314643/30899696-fa52553e-a32e-11e7-8373-032e632b9dbe.png)

   **Configure AppLovin’s Parameters into CloudMobi SSP**

   - Once you have both of these parameters, log in to your CloudMobi account and go to ‘**Inventory**‘ ➣ ‘**Create Ad Space**‘ ➣ ‘**Ad Network Mediation** ****‘.


-    Select AppLovin from the table of **Available Ad Networks**and enter the AppLovin ‘**Report** **Key**‘.



3. #### Placement Name

To find the ‘**Placement Name**‘, go to the ‘**Monetize**‘ tab and select ‘**Manage Apps**‘ from the left side menu.

![image](https://user-images.githubusercontent.com/20314643/30964665-5bc2741a-a420-11e7-8524-b4fe0bddd9b9.png)


![image](https://user-images.githubusercontent.com/20314643/30965136-451ebb5e-a422-11e7-8c76-1e238fc5cade.png)
Then select the app you are integrated in, at the bottom of the page, you will see the placement name.

If you never created any placements before, there will be no placement name showing.
If you have created some placements, there will be a placement list below the input fieled. 

![image](https://user-images.githubusercontent.com/20314643/30965191-72fe9ba2-a422-11e7-8d74-eea268679de6.png)






## Step 4. Configure AppLovin’s Parameters into CloudMobi Account
   Once you have all of these parameters, log in to your CloudMobi account and in the left sidebar, navigate to ‘Inventory‘ ➣ ‘Your APP‘ ➣ ‘Edit Your Rewarded video slot➣ ‘‘‘.  networks.

   ![image](https://user-images.githubusercontent.com/20314643/30694136-bf2b371a-9ea0-11e7-8775-2315e01176ff.png)

   

   ![image](https://user-images.githubusercontent.com/20314643/30694253-3420dd36-9ea1-11e7-9627-23573f04854e.png)

   

   ![image](https://user-images.githubusercontent.com/20314643/30902354-f48c785a-a338-11e7-9a31-142d4576a617.png)

   

   ![image](https://user-images.githubusercontent.com/20314643/30902546-99441a56-a339-11e7-9b7b-6b3e192f386b.png)

   

Setting  AppLovin’s priority in CloudMobi Account
click “Ad Network Priority”

   ![image](https://user-images.githubusercontent.com/20314643/30902682-25fe763a-a33a-11e7-8a56-603a61ef13ef.png)