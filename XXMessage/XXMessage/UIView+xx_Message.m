//
//  UIView+xx_Message.m
//  XXMessage
//
//  Created by LXF on 16/2/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

#import "UIView+xx_Message.h"
#import <objc/runtime.h>
#import "XXMessageView.h"

@interface UIView ()



@end

@implementation UIView (xx_Message)

-(XXMessageView *)xx_showMessageView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setXx_showMessageView:(XXMessageView *)xx_showMessageView{
    objc_setAssociatedObject(self, @selector(xx_showMessageView), xx_showMessageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)xx_DismissMessage{
    [self.xx_showMessageView hide];
}

-(void)xx_showMessageNoAutoHide:(NSString *)text type:(XXMessageType)type{
    [self xx_showMessage:text type:type options:@{
                                                  kXXAutoHide:[NSNumber numberWithBool:NO],
                                                  kXXHideOnTap:[NSNumber numberWithBool:NO]
                                                  } inViewController:nil];
}

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type{
    [self xx_showMessage:text type:type options:nil inViewController:nil];
}
-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options{
    [self xx_showMessage:text type:type options:options inViewController:nil];
}
-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options inViewController:(UIViewController *)vc{
    
    if (self.xx_showMessageView) {
        [self.xx_showMessageView hide];
    }
    self.xx_showMessageView = [[XXMessageView alloc]initWithMessage:text type:type options:options inViewController:nil];
    [self.xx_showMessageView showInView:self];
    
}

@end


@implementation UIViewController (xx_Message)


-(void)xx_DismissMessage{
    [self.view xx_DismissMessage];
}

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options inViewController:(UIViewController *)vc{
        [self.view xx_showMessage:text type:type options:options inViewController:self];
}

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type{
    [self.view xx_showMessageNoAutoHide:text type:type];
}

-(void)xx_showMessageNoAutoHide:(NSString *)text type:(XXMessageType)type{
    [self.view xx_showMessageNoAutoHide:text type:type];
}

-(void)xx_showMessage:(NSString *)text type:(XXMessageType)type options:(NSDictionary *)options{
    [self.view xx_showMessage:text type:type options:options inViewController:self];
}

@end
