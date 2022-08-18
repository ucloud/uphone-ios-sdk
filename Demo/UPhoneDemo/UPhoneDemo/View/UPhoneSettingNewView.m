//
//  UPhoneSettingNewView.m
//  AppRTCMobile-iOS
//
//  Created by user on 2021/12/27.
//  Copyright © 2021 Bang Nguyen. All rights reserved.
//

#import "UPhoneSettingNewView.h"
#import <Masonry/Masonry.h>
#import "UPhoneSettingTableViewCell.h"
#import "UPhoneSettingSwitchTableViewCell.h"
#import "UPhoneSettingFooterView.h"
#import "UCCommon.h"
#import "UPhonePacketLostView.h"
#import "UPhoneSettingDefinitionTableViewCell.h"
#import "UPhoneSettingOperationTableViewCell.h"
#import "UPhoneSettingSwitchLiveTableViewCell.h"
#import "ARDSettingVolumeTableViewCell.h"

@interface UPhoneSettingNewView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *leftTableView;
@property (nonatomic, strong)UITableView *rightTableView;
@property (nonatomic, strong)UPhoneSettingFooterView *leftFooterView;
@property (nonatomic, strong)NSArray *logoData;
@property (nonatomic, strong)NSArray *titleData;
@property (nonatomic, strong)NSArray *functionData;
@property(strong,nonatomic)UPhoneSettingTableViewCell *currentCell;

@end

