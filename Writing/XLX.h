//
//  XLX.h
//  Writing
//
//  Created by xlx on 15/5/22.
//  Copyright (c) 2015年 xlx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XLX : NSObject
//func insertBlurView (view: UIView,  style: UIBlurEffectStyle)
+(void)insertBlurView:view:(UIView *)view style:(UIBlurEffectStyle*)style;
+(void)insertLayout:view:(UIView *)view;
@end
