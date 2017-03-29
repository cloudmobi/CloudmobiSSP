//
//  Tools.h
//  iOS-CTSDK-Demo
//
//  Created by 兰旭平 on 2016/12/27.
//  Copyright © 2016年 com.algorithms.lxp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCJHUD.h"
#define XPWidth                 self.view.frame.size.width
#define XPHeight                self.view.frame.size.height

@interface Tools : NSObject
@property (nonatomic, strong)ZCJHUD *hud;
//solve block Circular referencT
#ifndef    weakify
#if __has_feature(objc_arc)

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __weak __typeof__(x) __weak_##x##__ = x; \
_Pragma("clang diagnostic pop")

#else

#define weakify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
autoreleasepool{} __block __typeof__(x) __block_##x##__ = x; \
_Pragma("clang diagnostic pop")

#endif
#endif

#ifndef    strongify
#if __has_feature(objc_arc)

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __weak_##x##__; \
_Pragma("clang diagnostic pop")

#else

#define strongify( x ) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
try{} @finally{} __typeof__(x) x = __block_##x##__; \
_Pragma("clang diagnostic pop")

#endif
#endif

//解决真机调试不打印log的问题
#ifdef DEBUG
#define XPLog(format, ...) printf("[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define XPLog(format, ...)
#endif

/*GP优先*/
//#define bannerSlotId            @"266"
//#define interstitilaSlotId      @"267"
//#define nativeSlotId            @"268"
//#define AppWallSlotId           @"266"
//#define OneNativeSlotId         @"266"
//#define TwoNativeSlotId         @"266"
//#define KeywordsSlotId          @"266"
///*FB优先*/
//#define bannerSlotId            @"261"
//#define interstitilaSlotId      @"264"
//#define nativeSlotId            @"265"
//#define AppWallSlotId           @"266"
//#define OneNativeSlotId         @"266"
//#define TwoNativeSlotId         @"266"
//#define KeywordsSlotId          @"266"
/*CT优先*/
#define bannerSlotId            @"260"
#define interstitilaSlotId      @"262"
#define nativeSlotId            @"263"
#define AppWallSlotId           @"260"
#define OneNativeSlotId         @"260"
#define TwoNativeSlotId         @"260"
#define KeywordsSlotId          @"260"
@end
