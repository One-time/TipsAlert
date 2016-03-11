//
//  XYTipsAlert.h
//  XYTipsAlert
//
//  Created by Jack on 16/3/10.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^Handler)(BOOL isSelected);

@interface XYTipsAlertAction : UIButton <NSCopying>

+ (instancetype)tipsActionWithTitle:(NSString *)title handler:(Handler)handler;


@end


@interface XYTipsAlert : UIView

+ (instancetype)tipsAlertWithFrame:(CGRect)frame Title:(NSString *)title;

- (void)addAction:(XYTipsAlertAction *)action;

//合适的时机隐藏弹窗视图
@property (nonatomic, getter = isShow)BOOL show;
@end
