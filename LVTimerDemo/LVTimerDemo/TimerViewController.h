//
//  TimerViewController.h
//  LVTimerDemo
//
//  Created by ChinaLink on 2017/11/22.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController

@property (nonatomic, copy) void(^block)(NSInteger);

@end
