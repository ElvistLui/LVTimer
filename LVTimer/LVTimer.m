//
//  LVTimer.m
//  LVTimerDemo
//
//  Created by ElvistLui on 2017/11/22.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import "LVTimer.h"

// 解决leak警告问题，http://www.jianshu.com/p/6517ab655be7
#define SuppressPerformSelectorLeakWarning(Stuff) \
        do { \
            _Pragma("clang diagnostic push") \
            _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
            Stuff; \
            _Pragma("clang diagnostic pop") \
        } while (0)

@interface LVTimer()

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

@implementation LVTimer

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)yesOrNo
{
    LVTimer *lvTarget = [[LVTimer alloc] init];
    
    lvTarget.target = aTarget;
    lvTarget.selector = aSelector;
    
    lvTarget.timer = [NSTimer scheduledTimerWithTimeInterval:ti
                                                      target:lvTarget
                                                    selector:@selector(startTimer:)
                                                    userInfo:userInfo
                                                     repeats:yesOrNo];
//    [[NSRunLoop currentRunLoop] addTimer:lvTarget.timer forMode:NSRunLoopCommonModes];
    
    return lvTarget.timer;
}

- (void)startTimer:(NSTimer *)timer
{
    if (self.target) {
        
        SuppressPerformSelectorLeakWarning([self.target performSelector:self.selector withObject:timer.userInfo];);
    } else {
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end
