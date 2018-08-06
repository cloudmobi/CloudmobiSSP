# Getting Started with the Cloudmobi Unity Plugin

* [Before You Start](#start)
* [SDK Set Up](#step1)
  - [Rewarded Video](#rewardedvideo)
  - [Interstitial](#interstitial)
* [Additional Settings for iOS](#step2)
* [Additional Settings for Android](#step3)
* [Cloudmobi SDK API Reference](#ApiReference)
* [Sample Code](#sample_code)
* [SDK Release Notes](https://github.com/cloudmobi/CloudmobiSSP/blob/master/Unity_Release_Notes.md)
## <a name="start">Before You Start</a>


* Support rewarded video only;
* Support Unity4.x, Unity5.x, Unity2017;
* Support iOS 7.0+;
* Support Android API Level 15+;
* [Click Here to Download Latest SDK;](https://github.com/cloudmobi/CloudmobiSSP/blob/master/U3D-CTServiceSDK.unitypackage.zip)

## <a name="step1">Step 1. Cloudmobi Unity SDK Set Up</a>

* Import CTService.unitypackage to your U3D project.

* Create a script and attach it to [Main Camera]. Then implement the Awake function as belows.

```
using CTServiceSDK;
void Awake () {
	CTService.loadRequestGetCTSDKConfigBySlot_id (slot_id);
	CTService.uploadConsent ("yes", "GDPR");
}
```

* Use this interface to upload consent from affected users.
```
	CTService.uploadConsent (consentValue, consentType);
```

###  <a name="rewardedvideo">Adding the RewardVideo Ad API in iOS</a>

* [For Rewarded Video] Create a script and attach it to a Unity UIController which you'd like to show rewarded video on. Then implement the Start function as belows.

```
void Start () {
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
* [For Rewarded Video] Implement a button click event to check if we can show rewarded video ad.For the first time you request rewarded video ads, you may need to try serveral times.Because it takes some time to download video files.Once a video file downloads completely, it will response immediately.

```
void playBtnClick(){
	//show reward video if it's avalable
	if(CTService.checkRewardVideoIsReady ())
		CTService.showRewardVideo (slot_id);
	else
		Debug.Log ("CT Rewarded Video is not ready");
}
```

### <a name="interstitial">Adding the Interstitial Ad API in iOS</a>

* [For Interstitial] Create a script and attach it to a Unity UIController which you'd like to show intersitial ad on. Then implement the Start function as belows.

```
void Start () {
	//load interstitial ad
	CTService.preloadInterstitialWithSlotId (slot_id);
}

void OnEnable() {
	CTService.interstitialLoadSuccess   += CTInterstitialLoadSuccess;
	CTService.interstitialLoadFailed += CTInterstitialLoadingFailed;
}

void OnDisable(){
	CTService.interstitialLoadSuccess -= CTInterstitialLoadSuccess;
	CTService.interstitialLoadFailed -= interstitialLoadFailed;
}

void OnDestroy(){
	CTService.release ();
}

void CTInterstitialLoadSuccess(){

}

void CTInterstitialLoadingFailed(string error){
	Debug.Log ("U3D delegate, CTInterstitialLoadFailed. " + error);
}
```

* [For Interstitial] Implement a button click event to check if we can show rewarded video ad.

```
void showBtnClick(){
	//show interstitial if it's avalable
	if(CTService.isInterstitialAvailable ())
		CTService.showInterstitial ();
	else
		Debug.Log ("CT Interstitial is not ready");
}
```

* For more delegate details, you should check the [**API Reference**](#ApiReference).


## <a name="step2">Additional Settings for iOS</a>
 
*  For Unity4.x you need to do some configuration or using other method to do that(eg: XUPorter):
	- 1.Build Xcode project.
	- 2.copy CTService.Framework and CTServiceCWrapper.mm to your Xcode project manually.
	- 3.Add a static link to: Build Settings -> Other Linker Flags -> -ObjC
	- 4.In Info.plist added the NSAppTransportSecurity, the type for Dictionary. In NSAppTransportSecurity added the NSAllowsArbitraryLoads the Boolean,setting YES.
	- 5.Import libz.tbd in Project -> Target -> Build Phases -> Link Binary With Libraries.
	
*  For Unity 5(include 2017 and 2018), you could import OnPostProcessBuild.cs to Editor directory. It will config plist and xcode building property for you (eg: add a static link to Other Linker Flags with '-ObjC' and add NSAppTransportSecurity in the plist). 

*  For Unity Cloud Build, you must import OnPostProcessBuild.cs to Editor directory. Then Collab with Unity Cloud and build.

## <a name="step3">Additional Settings for Android</a>

* Open 'File' -> 'Build Settings' -> 'Player Settings', and make sure 'Minimum API Level' later than 'API Level 15'. We recommen using the latest version of Android SDK and Build Tools.
* Select SDK folder Plugin->Android->CTServiceSDK in Project. Check the Andorid box in the inspector.

## <a name="ApiReference">SDK API reference</a>

```
/**
Get CT AD Config in Appdelegate(didFinishLaunchingWithOptions:)
@param slot_id Ad
*/
public static void loadRequestGetCTSDKConfigBySlot_id(string slot_id)

/**
Use this interface to upload consent from affected users 
@param consentValue: "yes"/"no"
@param consentType: "GDPR" or something else
*/
public static void uploadConsent(string consentValue, string consentType)

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


/**
 Get Interstitial Ad
 First,you should Call (loadInterstitialWithSlotId) method get Interstitial！
 Then On his success delegate method invokes (showInterstitia） method
@param slot_id         Cloud Tech AD ID
 */
public static void preloadInterstitialWithSlotId(string slot_id)
		
/**
show showInterstitial	you should call it in the loadInterstitialWithSlotId delegate function.
*/
public static void showInterstitial()
		
/**
Check if Interstitial is read 

if true, you can call showInterstitial;
*/
public static bool isInterstitialAvailable()
		
/**
*  Interstitial is loaded successfully, you can call showInterstitial() in this function.
**/
public static event Action interstitialLoadSuccess;

/**
*  Interstitial is loaded failed;
**/
public static event Action<string> interstitialLoadFailed;

/**
*   user click Ads
**/
public static event Action interstitialDidClickRewardAd;

/**
*  jump AppStroe failed
**/
public static event Action interstitialJumpfailed;

/**
*  Interstitial is hidden
**/
public static event Action interstitialClose;	
```




##  <a name="sample_code"> Sample Code </a>

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
		CTService.uploadConsent ("yes", "GDPR");
	}
}
```

**CTRewardedVideo.cs** attaches to a Unity GameObject which you'd like to show rewarded video.

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
**CTInterstitial.cs** attaches to a Unity GameObject which you'd like to show interstitail.

```
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using CTServiceSDK;

public class CTInterstitial : MonoBehaviour {
	#if UNITY_ANDROID
	public string slot_id = "248";
	#elif UNITY_IOS
	public string slot_id = "82095565";
	#endif
	//notice: attach your UI objcet here
	public Button loadBtn;
	public Button showBtn;
	public Text statusText;

	// Use this for initialization
	void Start () {
		showBtn.onClick.AddListener (showBtnClick);
		loadBtn.onClick.AddListener (loadBtnClick);
		//Notice: load Interstitial ad when you init UI.
		CTService.preloadInterstitialWithSlotId (slot_id); 
	}
	
	void OnEnable() {
		setupDelegates();
	}

	//set delegate
	void setupDelegates(){
		CTService.interstitialLoadSuccess += CTInterstitialLoadSuccess;
		CTService.interstitialLoadFailed += CTInterstitialLoadingFailed;
		CTService.interstitialDidClickRewardAd += CTInterstitialDidClickAd;
		CTService.interstitialClose += CTInterstitialClose;
	}

	void OnDisable(){
		CTService.interstitialLoadSuccess -= CTInterstitialLoadSuccess;
		CTService.interstitialLoadFailed -= CTInterstitialLoadingFailed;
		CTService.interstitialDidClickRewardAd -= CTInterstitialDidClickAd;
		CTService.interstitialClose -= CTInterstitialClose;
	}

	void OnDestroy(){
		//do not forget to call release, otherwise android platform will casue memory leak.
		CTService.release ();
	}

	void setReady(bool isReady, string msg){
		if (isReady) {
			statusText.color = Color.green; 
			statusText.text = "isReadyToShow: Yes";
		} else {
			statusText.color = Color.red; 
			statusText.text = msg;
		}
	}

	//Notice: You should call this api as soon as you can. For example, call it in Start function.(not in awake, beacause we must call CTService.loadRequestGetCTSDKConfigBySlot_id first in camera awake function)
	//For convenience test, we add a button to click.
	void loadBtnClick(){
		//load Interstitial ad
		CTService.preloadInterstitialWithSlotId (slot_id);
		Debug.Log ("CT Interstitial loadBtnClick");
	}

	void showBtnClick(){
		//you can also use this api to check if Interstitial is ready.
		if (CTService.isInterstitialAvailable ()) {
			setReady (true, null);
			CTService.showInterstitial ();
		}
		else
			Debug.Log ("CT Interstitial is not ready");
	}


	/**
	 * 
	 * Interstitial delegate
	 * 
	 * */
	void CTInterstitialLoadSuccess(){
		Debug.Log ("U3D delegate, CTInterstitialLoadSuccess");
		setReady (true, null);
	}

	void CTInterstitialLoadingFailed(string error){
		setReady (false, error);
		Debug.Log ("U3D delegate, CTInterstitialLoadingFailed. " + error);
	}

	void CTInterstitialDidClickAd(){
		Debug.Log ("U3D delegate, CTInterstitialDidClickAd");
	}

	void CTInterstitialClose(){
		Debug.Log ("U3D delegate, CTInterstitialClose");
		setReady (false, @"isReadyToShow: NO");
	}
}
```
**CTOnPostProcessBuild.cs** added to assets/editor directory.
```
using UnityEngine;
using System.IO;

#if UNITY_EDITOR
using UnityEditor;
using UnityEditor.Callbacks;
using UnityEditor.iOS.Xcode;
using System.Xml;
#endif

public class CTOnPostProcessBuild : Editor {
	#if UNITY_IOS || UNITY_EDITOR  

	[PostProcessBuild (100)]
	public static void OnPostprocessBuild(BuildTarget BuildTarget, string path)  
	{  
		if (BuildTarget == BuildTarget.iOS)  
		{  
			string projPath = PBXProject.GetPBXProjectPath(path);  
			PBXProject proj = new PBXProject();  
			proj.ReadFromString(File.ReadAllText(projPath));  
			 
			//add Other link flag
			string target = proj.TargetGuidByName(PBXProject.GetUnityTargetName());  
			proj.AddBuildProperty (target, "OTHER_LDFLAGS", "-ObjC");
			File.WriteAllText(projPath, proj.WriteToString()); 

			//add framework
			proj.AddFrameworkToProject (target, "AdSupport.framework", false);  
			proj.AddFrameworkToProject (target, "StoreKit.framework", false);  
			proj.AddFrameworkToProject (target, "AVFoundation.framework", false);  
			proj.AddFrameworkToProject (target, "SystemConfiguration.framework", false);  
			proj.AddFrameworkToProject (target, "JavaScriptCore.framework", false);  
			proj.AddFrameworkToProject (target, "ImageIO.framework", false);  
			proj.AddFrameworkToProject (target, "UIKit.framework", false);  
            		proj.AddFrameworkToProject (target, "libz.1.tbd", false); 
			File.WriteAllText(projPath, proj.WriteToString()); 

			//add ATS in plist
			string plistPath = path + "/Info.plist";  
			PlistDocument plist = new PlistDocument();  
			plist.ReadFromString(File.ReadAllText(plistPath));  
			PlistElementDict dictTransportSecurity = plist.root ["NSAppTransportSecurity"].AsDict ();
			dictTransportSecurity.SetBoolean("NSAllowsArbitraryLoads",true);
			File.WriteAllText(plistPath, plist.WriteToString());
		}  
	}  

	#endif
}
```
