//
//  UTestVideoViewController.m
//  UTestGametest1
//
//  Created by user on 2021/11/9.
//

#import "UTestVideoViewController.h"
#import "UPhoneTouchButton.h"
#import "UPhoneSettingNewView.h"
#import "UCCommon.h"
#import <CoreMotion/CoreMotion.h>
#import <UPhoneSDK/UPhoneSDK.h>
#import <AVKit/AVKit.h>
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define  tabBarViewW 200
#define RepeatTimes  5

@interface UTestVideoViewController ()
{
    double _landScape;
    NSInteger _timerStr;

    
}
@property (nonatomic, strong) UPhoneTouchButton *myButton;
@property (nonatomic, assign) BOOL flag;
@property(nonatomic, strong) UPhoneSettingNewView *settingView;
@property(nonatomic, strong)UCBaseAnimationPopView *popView;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong)UPhonePacketLostView *statusView;


@end

@implementation UTestVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connectUPhone];
    _landScape = [self landScape];
    [self addCustomElements];
    NSDictionary *dic =  [self getQRCodeData];
    NSString *height = [dic valueForKey:@"height"];
    NSString *width = [dic valueForKey:@"width"];
    if(([height intValue] * [width integerValue]) < 2560 * 1440 && ([height intValue] * [width integerValue]) >= 1080 * 1920){
        [[NSUserDefaults standardUserDefaults] setObject:@"超清" forKey:@"test_Definition"];

    }else  if(([height intValue] * [width integerValue]) < 1080 * 1920 && ([height intValue] * [width integerValue]) >= 1280 * 720){
        [[NSUserDefaults standardUserDefaults] setObject:@"高清" forKey:@"test_Definition"];

    }else if(([height intValue] * [width integerValue]) < 1280 * 720 && ([height intValue] * [width integerValue]) >= 960 * 480){
        [[NSUserDefaults standardUserDefaults] setObject:@"标清" forKey:@"test_Definition"];

    }

    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isMute"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isShowDelay"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isShowNetWork"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:@"applicationWillResignActive" object:nil];

    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isConnect"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"rtmpUrl"];
    
}

- (void)applicationWillResignActive:(NSNotification *)notify{
    [self applicationWillResignActive];
}
- (void)clickConnectUPhoneErrorAction:(NSString *)errorStr {
    if (errorStr.length > 0) {
        NSLog(@"%@",errorStr);
        _timerStr++;
        if (_timerStr ==RepeatTimes) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误报告" message:[NSString stringWithFormat:@"%@",errorStr] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self disConnectUPhone];
                
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:conform];
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];
        }else if (_timerStr < RepeatTimes){
            sleep(3);
            [UPhoneService reconnetUPhone];//可根据自己的实际情况进行重连次数限制，当前限制5次重连
        }
 
    }
}

