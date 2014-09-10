//
//  ETTSendPushView.m
//  EasyTestTask
//
//  Created by Alexei Zhutenkov on 10/09/14.
//  Copyright (c) 2014 ZhutenkovAlexei. All rights reserved.
//

#import "ETTSendPushView.h"

@implementation ETTSendPushView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        
        
        UITextField *pushTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 250, 25)];
        pushTextField.layer.cornerRadius = 5.0f;
        pushTextField.backgroundColor = [UIColor whiteColor];
        pushTextField.placeholder = NSLocalizedString(kPushNotificationTextFieldPlaceHolder, @"");
        _pushTextField = pushTextField;
        [self addSubview:pushTextField];
        
        
        UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        pushButton.layer.cornerRadius = 5.0f;
        pushButton.backgroundColor = [UIColor redColor];
        pushButton.frame = CGRectMake(0, 0, 100, 50);
        [pushButton setTitle:NSLocalizedString(kPushButtonTitle, @"") forState:UIControlStateNormal];
        
        _pushButton = pushButton;
        [self addSubview:pushButton];
        

    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _pushTextField.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _pushButton.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 + _pushButton.frame.size.height);
}

@end
