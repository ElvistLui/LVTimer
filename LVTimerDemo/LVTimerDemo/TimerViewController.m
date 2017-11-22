//
//  TimerViewController.m
//  LVTimerDemo
//
//  Created by ChinaLink on 2017/11/22.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import "TimerViewController.h"
#import "LVTimer.h"

@interface TimerViewController ()

@property (nonatomic, strong) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TimerViewController
{
    NSInteger _second;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)startTimer:(NSTimer *)timer
{
    _second++;
    
    _label.text = [NSString stringWithFormat:@"%ld", _second];
    
    if (self.block) self.block(_second);
}

#pragma mark - 按钮点击事件
- (IBAction)didClickedNSTimerButton:(UIButton *)sender {
    
    [_timer invalidate];
    _timer = nil;
    _second = 0;
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(startTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (IBAction)didClickedLVTimerButton:(UIButton *)sender {
    
    [_timer invalidate];
    _timer = nil;
    _second = 0;
    
    _timer = [LVTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(startTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)dealloc
{
    if (self.block) self.block(-1);
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
