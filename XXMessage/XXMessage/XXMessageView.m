//
//  XXMessageView.m
//  XXMessage
//
//  Created by LXF on 16/2/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

#import "XXMessageView.h"

#import "Masonry.h"

@interface XXMessageView ()

@property (nonatomic, strong)   UIImageView     *iconImageView;
@property (nonatomic, strong)   UILabel         *showMessageLabel;
@property (nonatomic, copy)     NSString        *message;
@property (nonatomic, copy)     NSDictionary    *options;
@property (nonatomic, assign)   XXMessageType   type;

@property (nonatomic, assign) CGFloat viewHeight;

@end

@implementation XXMessageView

-(void)showInView:(UIView *)view{
    
    NSAssert(view, @"view 不能为空...");
    
    self.status = XXMessageStatusShow;
    
    CGFloat vHeight = [[self defaultSetting:self.options forKey:kXXViewHeight]doubleValue];
    CGFloat mHeight = [[self defaultSetting:self.options forKey:kXXMessageViewHeight]doubleValue];
    [view addSubview:self];
    
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(view);
        make.height.mas_equalTo(vHeight + mHeight);
    }];
    [self animationShowToView:view];
}

-(void)hide{
    if (self.status != XXMessageStatusShowing) {
        self.needHide = YES;
        return;
    }
    self.status = XXMessageStatusHiding;
    [self animationDismiss];
}

-(instancetype)initWithMessage:(NSString *)message type:(XXMessageType)type options:(NSDictionary *)options inViewController:(UIViewController *)vc{
    
    self = [super init];
    if (self) {
        self.message    = message;
        self.type       = type;
        self.options    = options;
        self.needHide   = false;
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.showMessageLabel.text = self.message;
    self.showMessageLabel.textColor = [self defaultSetting:self.options forKey:kXXTextColor];
    self.showMessageLabel.font = [UIFont systemFontOfSize:[[self defaultSetting:self.options forKey:kXXTextFont] doubleValue]];
    [self setBackgroundColorWithType:self.type];
    [self addSubview:self.showMessageLabel];
    [self.showMessageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo([self xx_messageViewHeight]);
    }];
    
}

- (void)animationDismiss{
    XXMessageAnimation animation = [[self defaultSetting:self.options forKey:kXXAnimationDuration]integerValue];
    
    switch (animation) {
        case XXMessageAnimationFade:
            NSAssert(NO, @"XXMessageAnimationFade 动画未添加");
            break;
        case XXMessageAnimationSlideDown:
            [self animationSlideDownDismiss];
            break;
        case XXMessageAnimationSlideLeft:
            NSAssert(NO, @"XXMessageAnimationSlideLeft 动画未添加");
            break;
        case XXMessageAnimationSlideRight:
            NSAssert(NO, @"XXMessageAnimationSlideRight 动画未添加");
            break;
    }
}

- (void)animationSlideDownDismiss{
    [UIView animateWithDuration:[self xx_animationDuration] animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -([self xx_messageViewHeight] + [self xx_viewHeight]));
    }completion:^(BOOL finished) {
        self.status = XXMessageStatusHided;
        [self removeFromSuperview];
    }];
}
- (void)animationShowToView:(UIView *)toView{
    XXMessageAnimation animation = [[self defaultSetting:self.options forKey:kXXAnimationDuration]integerValue];
    
    switch (animation) {
        case XXMessageAnimationFade:
            NSAssert(NO, @"XXMessageAnimationFade 动画未添加");
            break;
        case XXMessageAnimationSlideDown:
            [self animationSlideDownShowToView:toView];
            break;
        case XXMessageAnimationSlideLeft:
            NSAssert(NO, @"XXMessageAnimationSlideLeft 动画未添加");
            break;
        case XXMessageAnimationSlideRight:
            NSAssert(NO, @"XXMessageAnimationSlideRight 动画未添加");
            break;
    }
}

