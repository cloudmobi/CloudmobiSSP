

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ZCJHUDMode) {
    /** 转圈动画模式，默认值 */
    ZCJHUDModeIndeterminate,
    /** 只显示标题 */
    ZCJHUDModeText
};


@interface ZCJHUD : UIView

@property (nonatomic, assign) ZCJHUDMode mode;

@property (nonatomic, strong) NSString *labelText;

- (instancetype)initWithView:(UIView *)view;

- (void)show;

- (void)hide;

@end
