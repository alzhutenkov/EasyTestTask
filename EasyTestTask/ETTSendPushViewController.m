//
//  ETTSendPushViewController.m
//  EasyTestTask
//
//  Created by Alexei Zhutenkov on 10/09/14.
//  Copyright (c) 2014 ZhutenkovAlexei. All rights reserved.
//

#import "ETTSendPushViewController.h"
#import "ETTSendPushView.h"
#import <Parse/Parse.h>
#import "Reachability.h"

@interface ETTSendPushViewController ()<UITextFieldDelegate>

@property (strong) ETTSendPushView *pushView;

@end

@implementation ETTSendPushViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _pushView = [[ETTSendPushView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_pushView];
    
    
    _pushView.pushTextField.delegate = self;
    
    [_pushView.pushButton addTarget:self action:@selector(sendPushButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)sendPushButtonClicked:(id)sender
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    
    NSString *messageBody = nil;
    
    if (networkStatus == NotReachable)
    {
        [self showAlertWithTitle:NSLocalizedString(kAlertTitle, @"")
                            body:NSLocalizedString(kAlertInternetNotReachable, @"")];
        return;
    }
    
    NSString *pushTextFieldText = _pushView.pushTextField.text;
    
    if ([[pushTextFieldText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)
    {
            messageBody = NSLocalizedString(kPushNotificationTextFieldPlaceHolder, @"");
    } else
    {
            messageBody = NSLocalizedString(pushTextFieldText, @"");
    }
    
    
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                          messageBody, @"alert",
                          @"Increment", @"badge",
                          nil];
    
    PFPush *push = [[PFPush alloc] init];
    [push setChannels:[NSArray arrayWithObjects:kParsecomGlobalChannel, nil]];
    [push expireAfterTimeInterval:86400];
    [push setData:data];
    [push sendPushInBackground];
    
    
    [self showAlertWithTitle:NSLocalizedString(kAlertTitle, @"")
                        body:NSLocalizedString(kPushAlertBodySended, @"")];

}

- (void)showAlertWithTitle:(NSString *)title body:(NSString *)body
{
    UIAlertView *pushSendedAlert = [[UIAlertView alloc] initWithTitle:title
                                                              message:body
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
    [pushSendedAlert show];
}


#pragma mark -- UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_pushView.pushTextField resignFirstResponder];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
