//
//  TimerViewController.m
//  SBTimer
//
//  Created by Master on 2015/04/12.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "TimerViewController.h"
#import "AudioUtility.h"
#import "UIManager.h"

@interface TimerViewController ()

@end

@implementation TimerViewController {
    IBOutlet UILabel *minutesLabel;
    IBOutlet UILabel *secondsLabel;
    
    IBOutlet UIImageView *completeImageView;
    IBOutlet UIImageView *dogImageView;
    
    IBOutlet UIButton *switchButton;
    
    int minutes;
    int seconds;
    BOOL isStarted;
    NSTimer *timer;
}

@synthesize minutes;
@synthesize seconds;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    minutes = self.minutes;
    seconds = self.seconds;
    
    minutesLabel.text = [NSString stringWithFormat:@"%02d", minutes];
    secondsLabel.text = [NSString stringWithFormat:@"%02d", seconds];
    
    completeImageView.image = [UIImage imageNamed:@"completed.png"];
    dogImageView.image = DOG_NORMAL;
    completeImageView.hidden = YES;
    
    [[AudioUtility sharedManager] setSound:@"marimba"];
}

- (void)viewDidAppear:(BOOL)animated {
    [self startTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    completeImageView.hidden = YES;
    dogImageView.image = DOG_NORMAL;
    
    if (timer) {
        [timer invalidate];
    }
    [[AudioUtility sharedManager] stopSound];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void)startTimer {
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        [timer fire];
        isStarted = YES;
    }
}

- (IBAction)switchTimer:(id)sender {
    if (isStarted) {
        [timer invalidate];
        timer = nil;
        isStarted = NO;
        [switchButton setBackgroundImage:START_BUTTON
                            forState:UIControlStateNormal];
    }else {
        [self startTimer];
        [switchButton setBackgroundImage:STOP_BUTTON
                                forState:UIControlStateNormal];
    }
}

- (void)countDown {
    if (minutes <= 0 && seconds <= 0) {
        [timer invalidate];
        [self playSound];
    }else {
        seconds--;
        secondsLabel.text = [NSString stringWithFormat:@"%02d", seconds];
        if (seconds < 0) {
            seconds = 60;
            minutes--;
            minutesLabel.text = [NSString stringWithFormat:@"%02d", minutes];
        }
    }
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playSound {
    completeImageView.hidden = NO;
    dogImageView.image = DOG_ANGRY;
    [[AudioUtility sharedManager] playSound];
}

@end
