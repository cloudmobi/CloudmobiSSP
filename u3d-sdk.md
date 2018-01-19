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
void Start () {
	//setup delegate
	setupDelegates ();
	//load rewardvideo ad
	CTService.loadRewardVideoWithSlotId (slot_id);
}

void OnEnable() {
	CTService.rewardVideoLoadSuccess   += CTRewardVideoLoadSuccess;
	CTService.rewardVideoLoadingFailed += CTRewardVideoLoadingFailed;
}

void OnDisable(){
	CTService.rewardVideoLoadSuccess -= CTRewardVideoLoadSuccess;
	CTService.rewardVideoLoadingFailed -= CTRewardVideoLoadingFailed;
}

void OnDestroy(){
	CTService.release ();
}

void CTRewardVideoLoadSuccess(){

}

void CTRewardVideoLoadingFailed(string error){
	Debug.Log ("U3D delegate, CTRewardVideoLoadingFailed. " + error);
}

```

* For more delegate details, you should check the [**API Reference**](#ApiReference).

* Implement a button click event to check if we can show rewarded video ad.

```
void playBtnClick(){
	//show reward video if it's avalable
	if(CTService.checkRewardVideoIsReady ())
		CTService.showRewardVideo (slot_id);
	else
		Debug.Log ("CT Rewarded Video is not ready");
}
```

 **iOS**
 
*  Build Xcode project. For Unity4.x or Unity5.x you need to copy CTService.Framework and CTServiceCWrapper.mm to your Xcode project manually or using other method.
*  Add a static link to: Build Settings -> Other Linker Flags -> -ObjC
*  In Info.plist added the NSAppTransportSecurity, the type for Dictionary. In NSAppTransportSecurity added the NSAllowsArbitraryLoads the Boolean,setting YES.

 **Android**

 * Open 'File' -> 'Build Settings' -> 'Player Settings', and make sure 'Minimum API Level' later than 'API Level 15'. We recommen using the latest version of Android SDK and Build Tools.
 * Select SDK folder Plugin->Android->CTServiceSDK in Project. Check the Andorid box in the inspector.
 
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
* Check if RewardVideo is read 
* if true, you can call showRewardVideo;
*/
public static bool checkRewardVideoIsReady()

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
	#if UNITY_ANDROID
	public string slot_id = "1601";
	#elif UNITY_IOS
	public string slot_id = "260";
	#endif

	void Awake () {
		CTService.loadRequestGetCTSDKConfigBySlot_id (slot_id);
	}
}
```

**CTCanvas.cs** attaches to a Unity GameObject which you'd like to show a reward video.

```
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using CTServiceSDK;

public class CTCanvas : MonoBehaviour {
	#if UNITY_ANDROID
	public string slot_id = "1601";
	#elif UNITY_IOS
	public string slot_id = "260";
	#endif
	//notice: attach your UI objcet here
	public Button loadBtn;
	public Button playBtn;
	public Text statusText;

	void Start () {
		playBtn.onClick.AddListener (playBtnClick);
		loadBtn.onClick.AddListener (loadBtnClick);
		//set delegate
		setupDelegates ();
		//Notice: load rewardvideo ad when you init UI.
		CTService.loadRewardVideoWithSlotId (slot_id); 
	}
	
	void OnDestroy(){
		//do not forget to call release, otherwise it will casue memory leak on android platform.
		CTService.release ();
	}
	
	void OnEnable() {
		setupDelegates();
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
	
	void OnDisable(){
		CTService.rewardVideoLoadSuccess -= CTRewardVideoLoadSuccess;
		CTService.rewardVideoLoadingFailed -= CTRewardVideoLoadingFailed;
		CTService.rewardVideoDidStartPlaying -= CTRewardVideoDidStartPlaying;
		CTService.rewardVideoDidFinishPlaying -= CTRewardVideoDidFinishPlaying;
		CTService.rewardVideoDidClickRewardAd -= CTRewardVideoDidClickRewardAd;
		CTService.rewardVideoWillLeaveApplication -= CTRewardVideoWillLeaveApplication;
		CTService.rewardVideoJumpfailed -= CTRewardVideoJumpfailed;
		CTService.rewardVideoAdRewarded -= CTRewardVideoAdRewarded;
		CTService.rewardVideoClosed -= CTRewardVideoClosed;
	}

	//Notice: You should call this api as soon as you can. For example, call it in Start function.(not in awake, beacause we must call CTService.loadRequestGetCTSDKConfigBySlot_id first in camera awake function)
	//For convenience test, we add a button to click.
	void loadBtnClick(){
		//load rewardvideo ad
		CTService.loadRewardVideoWithSlotId (slot_id);
	}

	void playBtnClick(){
		//you can also use this api to check if rewearded video is ready.
		if (CTService.checkRewardVideoIsReady ()) {
			setReady (true);
			CTService.showRewardVideo (slot_id);
		}
		else
			Debug.Log ("CT Rewarded Video is not ready");
	}

	void setReady(bool isReady){
		if (isReady) {
			statusText.color = Color.green; 
			statusText.text = "isReadyToPlay: Yes";
		} else {
			statusText.color = Color.red; 
			statusText.text = "isReadyToPlay: No";
		}
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
		setReady (true);
		Debug.Log ("U3D delegate, CTRewardVideoLoadSuccess");
	}

	//video load failure
	void CTRewardVideoLoadingFailed(string error){
		setReady (false);
		Debug.Log ("U3D delegate, CTRewardVideoLoadingFailed. " + error);
	}
		
	//start playing video
	void CTRewardVideoDidStartPlaying(){
		Debug.Log ("U3D delegate, CTRewardVideoDidStartPlaying");
	}

	//finish playing video
	void CTRewardVideoDidFinishPlaying(){
		Debug.Log ("U3D delegate, CTRewardVideoDidFinishPlaying");
	}

	//click ad, only for iOS
	void CTRewardVideoDidClickRewardAd(){
		Debug.Log ("U3D delegate, CTRewardVideoDidClickRewardAd");
	}
		
	//will leave Application, only for iOS
	void CTRewardVideoWillLeaveApplication(){
		Debug.Log ("U3D delegate, CTRewardVideoWillLeaveApplication");
	}
		
	//jump to AppStroe failed, only for iOS
	void CTRewardVideoJumpfailed(){
		Debug.Log ("U3D delegate, CTRewardVideoWillLeaveApplication");
	}

	//players get rewarded here
	void CTRewardVideoAdRewarded(string rewardVideoNameAndAmount){
		Debug.Log ("U3D delegate, CTRewardVideoAdRewarded, " + rewardVideoNameAndAmount);
	}

	//close video ad
	void CTRewardVideoClosed(){
		Debug.Log ("U3D delegate, CTRewardVideoClosed");
		setReady (false);
	}
}

```

## Release Notes
*  Version 1.0.1  [release date: 2017-12-19]
	1. fix iOS bug: Solve problem that frequent switching tasks make video stuck .
	2. fix Andorid bug: Memory Leak.
	
*  Version 1.0.2  [release date: 2018-01-08]
	1. new iOS feature: creatives optimaztion.

*  Version 1.0.3  [release date: 2018-01-10]
	1. fix ANR problem.
	
*  Version 1.0.4  [release date: 2018-01-17]
	1. enable iOS bitcode.
	
*  Version 1.0.5  [release date: 2018-01-19]
	1. fit iPad endCard.
