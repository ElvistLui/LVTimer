//
//  LVTimer.h
//  LVTimerDemo
//
//  Created by ElvistLui on 2017/11/22.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LVTimer : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                     target:(id)aTarget
                                   selector:(SEL)aSelector
                                   userInfo:(id)userInfo
                                    repeats:(BOOL)yesOrNo;

@end
