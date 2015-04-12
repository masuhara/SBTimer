//
//  TimerSettingViewController.m
//  SBTimer
//
//  Created by Master on 2015/04/12.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "TimerSettingViewController.h"
#import "TimerViewController.h"
#import "UIManager.h"

@interface TimerSettingViewController () <UIPickerViewDelegate, UIPickerViewDataSource, ADBannerViewDelegate>

@end

@implementation TimerSettingViewController {
    IBOutlet UIPickerView *minutesPickerView;
    IBOutlet UIPickerView *secondsPickerView;
    IBOutlet ADBannerView *bannerView;
    
    int minute10;
    int minute0;
    int second10;
    int second0;
    
    int selectedMinutes;
    int selectedSeconds;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    minutesPickerView.tag = 1;
    secondsPickerView.tag = 2;
    
    minutesPickerView.delegate = self;
    minutesPickerView.dataSource = self;
    
    secondsPickerView.delegate = self;
    secondsPickerView.dataSource = self;
    
    [self initAdBannerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - PickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView.tag == 1) {
        return 2;
    }else if(pickerView.tag == 2) {
        return 2;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        switch (component) {
            case 0:
                return 10;
                break;
            case 1:
                return 10;
                break;
            default:
                break;
        }
    }else if (pickerView.tag == 2){
        switch (component) {
            case 0:
                return 6;
                break;
            case 1:
                return 10;
                break;
            default:
                break;
        }
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView.tag == 1) {
        switch (component) {
            case 0:
                return [NSString stringWithFormat:@"%ld", row];
                break;
            case 1:
                return [NSString stringWithFormat:@"%ld", row];
                break;
            default:
                return 0;
                break;
        }
    }else if(pickerView.tag == 2) {
        switch (component) {
            case 0:
                return [NSString stringWithFormat:@"%ld", row];
                break;
            case 1:
                return [NSString stringWithFormat:@"%ld", row];
                break;
            default:
                return 0;
                break;
        }
    }
    return nil;
}

#pragma mark - PickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    if (pickerView.tag == 1) {
        minute10 = (int)[pickerView selectedRowInComponent:0];
        minute0 = (int)[pickerView selectedRowInComponent:1];
        
        selectedMinutes = [self convertDoubleDigit:[NSString stringWithFormat:@"%d%d", minute10, minute0]];
    }else if (pickerView.tag == 2) {
        second10 = (int)[pickerView selectedRowInComponent:0];
        second0 = (int)[pickerView selectedRowInComponent:1];
        
        selectedSeconds = [self convertDoubleDigit:[NSString stringWithFormat:@"%d%d", second10, second0]];
    }
    
    NSLog(@"selected ... %2d分%2d秒", selectedMinutes, selectedSeconds);
}


#pragma mark - iAd

- (void)initAdBannerView {
    bannerView.delegate = self;
    bannerView.backgroundColor = BG_COLOR;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    banner.hidden = NO;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    NSLog(@"bannerViewActionDidFinish");
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    banner.hidden = YES;
}

#pragma mark - Private

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toTimer"]) {
        TimerViewController *timerViewController = segue.destinationViewController;
        timerViewController.minutes = selectedMinutes;
        timerViewController.seconds = selectedSeconds;
    }else if ([segue.identifier isEqualToString:@"toSettings"]) {
        
    }
}

- (IBAction)resetPickerView:(id)sender {
    [minutesPickerView reloadAllComponents];
    [minutesPickerView selectRow:0 inComponent:0 animated:YES];
    
    [secondsPickerView reloadAllComponents];
    [secondsPickerView selectRow:0 inComponent:0 animated:YES];
}

- (int)convertDoubleDigit:(NSString *)string {
    
    return string.intValue;
}


@end
