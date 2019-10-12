//
//  ViewController.m
//  动画animal
//
//  Created by 张冲 on 2018/6/19.
//  Copyright © 2018年 张冲. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIView *animalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.animalView.transform = CGAffineTransformMakeRotation(-M_PI_4/4);
    [UIView animateWithDuration:2.0 delay:0.0 usingSpringWithDamping:0.1 initialSpringVelocity:4.0 options:UIViewAnimationOptionCurveLinear animations:^{
      CGPoint point =  self.animalView.center;
        point.y -= 10;
        self.animalView.center = point;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:4.0 animations:^{
            CGPoint point =  self.animalView.center;
            point.x += 100;
            self.animalView.center = point;
        } completion:^(BOOL finished) {
            [self shakeAnimationForView:self.animalView];

        }];
    }];

    // Do any additional setup after loading the view, typically from a nib.
}

//图片抖动
- (void)shakeAnimationForView:(UIView *) view {
    CALayer *viewLayer = view.layer;
    NSLog(@"viewLayer.positoin = %f,%f",viewLayer.position.x,viewLayer.position.y);
    viewLayer.anchorPoint = CGPointMake(0.5 , 1.0);
    viewLayer.position = CGPointMake(view.center.x + 6.25, view.center.y +25 );
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setFromValue:@(-M_PI_4/4)];
    [animation setToValue:@(M_PI_4/4)];
    animation.delegate = self;
    [animation setAutoreverses:YES];
    [animation setDuration:0.5];
    [animation setRepeatCount:2];
    animation.removedOnCompletion= NO;
    [viewLayer addAnimation:animation forKey:@"doudong"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (anim == [self.animalView.layer animationForKey:@"doudong"]) {
        [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.animalView.transform = CGAffineTransformMakeRotation(M_PI_4/4) ;

        } completion:^(BOOL finished) {
            [UIView animateWithDuration:4.0 animations:^{
                CGPoint point =  self.animalView.center;
                point.x += 100;
                self.animalView.center = point;
            } completion:^(BOOL finished) {
                self.animalView.transform = CGAffineTransformMakeRotation(0/4);
            }];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
