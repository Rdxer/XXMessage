//
//  ViewController.m
//  XXMessage
//
//  Created by LXF on 16/2/25.
//  Copyright © 2016年 LXF. All rights reserved.
//

#import "ViewController.h"

#import "UIView+xx_Message.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)onclickButton:(id)sender {
    [self.view xx_showMessageNoAutoHide:@"不消失 点击也不消失" type:XXMessageTypeWarning];
}

- (IBAction)success:(id)sender {
    [self xx_showMessage:@"成功" type: XXMessageTypeSuccess];
}
- (IBAction)failure:(id)sender {
    [self xx_showMessage:@"失败" type: XXMessageTypeError];
}
- (IBAction)wring:(id)sender {
    [self xx_showMessage:@"警告" type: XXMessageTypeWarning];
}
- (IBAction)info:(id)sender {
    [self xx_showMessage:@"信息" type: XXMessageTypeInfo];
}

- (IBAction)dismiss:(id)sender {
    [self xx_DismissMessage];
}

@end
