//
//  ETTSendPushView.h
//  EasyTestTask
//
//  Created by Alexei Zhutenkov on 10/09/14.
//  Copyright (c) 2014 ZhutenkovAlexei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ETTSendPushView : UIView

/**
 *  The text box to enter text alerts
 */
@property (weak) UITextField *pushTextField;

/**
 *  Button to send a notification to the server
 */
@property (weak) UIButton *pushButton;


@end
