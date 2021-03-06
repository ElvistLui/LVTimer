# LVTimer

由于NSTimer实例的block初始化方式只支持iOS10+，所以下面的初始化方法更加常见：实例本身作为其成员变量_timer的target。

```
_timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                          target:self
                                        selector:@selector(startTimer) userInfo:nil
                                         repeats:YES];

```

使用此方法可能遇到的问题是，如果不在合适的时机执行`[_timer invalidate]`,那么就会造成循环引用导致内存泄漏。

---

这里使用一个中间人作为target，重写NSTimer的`+ (NSTimer *)scheduledTimerWithTimeInterval: target: selector: userInfo: repeats:`方法，解除循环引用问题：

```
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

```
