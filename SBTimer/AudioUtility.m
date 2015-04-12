//
//  AudioUtility.m
//  SBTimer
//
//  Created by Master on 2015/04/13.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import "AudioUtility.h"

@implementation AudioUtility {
    AVAudioPlayer *audio;
}

static AudioUtility *sharedInstance = nil;

+ (AudioUtility *)sharedManager {
    if (!sharedInstance) {
        sharedInstance = [AudioUtility new];
    }
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        //Initialization
    }
    return self;
}

- (void)setSound:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    audio = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [audio prepareToPlay];
}

- (void)playSound {
    [audio play];
}

- (void)stopSound {
    [audio stop];
}

@end
