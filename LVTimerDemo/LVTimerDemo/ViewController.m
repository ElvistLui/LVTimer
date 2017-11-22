//
//  ViewController.m
//  LVTimerDemo
//
//  Created by ElvistLui on 2017/11/22.
//  Copyright © 2017年 Elvist. All rights reserved.
//

#import "ViewController.h"
#import "TimerViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
    TimerViewController *vc = [mainStoryBoard instantiateViewControllerWithIdentifier:@"TimerViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
    self.label.text = @"";
    
    __weak typeof(self) weakSelf = self;
    vc.block = ^(NSInteger page){
        
        if (page == -1) {
            
            weakSelf.label.text = @"TimerViewController被释放";
        } else {
            
            weakSelf.label.text = [NSString stringWithFormat:@"计时中：%ld", page];
        }
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