- (void)clickConnectUGameErrorAction:(NSString *)errorStr {
    if (errorStr.length > 0) {
        NSLog(@"%@",errorStr);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误报告" message:[NSString stringWithFormat:@"%@",errorStr] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:conform];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
}

- (void)clickSetResolutionMessageAction:(NSString *)message {
    if ([message isEqualToString:@"高清"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"高清" forKey:@"test_Definition"];
        NSLog(@"分辨率修改为高清");
    }else if ([message isEqualToString:@"标清"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"标清" forKey:@"test_Definition"];
        NSLog(@"分辨率修改为标清");
    }else{
        NSLog(@"分辨率设置失败");
    }
}

- (void)timerAction:(NSTimer*)timer
{
    [_myButton setTitle:[self getNetworkSpeed] forState:UIControlStateNormal];
}

- (void)addCustomElements
{
    _myButton = [UPhoneTouchButton buttonWithType:UIButtonTypeCustom];
    
    _myButton.frame = CGRectMake(0, KSCHeight - 40 - distance_bottom, 40, 40);
    _myButton.layer.cornerRadius = 20;
    _myButton.backgroundColor = UIColorFromRGB(0x80bed742, 0.5);
    _myButton.MoveEnable = YES;
    [_myButton setTag:10];
    [_myButton setImage:[UIImage imageNamed:@"touch"] forState:UIControlStateNormal];
    [_myButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    _myButton.titleLabel.font = [UIFont systemFontOfSize:11];
    _myButton.titleEdgeInsets = UIEdgeInsetsMake(-_myButton.imageView.frame.size.height - 20.0, -_myButton.imageView.frame.size.width + 8.0, 0.0, -12.0);
    _myButton.imageEdgeInsets = UIEdgeInsetsMake(5.0,5.0,5.0,5.0);
    [_myButton addTarget:self action:@selector(tabbarbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_myButton];
    
    _statusView = [[UPhonePacketLostView alloc]initWithFrame:CGRectZero];
    _statusView.backgroundColor = RGBA(24, 28, 38, 0.5);
    _statusView.layer.shadowOpacity = 10;
    if (_landScape >= 30.0 && _landScape < 120.0) {
        _statusView.transform = CGAffineTransformMakeRotation(M_PI/2);
        _statusView.frame = CGRectMake(WIDTH - 75,  (HEIGHT - 20)/2, 20 , 180);
    }else{
        _statusView.frame = CGRectMake((WIDTH - 180)/2,  KKNavBarHeight2, 180 , 20);
    }
    
    [self.view addSubview:_statusView];
    _statusView.hidden = YES;
}

- (void)tabbarbtn:(UPhoneTouchButton *)btn
{
    if (!btn.MoveEnabled) {
        _settingView = [[UPhoneSettingNewView alloc] initWithFrame:CGRectZero];
        _settingView.backgroundColor = [UIColor blackColor];
        _settingView.alpha = 0.8f;//设置透明
        
        __weak UTestVideoViewController *weakSelf = self;
        /**
         实验室 测试接口
         */
        _settingView.clickTestButtonBlock = ^{
            UTestVideoViewController *strongSelf = weakSelf;
           // sdk中截图暂时保存到相册用以验证截图成功与否以及判断是否黑屏
            NSInteger color = [strongSelf checkBlackScreen:[strongSelf getShortcut]];
            if (color == 1) {
                NSLog(@"纯色");
            }else if (color == 2){
                NSLog(@"纯透明色");
            }else if (color == 4){
                NSLog(@"纯黑色");
            }else{
                NSLog(@"正常色");
            }
            
        };
        
        _settingView.clickExitButtonBlock = ^{
            UTestVideoViewController *strongSelf = weakSelf;
            [strongSelf exitButtonClick];
        };
        
        _settingView.clickOperationButtonBlock = ^(NSString * _Nonnull str) {
            UTestVideoViewController *strongSelf = weakSelf;
            if ([str isEqualToString:@"0"]) {
                [strongSelf->_popView dismiss];
                [strongSelf speedUpUPhone];
            }else if ([str isEqualToString:@"1"]){
                [strongSelf->_popView dismiss];
                [strongSelf backUPhoneHome];
            }else if ([str isEqualToString:@"2"]){
                [strongSelf->_popView dismiss];
                [strongSelf backUPhoneLastPage];
            }
        };
        
        _settingView.clickDefinitionButtonBlock = ^(int resolution) {
            UTestVideoViewController *strongSelf = weakSelf;
            [strongSelf->_popView dismiss];
            //修改分辨率
            [strongSelf setUPhoneResolution:resolution];
            
        };
        
        _settingView.clickShowDelayOrPacketBlock = ^(BOOL isSelect) {
            UTestVideoViewController *strongSelf = weakSelf;
            if (isSelect) {
                strongSelf.statusView.hidden = NO;
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isShowDelay"];
            }else{
                strongSelf.statusView.hidden = YES;
                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isShowDelay"];
            }
        };
        
        _settingView.clickShowNetworkBlock = ^(BOOL isSelect) {
            UTestVideoViewController *strongSelf = weakSelf;
            if (isSelect) {
                [strongSelf.myButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isShowNetWork"];
            }else{
                [strongSelf.myButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isShowNetWork"];
                
            }
            
        };
        
        _settingView.clickChooseLiveButtonBlock = ^(BOOL isSelect, NSString * _Nonnull rtmpUrl) {
            UTestVideoViewController *strongSelf = weakSelf;
            if (isSelect) {
                if (rtmpUrl.length == 0) {
                    [strongSelf showAlertWithMessage:@"请输入正确的推流地址"];
                }else{
                    NSInteger liveStr = [[strongSelf isSupportLiving] integerValue];
                    switch (liveStr) {
                        case 0:
                            [strongSelf showAlertWithMessage:@"未设置"];
                            break;
                        case 1:
                            [strongSelf showAlertWithMessage:@"正在启动推流"];
                            
                            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isConnect"];
                            [strongSelf startLiving:rtmpUrl];
                            break;
                        case 2:
                            [strongSelf showAlertWithMessage:@"正在推流"];
                            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isConnect"];
                            [strongSelf startLiving:rtmpUrl];
                            break;
                        case 3:
                            [strongSelf showAlertWithMessage:@"已停止推流"];
                            break;
                        default:
                            break;
                    }
                }
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isConnect"];
                
                [strongSelf stopLiving];
            }
            
        };
        
        _settingView.clickVolumeButtonBlock = ^(int num) {
            UTestVideoViewController *strongSelf = weakSelf;
            [strongSelf setVolume:num];
        };

        _settingView.clickChooseMuteButtonBlock = ^(BOOL isSelect) {
            UTestVideoViewController *strongSelf = weakSelf;
            if (isSelect) {
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isMute"];
                [strongSelf setAudioMute:YES];
            }else{
                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isMute"];
                [strongSelf setAudioMute:NO];
            }
        };

        NSTimeInterval delayTime = 0;
        NSTimeInterval timeInterval = 1.0f;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC));
        dispatch_source_set_timer(_timer, startDelayTime, timeInterval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self->_statusView setStats:[NSString stringWithFormat:@"延时：%ldms 丢包：%@ 网速：%@",(long)[self getUPhoneLinkDelay],[self getLossRate],[self getNetworkSpeed]]];
                [self->_settingView.statusView setStats:[NSString stringWithFormat:@"延时：%ldms 丢包：%@",(long)[self getUPhoneLinkDelay],[self getLossRate]]];
            });
        });
        dispatch_resume(_timer);
        
        _landScape = [self landScape];
        if (_landScape >= 30.0 && _landScape < 120.0) {
            _settingView.frame = CGRectMake(WIDTH - 250, (HEIGHT - 200)/2 , WIDTH/5 * 6 , WIDTH);
            _settingView.transform = CGAffineTransformMakeRotation(M_PI/2);
        }else{
            _settingView.frame = CGRectMake(0, 0 , WIDTH , WIDTH/6 * 5);
        }
        
        YSAnimationPopStyle popStyle = YSAnimationPopStyleLineFromBottom;
        YSAnimationDismissStyle dismissStyle = YSAnimationDismissStyleLineToBottom;
        popStyle = YSAnimationPopStyleLineFromTop;
        dismissStyle = YSAnimationDismissStyleLineToTop;
        _popView = [[UCBaseAnimationPopView alloc] initWithCustomView:_settingView popStyle:(popStyle) dismissStyle:(dismissStyle)];
        _popView.popBGAlpha = 0.5;
        [_popView pop];
    }
   
}

