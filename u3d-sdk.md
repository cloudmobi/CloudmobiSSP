## Unity plugin
* support Unity4.x, Unity5.x and Unity2017;
* support iOS 7.0+;
* [click here to download SDK;](https://github.com/tianwenshi/CloudmobiSSP/raw/master/U3D-CTServiceSDK.unitypackage.zip)

## SDK setup

* Import CTService.unitypackage to your U3D project.

* Create a script and attach it to [Main Camera]. Then implement the Start function as belows.

```
using CTServiceSDK;
void Start () {
	CTService.loadRequestGetCTSDKConfigBySlot_id (slot_id);
}
```

* Setup delegate Method. We didn't call CTService.showRewardVideo() directly, We call it in delegate function. For more delegate details, you should check the [**API Reference**](#ApiReference).

```
void setupDelegates(){
	CTService.rewardVideoLoadSuccess   += CTRewardVideoLoadSuccess;
	CTService.rewardVideoLoadingFailed += CTRewardVideoLoadingFailed;
}

void CTRewardVideoLoadSuccess(){
	//Play reward video ad.
	CTService.showRewardVideo ();
}

void CTRewardVideoLoadingFailed(string error){
	Debug.Log (error);
}
```

*  Call interface to request reward video ads. When an ad is loaded successfully, callback function 'rewardVideoLoadSuccess' is invoked 

```
void loadRewardVideoBtnClick(){
	CTService.loadRewardVideoWithSlotId (slot_id);
}
```

*  Build Xcode project. For Unity4.x or Unity5.x you need to copy CTService.Framework and CTServiceCWrapper.mm to your Xcode project manually or using other method.
*  Add a static link to: Build Settings -> Other Linker Flags -> -ObjC
*  In Info.plist added the NSAppTransportSecurity, the type for Dictionary. In NSAppTransportSecurity added the NSAllowsArbitraryLoads the Boolean,setting YES.

### <a name="ApiReference">SDK API reference</a> 
```
/**
Get CT AD Config in Appdelegate(didFinishLaunchingWithOptions:)
@param slot_id Ad
*/
public static void loadRequestGetCTSDKConfigBySlot_id(string slot_id)


/**
*  Get RewardVideo Ad
*  First,you must should Call (loadRewardVideoWithSlotId) method get RewardVideo Ad！Then On his return to the success of the *proxy method invokes the （showRewardVideo） method
@param slot_id         Cloud Tech AD ID
*/
public static void loadRewardVideoWithSlotId(string slot_id)


/**
*  show RewardVideo
*  you should call it in the rewardVideoLoadSuccess delegate function.
 */
public static void showRewardVideo()		


/**
CTReward video ad delegate
*/

/**
*  video loaded successfully delegate, you can call showRewardVideo() in this function.
**/
public static event Action rewardVideoLoadSuccess;


/**
*  video loaded failed delegate, you cannot showRewardVideo();
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
*   user clicking Ads delegate
**/
public static event Action rewardVideoDidClickRewardAd;


/**
*  will leave Application delegate
**/
public static event Action rewardVideoWillLeaveApplication;


/**
*  jumping AppStroe failure delegate
**/
public static event Action rewardVideoJumpfailed;


/**
*  reward video ad information delegate
**/
public static event Action<string> rewardVideoAdRewardedName;


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
	public string slot_id = "260";
	void Start () {
		CTService.loadRequestGetCTSDKConfigBySlot_id (slot_id);
	}
}
```

**CTCanvas.cs** attaches to a Unity GameObject which you'd like to show a reward video.

```
using CTServiceSDK;

public class CTCanvas : MonoBehaviour {
	public string slot_id = "260";
	public Button loadRewardVideoBtn;
	void Start () {
		loadRewardVideoBtn.onClick.AddListener (loadRewardVideoBtnClick);
		setupDelegates ();
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
		CTService.rewardVideoAdRewardedName += CTRewardVideoAdRewardedName;
		CTService.rewardVideoClosed += CTRewardVideoClosed;
	}
		
	//load reward video
	void loadRewardVideoBtnClick(){
		CTService.loadRewardVideoWithSlotId (slot_id);
	}
		
	/**
	 * 
	 * reward video delegate
	 * 
	 * delegate method names should be the same as follows
	 * 
	 * */

	//video load success
	void CTRewardVideoLoadSuccess(){
		Debug.Log ("U3D delegate, CTRewardVideoLoadSuccess");
		//show rewardvideo
		CTService.showRewardVideo ();
	}

	//video load failure
	void CTRewardVideoLoadingFailed(string error){
		Debug.Log ("U3D delegate, CTRewardVideoLoadingFailed");
		Debug.Log (error);
	}
		
	//start playing video
	void CTRewardVideoDidStartPlaying(){
		Debug.Log ("U3D delegate, CTRewardVideoDidStartPlaying");
	}

	//finish playing video
	void CTRewardVideoDidFinishPlaying(){
		Debug.Log ("U3D delegate, CTRewardVideoDidFinishPlaying");
	}

	//click ad
	void CTRewardVideoDidClickRewardAd(){
		Debug.Log ("U3D delegate, CTRewardVideoDidClickRewardAd");
	}
		
 	//will leave Application
	void CTRewardVideoWillLeaveApplication(){
		Debug.Log ("U3D delegate, CTRewardVideoWillLeaveApplication");
	}
		
	//jump to AppStroe failed
	void CTRewardVideoJumpfailed(){
		Debug.Log ("U3D delegate, CTRewardVideoWillLeaveApplication");
	}

	//get rewardvideo message
	void CTRewardVideoAdRewardedName(string rewardVideoNameAndAmount){
		Debug.Log ("U3D delegate, rewardVideoNameAndAmount");
		Debug.Log (rewardVideoNameAndAmount);
	}

	//close video ad
	void CTRewardVideoClosed(){
		Debug.Log ("U3D delegate, CTRewardVideoClosed");
	}
}
```
