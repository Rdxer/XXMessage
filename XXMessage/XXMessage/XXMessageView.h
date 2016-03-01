//
//  XXMessageView.h
//  XXMessage
//
//  Created by LXF on 16/2/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+xx_Message.h"


typedef NS_ENUM(NSInteger,XXMessageStatus){
    XXMessageStatusShow,
    XXMessageStatusShowing,
    XXMessageStatusHiding,
    XXMessageStatusHided,
};

@interface XXMessageView : UIView

@property (nonatomic, assign) XXMessageStatus status;
@property (nonatomic, assign) BOOL needHide;


-(instancetype)initWithMessage:(NSString *)message type:(XXMessageType)type options:(NSDictionary *)options inViewController:(UIViewController *) vc;

-(void)showInView:(UIView *)view;
-(void)hide;

@end
