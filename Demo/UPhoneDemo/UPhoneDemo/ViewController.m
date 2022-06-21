//
//  ViewController.m
//  UCloudGameDemo
//
//  Created by user on 2021/11/12.
//

#import "ViewController.h"
#import <UPhoneSDK/UPhoneSDK.h>
#import "UTestVideoViewController.h"
#import "UPhoneMainView.h"
@interface ViewController ()<UPhoneVideoViewControllerDelegate,UPhoneMainViewDelegate>
@property(nonatomic, strong) UPhoneMainView *mainView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    _mainView = [[UPhoneMainView alloc] initWithFrame:CGRectZero];
    _mainView.delegate = self;
    self.view = _mainView;
}


- (void)mainView:(UPhoneMainView *)mainView didInputPhoneId:(NSString *)phoneId{
    if (!phoneId.length) {
        [self showAlertWithMessage:@"云手机id不能为空，请重新输入."];
        return;
        
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:phoneId forKey:@"UphoneRoomId"];

    UTestVideoViewController *videoCallViewController =
    [[UTestVideoViewController alloc] initWithUphone:phoneId];
    videoCallViewController.token = @"123456";
    videoCallViewController.modalTransitionStyle =
    UIModalTransitionStyleCrossDissolve;
    videoCallViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:videoCallViewController
                       animated:YES
                     completion:nil];
}


- (void)showAlertWithMessage:(NSString*)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:nil
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action){
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
