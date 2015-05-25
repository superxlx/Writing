//
//  XLX.m
//  Writing
//
//  Created by xlx on 15/5/22.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import "XLX.h"

@implementation XLX
//func insertBlurView (view: UIView,  style: UIBlurEffectStyle) {
//    view.backgroundColor = UIColor.clearColor()
//    var blurEffect       = UIBlurEffect(style: style)
//    var blurEffectView   = UIVisualEffectView(effect: blurEffect)
//    blurEffectView.frame = view.bounds
//    view.insertSubview(blurEffectView, atIndex: 0)
//}
+(void)insertBlurView:(id)view :(UIView *)view style:(UIBlurEffectStyle *)style{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurEffectView.frame = view.frame;
    [view insertSubview:blurEffectView atIndex:0];
}
+(void)insertLayout:(id)view :(UIView *)view{
    UIView *layout = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    layout.tag = 100;
    layout.backgroundColor = [UIColor grayColor];
    layout.alpha = 0.5;
    [view addSubview:layout];
}

@end