@implementation UPhoneSettingNewView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.leftTableView];
        [self addSubview:self.rightTableView];
        [self addSubview:self.leftFooterView];
        _logoData = @[@"常用操作",@"退出云手机",@"实验室"];
        _titleData = @[@"常用操作",@"退出云手机",@"实验室"];
    }
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_leftFooterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(@150);
    }];
    
    [_leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom).offset(-60);
        make.width.equalTo(@150);
    }];
    
    
    [_rightTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftTableView.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return _logoData.count;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        static NSString * Identifier=@"UPhoneSettingTableViewCell";
        UPhoneSettingTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
        if (!cell) {
            cell = [[UPhoneSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPhoneSettingTableViewCell"];
        }
        cell.backgroundColor = RGBA(34, 38, 49, 1);

        cell.selectedBackgroundView= [[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor= RGBA(43, 51, 60, 1);
        if (_currentCell) {
            if (cell == _currentCell) {
                cell.isSelected = YES;
            }else{
                cell.isSelected = NO;
            }
        }else{
            if (indexPath.row == 0) {
                cell.isSelected = YES;
            }
        }
        cell.titleLabel.text = _titleData[indexPath.row];
        [cell.logoButton setImage:[UIImage imageNamed:@"setting_unselect"] forState:UIControlStateNormal];
        [cell.logoButton setImage:[UIImage imageNamed:@"setting_select"] forState:UIControlStateSelected];
      

        return cell;
    }else{
        
        if (indexPath.row == 0) {
            static NSString * Identifier=@"UPhoneSettingSwitchTableViewCell";
            UPhoneSettingSwitchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                cell = [[UPhoneSettingSwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPhoneSettingSwitchTableViewCell"];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"显示网络状态";
            NSString *isShowDelay = [[NSUserDefaults standardUserDefaults] objectForKey:@"isShowDelay"];
            if ([isShowDelay isEqualToString:@"yes"]) {
                cell.chooseSwitch.on = YES;
            }else{
                cell.chooseSwitch.on = NO;
            }
            __weak UPhoneSettingNewView *weakSelf = self;
            cell.clickSwitchChooseBlock = ^(BOOL isSwitch) {
                UPhoneSettingNewView *strongSelf = weakSelf;
                if (strongSelf.clickShowDelayOrPacketBlock) {
                    strongSelf.clickShowDelayOrPacketBlock(isSwitch);
                }
            };
            return cell;
        }else if (indexPath.row == 1){
            static NSString * Identifier=@"UPhoneSettingSwitchTableViewCell2";
            UPhoneSettingSwitchTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                cell = [[UPhoneSettingSwitchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPhoneSettingSwitchTableViewCell2"];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"开启静音";
            NSString *isMute = [[NSUserDefaults standardUserDefaults] objectForKey:@"isMute"];
            if ([isMute isEqualToString:@"yes"]) {
                cell.chooseSwitch.on = YES;
            }else{
                cell.chooseSwitch.on = NO;
            }
            __weak UPhoneSettingNewView *weakSelf = self;
            cell.clickSwitchChooseBlock = ^(BOOL isSwitch) {
                UPhoneSettingNewView *strongSelf = weakSelf;
                if (strongSelf.clickChooseMuteButtonBlock) {
                    strongSelf.clickChooseMuteButtonBlock(isSwitch);
                }
            };
            return cell;
        }else if (indexPath.row == 2){
            static NSString * Identifier=@"UPhoneSettingSwitchLiveTableViewCell";
            UPhoneSettingSwitchLiveTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                cell = [[UPhoneSettingSwitchLiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPhoneSettingSwitchLiveTableViewCell"];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.titleLabel.text = @"直播推流";
            NSString *rtmpUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"rtmpUrl"];
            cell.liveTextField.text = rtmpUrl;
            
            NSString *isConnect = [[NSUserDefaults standardUserDefaults] objectForKey:@"isConnect"];
            if ([isConnect isEqualToString:@"yes"]) {
                cell.chooseSwitch.on = YES;
            }else{
                cell.chooseSwitch.on = NO;
            }
            
            __weak UPhoneSettingNewView *weakSelf = self;
            cell.clickSwitchChooseBlock = ^(BOOL isSwitch, NSString * _Nonnull rtmpUrl) {
                UPhoneSettingNewView *strongSelf = weakSelf;
                if (rtmpUrl.length == 0) {
                    cell.chooseSwitch.on = NO;
                    if (strongSelf.clickChooseLiveButtonBlock) {
                        strongSelf.clickChooseLiveButtonBlock(isSwitch,rtmpUrl);
                    }
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:rtmpUrl forKey:@"rtmpUrl"];
                    if (strongSelf.clickChooseLiveButtonBlock) {
                        strongSelf.clickChooseLiveButtonBlock(isSwitch,rtmpUrl);
                    }
                }
                
            };
            return cell;
        }else if (indexPath.row == 3){
            static NSString * Identifier=@"UPhoneSettingDefinitionTableViewCell";
            UPhoneSettingDefinitionTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                cell = [[UPhoneSettingDefinitionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPhoneSettingSwitchTableViewCell"];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            NSString *definition = [[NSUserDefaults standardUserDefaults] objectForKey:@"test_Definition"];

            if ([definition isEqualToString:@"超清"]) {
                cell.superButton.selected = YES;
                cell.superButton.backgroundColor = RGBA(45, 65, 70, 1);
                cell.superButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
            }else if ([definition isEqualToString:@"高清"]){
                cell.highButton.selected = YES;
                cell.highButton.backgroundColor = RGBA(45, 65, 70, 1);
                cell.highButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
            }else{
                cell.lowButton.selected = YES;
                cell.lowButton.backgroundColor = RGBA(45, 65, 70, 1);
                cell.lowButton.layer.borderColor = RGBA(89, 193, 132, 1).CGColor;
            }
            
            __weak UPhoneSettingNewView *weakSelf = self;
            cell.clickDefinitionBlock = ^(int resolution) {
                UPhoneSettingNewView *strongSelf = weakSelf;
                if (strongSelf.clickDefinitionButtonBlock) {
                    strongSelf.clickDefinitionButtonBlock(resolution);
                }
            };
            return cell;
        }else if (indexPath.row == 4){
            static NSString * Identifier=@"ARDSettingVolumeTableViewCell";
            ARDSettingVolumeTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                cell = [[ARDSettingVolumeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            __weak UPhoneSettingNewView *weakSelf = self;
            cell.clickVolumeBlock = ^(int num) {
                UPhoneSettingNewView *strongSelf = weakSelf;
                if (strongSelf.clickVolumeButtonBlock) {
                    strongSelf.clickVolumeButtonBlock(num);
                }
            };
            return cell;
        }else {
            static NSString * Identifier=@"UPhoneSettingOperationTableViewCell";
            UPhoneSettingOperationTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
            if (!cell) {
                cell = [[UPhoneSettingOperationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UPhoneSettingOperationTableViewCell"];
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            __weak UPhoneSettingNewView *weakSelf = self;
            cell.clickOperationBlock = ^(NSString * _Nonnull str) {
                UPhoneSettingNewView *strongSelf = weakSelf;
                if (strongSelf.clickOperationButtonBlock) {
                    strongSelf.clickOperationButtonBlock(str);
                }
            };
            return cell;
        }
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView ==_leftTableView) {
        _statusView = [[UPhonePacketLostView alloc]initWithFrame:CGRectZero];
        _statusView.backgroundColor = RGBA(34, 38, 49, 1);
        return  _statusView;
    }else{
        UIView *leftHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
        leftHeaderView.backgroundColor = [UIColor clearColor];
        return leftHeaderView;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        return 44;
    }else{
        if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5) {
            return 90;
        }else if(indexPath.row == 2){
            return 80;
        }
        else{
            return 44;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView ==_leftTableView) {
        return 30;
    }else{
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        _currentCell=[tableView cellForRowAtIndexPath:indexPath];
        [self.leftTableView reloadData];
        if (indexPath.row == 1) {
            if (self.clickExitButtonBlock) {
                self.clickExitButtonBlock();
            }
        }else if(indexPath.row == 2){
            if (self.clickTestButtonBlock) {
                self.clickTestButtonBlock();
            }
        }
    }
}
- (UITableView *)leftTableView {
    if (!_leftTableView) {
        _leftTableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _leftTableView.delegate = self;
        _leftTableView.dataSource = self;
        _leftTableView.scrollEnabled = NO;
        _leftTableView.backgroundColor = RGBA(34, 38, 49, 1);
        [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]animated:YES scrollPosition:UITableViewScrollPositionNone];

    }
    return _leftTableView;
}

- (UITableView *)rightTableView {
    if (!_rightTableView) {
        _rightTableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.backgroundColor = RGBA(43, 51, 60, 1);
        [_rightTableView registerClass:[UPhoneSettingSwitchTableViewCell class] forCellReuseIdentifier:@"UPhoneSettingSwitchTableViewCell"];
        [_rightTableView registerClass:[UPhoneSettingSwitchLiveTableViewCell class] forCellReuseIdentifier:@"UPhoneSettingSwitchLiveTableViewCell"];
        [_rightTableView registerClass:[UPhoneSettingSwitchTableViewCell class] forCellReuseIdentifier:@"UPhoneSettingSwitchTableViewCell"];
        [_rightTableView registerClass:[ARDSettingVolumeTableViewCell class] forCellReuseIdentifier:@"ARDSettingVolumeTableViewCell"];

    }
    return _rightTableView;
}

- (UPhoneSettingFooterView *)leftFooterView {
    if (!_leftFooterView) {
        _leftFooterView = [[UPhoneSettingFooterView alloc]initWithFrame:CGRectZero];
        _leftFooterView.backgroundColor = RGBA(34, 38, 49, 1);
        NSString *uphoneRoomId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UphoneRoomId"];
        _leftFooterView.roomIdLabel.text = [NSString stringWithFormat:@"ID：%@",uphoneRoomId];

    }
    return _leftFooterView;
}


@end
