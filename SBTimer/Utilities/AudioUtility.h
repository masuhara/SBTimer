//
//  AudioUtility.h
//  SBTimer
//
//  Created by Master on 2015/04/13.
//  Copyright (c) 2015年 net.masuhara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioUtility : NSObject

+ (AudioUtility *)sharedManager;
- (void)setSound:(NSString *)fileName;
- (void)playSound;
- (void)stopSound;

@end