- (double)landScape {
    CMMotionManager *motionManager = [[CMMotionManager alloc]init];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    motionManager.accelerometerUpdateInterval=1;
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(0);
    
    __block double xyTheta;
    __weak UTestVideoViewController *weakSelf = self;
    [motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        UTestVideoViewController *strongSelf = weakSelf;
        if(error) {
            
            xyTheta = 0;
            dispatch_semaphore_signal(signal);
            [motionManager stopAccelerometerUpdates];
            
        }else{
            double zTheta =atan2(accelerometerData.acceleration.z,sqrtf(accelerometerData.acceleration.x*accelerometerData.acceleration.x+accelerometerData.acceleration.y*accelerometerData.acceleration.y))/M_PI*(-90.0)*2-90;
            
            xyTheta =atan2(accelerometerData.acceleration.x,accelerometerData.acceleration.y)/M_PI*180.0;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (fabs(xyTheta) >= 30.0 && fabs(xyTheta) < 120.0) {//横屏
                    strongSelf.statusView.transform = CGAffineTransformMakeRotation(M_PI/2);
                    strongSelf.statusView.frame = CGRectMake(WIDTH - 20,  (HEIGHT - 130)/2, 20 , 180);
                }else{//竖屏
                    strongSelf.statusView.transform = CGAffineTransformMakeRotation(0);
                    strongSelf.statusView.frame = CGRectMake((WIDTH - 180)/2,  KKNavBarHeight2, 180 , 20);
                }
            });
            dispatch_semaphore_signal(signal);
        }
        
    }];
    
    dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
    return fabs(xyTheta);
    
}

- (void)exitButtonClick {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"您准备要退出云手机吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"rtmpUrl"];
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"isConnect"];
        [self->_popView dismiss];
        [self disConnectUPhone];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:conform];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (void)showAlertWithMessage:(NSString*)message {
    UIAlertController *alert =
    [UIAlertController alertControllerWithTitle:nil
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action){
    }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