- (void)animationSlideDownShowToView:(UIView *)toView{
    self.transform = CGAffineTransformMakeTranslation(0, -([self xx_messageViewHeight] + [self xx_viewHeight]));
    [UIView animateWithDuration:[self xx_animationDuration] animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, 0);
    }completion:^(BOOL finished) {
        self.status = XXMessageStatusShowing;
        if (self.needHide == YES) {
            [self hide];
            return ;
        }
        if ([self xx_autoHide]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)([self xx_autoHideDelay] * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hide];
            });
        }
        if ([self xx_hideOnTap]) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
            [self addGestureRecognizer:tap];
        }
    }];
}
- (void)handleTap:(UITapGestureRecognizer *)tap{
    [self hide];
}
-(UILabel *)showMessageLabel{
    if (_showMessageLabel == nil) {
        UILabel *a = [[UILabel alloc] init];
        a.textAlignment = NSTextAlignmentCenter;
        _showMessageLabel = a;
    }
    return _showMessageLabel;
}

-(void)setBackgroundColorWithType:(XXMessageType )type{
    switch (type) {
        case XXMessageTypeSuccess:
            self.backgroundColor = [UIColor colorWithRed:142.0/255 green:183.0/255 blue:64.0/255 alpha:0.95];
            break;
        case XXMessageTypeError:
            self.backgroundColor = [UIColor colorWithRed:219.0/255 green:36.0/255 blue:27.0/255 alpha:0.70];
            break;
        case XXMessageTypeWarning:
            self.backgroundColor = [UIColor colorWithRed:230.0/255 green:189.0/255 blue:1.0/255 alpha:0.95];
            break;
        case XXMessageTypeInfo:
            self.backgroundColor = [UIColor colorWithRed:44.0/255 green:187.0/255 blue:255.0/255 alpha:0.90];
            break;
        default:
            break;
    }
}

- (CGFloat)xx_messageViewHeight{
    return [[self defaultSetting:self.options forKey:kXXMessageViewHeight]doubleValue];
}

- (CGFloat)xx_viewHeight{
    return [[self defaultSetting:self.options forKey:kXXViewHeight]doubleValue];
}

- (CGFloat)xx_animationDuration{
    return [[self defaultSetting:self.options forKey:kXXAnimationDuration]doubleValue];
}

- (BOOL)xx_autoHide{
    return [[self defaultSetting:self.options forKey:kXXAutoHide]boolValue];
}

- (CGFloat)xx_autoHideDelay{
    return [[self defaultSetting:self.options forKey:kXXAutoHideDelay]doubleValue];
}

- (BOOL)xx_hideOnTap{
    return [[self defaultSetting:self.options forKey:kXXHideOnTap]boolValue];
}

- (UIColor *)xx_TextColor{
    return [self defaultSetting:self.options forKey:kXXTextColor];
}

- (CGFloat)xx_TextFont{
    return [[self defaultSetting:self.options forKey:kXXTextFont]doubleValue];
}

- (XXMessagePosition)xx_MessagePosition{
    return [[self defaultSetting:self.options forKey:kXXMessagePosition]integerValue];
}

- (XXMessageAnimation)xx_MessageAnimation{
    return [[self defaultSetting:self.options forKey:kXXMessageAnimation]integerValue];
}

-(id)defaultSetting:(NSDictionary *)dict forKey:(NSString *)key{
    id value = dict[key];
    
    if (value) {
        return value;
    }
    
    if ([key isEqualToString:kXXAutoHide]) {
        value = [NSNumber numberWithBool:YES];
    }else if ([key isEqualToString:kXXHideOnTap]) {
        value = [NSNumber numberWithBool:YES];
    }else if ([key isEqualToString:kXXTextColor]) {
        value = [UIColor whiteColor];
    }else if ([key isEqualToString:kXXAutoHideDelay]) {
        value = [NSNumber numberWithDouble:3.0];
    }else if ([key isEqualToString:kXXAnimationDuration]) {
        value = [NSNumber numberWithDouble:0.3];
    }else if ([key isEqualToString:kXXMessageAnimation]) {
        value = [NSNumber numberWithInteger:XXMessageAnimationSlideDown];
    }else if ([key isEqualToString:kXXViewHeight]) {
        value = [NSNumber numberWithDouble:64.0];
    }else if ([key isEqualToString:kXXMessageViewHeight]) {
        value = [NSNumber numberWithDouble:44.0];
    }else if ([key isEqualToString:kXXTextFont]) {
        value = [NSNumber numberWithDouble:14.0];
    }else{
        NSLog(@"error ----------- showMessage options");
        value = nil;
        
    }
    return value;
}

@end
