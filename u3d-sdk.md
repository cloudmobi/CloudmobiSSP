## Unity plugin
* support rewarded video only;
* support Unity4.x, Unity5.x, Unity2017;
* support iOS 7.0+;
* support Android API Level 15+;
* [click here to download SDK;](https://github.com/cloudmobi/CloudmobiSSP/blob/master/U3D-CTServiceSDK.unitypackage.zip)

## SDK setup

* Import CTService.unitypackage to your U3D project.

* Create a script and attach it to [Main Camera]. Then implement the Awake function as belows.

```
using CTServiceSDK;
void Awake () {
	CTService.loadRequestGetCTSDKConfigBySlot_id (slot_id);
}
```

* Create a script and attach it to a Unity UIController which you'd like to show rewarded video on. Then implement the Start function as belows.

```
private bool isRewardVideoAvalable = false;
void Start () {
	//setup delegate
	setupDelegates ();
	//load rewardvideo ad
	CTService.loadRewardVideoWithSlotId (slot_id);
}

void setupDelegates(){
	CTService.createDelegateObj ();
	CTService.rewardVideoLoadSuccess   += CTRewardVideoLoadSuccess;
	CTService.rewardVideoLoadingFailed += CTRewardVideoLoadingFailed;
}

void CTRewardVideoLoadSuccess(){
	isRewardVideoAvalable = true;
}

void CTRewardVideoLoadingFailed(string error){
	isRewardVideoAvalable = false;
}

```

* For more delegate details, you should check the [**API Reference**](#ApiReference).

* Implement a button click event to check if we can show rewarded video ad.

```
void playBtnClick(){
	//show reward video if it's avalable
	if(isRewardVideoAvalable == true)
		CTService.showRewardVideo (slot_id);
}
```

 **iOS**
 
*  Build Xcode project. For Unity4.x or Unity5.x you need to copy CTService.Framework and CTServiceCWrapper.mm to your Xcode project manually or using other method.
*  Add a static link to: Build Settings -> Other Linker Flags -> -ObjC
*  In Info.plist added the NSAppTransportSecurity, the type for Dictionary. In NSAppTransportSecurity added the NSAllowsArbitraryLoads the Boolean,setting YES.

 **Android**

 * Open 'File' -> 'Build Settings' -> 'Player Settings', and make sure 'Minimum API Level' later than 'API Level 15'. We recommen using the latest version of Android SDK and Build Tools.
 
### <a name="ApiReference">SDK API reference</a> 
```
/**
Get CT AD Config in Appdelegate(didFinishLaunchingWithOptions:)
@param slot_id Ad
*/
public static void loadRequestGetCTSDKConfigBySlot_id(string slot_id)


/**
*  Get RewardVideo Ad
*  Call (loadRewardVideoWithSlotId) method get RewardVideo Ad！
@param slot_id         Cloud Tech AD ID
*/
public static void loadRewardVideoWithSlotId(string slot_id)


/**
*  show RewardVideo
*  you should call it after rewardVideoLoadSuccess delegate function is invoked.
 */
public static void showRewardVideo()		


/**
CTReward video ad delegate
*/

/**
*  video loaded successfully delegate. You shoud not call 'showRewardVideo' here, for android sdk would preload rewardedvideos, it may call this function serveral times.
**/
public static event Action rewardVideoLoadSuccess;


/**
*  video loaded failed delegate
**/
public static event Action<string> rewardVideoLoadingFailed;


/**
*  begin playing Ad delegate
**/
public static event Action rewardVideoDidStartPlaying;


/**
*   playing Ad finished delegate
**/
public static event Action rewardVideoDidFinishPlaying;


/**
*   user clicking Ads delegate only for iOS
**/
public static event Action rewardVideoDidClickRewardAd;


/**
*  will leave Application delegate only for iOS
**/
public static event Action rewardVideoWillLeaveApplication;


/**
*  jumping AppStroe failure delegate only for iOS
**/
public static event Action rewardVideoJumpfailed;


/**
*  reward the player here
**/
public static event Action<string> rewardVideoAdRewarded;


/**
*  reward video ad closed delegate
**/
public static event Action rewardVideoClosed;
		
```

## Sample Code

 **CTCamera.cs** attaches to [Main Camera]
 
```
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using CTServiceSDK;

public class CTCamera : MonoBehaviour {
	public string slot_id_android = "1601";
	public string slot_id_ios = "260";

	void Awake () {
		CTService.loadRequestGetCTSDKConfigBySlot_id (slot_id_ios);
	}
}
```

**CTCanvas.cs** attaches to a Unity GameObject which you'd like to show a reward video.

```
public class CTCanvas : MonoBehaviour {
	public string slot_id_android = "1601";
	public string slot_id_ios = "260";
	public Button playBtn;
	private bool isRewardVideoAvalable = false;

	void Start () {
		playBtn.onClick.AddListener (playBtnClick);
		//set delegate
		setupDelegates ();
		//load rewardvideo ad
		CTService.loadRewardVideoWithSlotId (slot_id_ios);
	}

	//set delegate
	void setupDelegates(){
		CTService.rewardVideoLoadSuccess += CTRewardVideoLoadSuccess;
		CTService.rewardVideoLoadingFailed += CTRewardVideoLoadingFailed;
		CTService.rewardVideoDidStartPlaying += CTRewardVideoDidStartPlaying;
		CTService.rewardVideoDidFinishPlaying += CTRewardVideoDidFinishPlaying;
		CTService.rewardVideoDidClickRewardAd += CTRewardVideoDidClickRewardAd;
		CTService.rewardVideoWillLeaveApplication += CTRewardVideoWillLeaveApplication;
		CTService.rewardVideoJumpfailed += CTRewardVideoJumpfailed;
		CTService.rewardVideoAdRewarded += CTRewardVideoAdRewarded;
		CTService.rewardVideoClosed += CTRewardVideoClosed;
	}

	void playBtnClick(){
		//show reward video if it's ready
		if(isRewardVideoAvalable == true)
			CTService.showRewardVideo (slot_id_ios);
	}
		
	/**
	 * 
	 * reward video delegate
	 * 
	 * delegate method names should be the same as follows
	 * 
	 * */

	//video load success. 
	//Do not show reward video in the function, for android sdk preloads ads, may call this function several times.
	void CTRewardVideoLoadSuccess(){
		Debug.Log ("U3D delegate, CTRewardVideoLoadSuccess");
		isRewardVideoAvalable = true;
	}

	//video load failure
	void CTRewardVideoLoadingFailed(string error){
		Debug.Log ("U3D delegate, CTRewardVideoLoadingFailed");
		Debug.Log (error);
		isRewardVideoAvalable = false;
	}
		
	//start playing video
	void CTRewardVideoDidStartPlaying(){
		Debug.Log ("U3D delegate, CTRewardVideoDidStartPlaying");
	}

	//finish playing video
	void CTRewardVideoDidFinishPlaying(){
		Debug.Log ("U3D delegate, CTRewardVideoDidFinishPlaying");
	}

	//click ad , only for iOS
	void CTRewardVideoDidClickRewardAd(){
		Debug.Log ("U3D delegate, CTRewardVideoDidClickRewardAd");
	}
		
 	//will leave Application , only for iOS
	void CTRewardVideoWillLeaveApplication(){
		Debug.Log ("U3D delegate, CTRewardVideoWillLeaveApplication");
	}
		
	//jump to AppStroe failed , only for iOS
	void CTRewardVideoJumpfailed(){
		Debug.Log ("U3D delegate, CTRewardVideoWillLeaveApplication");
	}

	//get rewardvideo message
	void CTRewardVideoAdRewarded(string rewardVideoNameAndAmount){
		Debug.Log ("U3D delegate, CTRewardVideoAdRewarded");
		Debug.Log (rewardVideoNameAndAmount);
	}

	//close video ad
	void CTRewardVideoClosed(){
		Debug.Log ("U3D delegate, CTRewardVideoClosed");
	}
}
```
