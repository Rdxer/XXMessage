//
//  UIView+xx_Message.h
//  XXMessage
//
//  Created by LXF on 16/2/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger,XXMessageType){
    XXMessageTypeSuccess,
    XXMessageTypeError,
    XXMessageTypeWarning,
    XXMessageTypeInfo,
};

// CGFloat
#define kXXMessageViewHeight @"MessageViewHeight"

// CGFloat
#define kXXViewHeight @"ViewHeight"

//case AnimationDuration(NSTimeInterval)
#define kXXAnimationDuration @"AnimationDuration"

//case AutoHide(Bool)
#define kXXAutoHide @"AutoHide"

//case AutoHideDelay(Double) // Second
#define kXXAutoHideDelay @"AutoHideDelay"

//case HideOnTap(Bool)
#define kXXHideOnTap @"HideOnTap"

//case TextColor(UIColor)
#define kXXTextColor @"TextColor"

//CGFloat
#define kXXTextFont @"TextFont"

#define kXXMessagePosition @"XXMessagePosition"
typedef NS_ENUM(NSInteger,XXMessagePosition){
    XXMessagePositionTop,
    //    XXMessagePositionBottom,
};

#define kXXMessageAnimation @"XXMessageAnimation"
typedef NS_ENUM(NSInteger,XXMessageAnimation){
    XXMessageAnimationSlideDown,
    XXMessageAnimationSlideLeft,
    XXMessageAnimationSlideRight,
    XXMessageAnimationFade,
};




@class XXMessageView;

@interface UIView (xx_Message)

@property (nonatomic, strong) XXMessageView *xx_showMessageView;

-(void)xx_DismissMessage;

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options inViewController:(UIViewController *)vc;

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type;

-(void)xx_showMessageNoAutoHide:(NSString *)text type:(XXMessageType)type;

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options;

@end

@interface UIViewController (xx_Message)


-(void)xx_DismissMessage;

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options inViewController:(UIViewController *)vc;

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type;

-(void)xx_showMessageNoAutoHide:(NSString *)text type:(XXMessageType)type;

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options;

@end
