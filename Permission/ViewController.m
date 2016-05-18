//
//  ViewController.m
//  Permission
//
//  Created by 石潇 on 16/5/19.
//  Copyright © 2016年 石潇. All rights reserved.
//

#import "ViewController.h"
//相机，麦克风
#import <AVFoundation/AVFoundation.h>
//相册
#import <Photos/Photos.h>
//通讯录
#import <AddressBook/AddressBook.h>
//定位
#import <CoreLocation/CoreLocation.h>
//日历
#import <EventKit/EventKit.h>
@interface ViewController ()<CLLocationManagerDelegate>
{
    NSArray *_arr;
    CLLocationManager *_manager;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _arr = @[@"相机",
             @"相册",
             @"麦克风",
             @"推送",
             @"通讯录",
             @"日历",
             @"定位"];
    
}


- (IBAction)settingAction:(id)sender {
    //打开系统设置
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

#pragma mark - tableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
    }
    cell.textLabel.text = _arr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {//相机
        
        AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (videoAuthStatus) {
            case AVAuthorizationStatusNotDetermined:
                NSLog(@"未询问用户是否授权");
                break;
            case AVAuthorizationStatusRestricted:
                NSLog(@"未授权，例如家长控制");
                break;
            case AVAuthorizationStatusDenied:
                NSLog(@"未授权，用户拒绝造成的");
                break;
            case AVAuthorizationStatusAuthorized:
                NSLog(@"同意授权相机");
                break;
            default:
                break;
        }
        
    }else if (indexPath.row == 1){
        PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthStatus) {
            case PHAuthorizationStatusNotDetermined:
                NSLog(@"未询问用户是否授权");
                break;
            case PHAuthorizationStatusRestricted:
                NSLog(@"未授权，例如家长控制");
                break;
            case PHAuthorizationStatusDenied:
                NSLog(@"未授权，用户拒绝造成的");
                break;
            case PHAuthorizationStatusAuthorized:
                NSLog(@"同意授权相册");
                break;
            default:
                break;
        }
        
    }else if (indexPath.row == 2){
        AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        switch (audioAuthStatus) {
            case AVAuthorizationStatusNotDetermined:
                NSLog(@"未询问用户是否授权");
                break;
            case AVAuthorizationStatusRestricted:
                NSLog(@"未授权，例如家长控制");
                break;
            case AVAuthorizationStatusDenied:
                NSLog(@"未授权，用户拒绝造成的");
                break;
            case AVAuthorizationStatusAuthorized:
                NSLog(@"同意授权麦克风");
                break;
            default:
                break;
        }
        
    }else if (indexPath.row == 3){
        UIUserNotificationSettings *notificationSettings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        switch (notificationSettings.types) {
            case UIUserNotificationTypeNone:
                NSLog(@"没有推送权限");
                break;
            case UIUserNotificationTypeBadge:
                NSLog(@"带角标的推送");
                break;
            case UIUserNotificationTypeSound:
                NSLog(@"带声音的推送");
                break;
            case UIUserNotificationTypeAlert:
                NSLog(@"带通知的推送");
                break;
            default:
                break;
        }
        
    }else if (indexPath.row == 4){
        //        #import <Contacts/Contacts.h>  iOS9之后推荐使用
        //        CNAuthorizationStatus *status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        
        ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
        switch (authorizationStatus) {
            case  kABAuthorizationStatusNotDetermined:
                NSLog(@"未询问用户是否授权");
                break;
            case kABAuthorizationStatusRestricted:
                NSLog(@"未授权，例如家长控制");
                break;
            case kABAuthorizationStatusDenied:
                NSLog(@"未授权，用户拒绝造成的");
                break;
            case kABAuthorizationStatusAuthorized:
                NSLog(@"同意授权通讯录");
                break;
            default:
                break;
        }
    }else if (indexPath.row == 5){
        EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
        switch (status) {
            case  EKAuthorizationStatusNotDetermined:
                NSLog(@"未询问用户是否授权");
                break;
            case EKAuthorizationStatusRestricted:
                NSLog(@"未授权，例如家长控制");
                break;
            case EKAuthorizationStatusDenied:
                NSLog(@"未授权，用户拒绝造成的");
                break;
            case EKAuthorizationStatusAuthorized:
                NSLog(@"同意授权日历");
                break;
            default:
                break;
        }
    }else if (indexPath.row == 6){
        BOOL isLocation = [CLLocationManager locationServicesEnabled];  //是否开启定位服务
        if (!isLocation) {
            NSLog(@"用户未开启定位");
            return ;
        }
        CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
        switch (locationStatus) {
            case kCLAuthorizationStatusNotDetermined:
                NSLog(@"未询问用户是否授权");
                break;
            case kCLAuthorizationStatusRestricted:
                NSLog(@"未授权，例如家长控制");
                break;
            case kCLAuthorizationStatusDenied:
                NSLog(@"未授权，用户拒绝造成的");
                break;
            case kCLAuthorizationStatusAuthorizedAlways:
                NSLog(@"同意授权一直获取定位信息");
                break;
            case kCLAuthorizationStatusAuthorizedWhenInUse:
                NSLog(@"同意授权在使用时获取定位信息");
                break;
                
            default:
                break;
        }
        
        
    }
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted){
                NSLog(@"用户同意授权相机");
            }else {
                NSLog(@"用户拒绝授权相机");
            }
            
        }];
    }else if (indexPath.row == 1){
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                NSLog(@"用户同意授权相册");
            }else {
                NSLog(@"用户拒绝授权相册");
            }
            
        }];
    }else if (indexPath.row == 2){
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            if (granted){
                NSLog(@"用户同意授权麦克风");
            }else {
                NSLog(@"用户拒绝授权麦克风");
            }
            
        }];
    }else if (indexPath.row == 3){
        
        UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
        
    }else if (indexPath.row == 4){
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (error) {
                NSLog(@"通讯录出现了错误");
                return;
            }
            
            if (granted) {
                NSLog(@"用户同意授权通讯录");
                CFRelease(addressBook);
            } else {
                NSLog(@"用户拒绝授权通讯录");
            }
        });
    }else if (indexPath.row == 5){
        
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        [eventStore requestAccessToEntityType:EKEntityTypeEvent
                                   completion:^(BOOL granted, NSError *error) {
                                       if (error) {
                                           NSLog(@"日历出现了错误");
                                           return;
                                       }
                                       if (granted) {
                                           NSLog(@"用户同意授权日历");
                                       } else {
                                           NSLog(@"用户拒绝授权日历");
                                       }
                                       
                                   }];
    }else if (indexPath.row == 6){
        _manager = [[CLLocationManager alloc] init];
        _manager.delegate = self;
        [_manager requestAlwaysAuthorization];
        [_manager requestWhenInUseAuthorization];
        [_manager startUpdatingLocation];
    }
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"定位中....");
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    NSLog(@"授权状态改变");
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"未询问用户是否授权");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"未授权，例如家长控制");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"未授权，用户拒绝造成的");
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"同意授权一直获取定位信息");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"同意授权在使用时获取定位信息");
            break;
            
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"定位失败原因: %@",[error localizedDescription]);
    
}
@end
