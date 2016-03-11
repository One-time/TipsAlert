//
//  XYTipsAlert.m
//  XYTipsAlert
//
//  Created by Jack on 16/3/10.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "XYTipsAlert.h"

@interface XYTipsAlertAction ()
@property (nonatomic, copy)Handler handler;
@property (nonatomic, getter = isFirst)BOOL first;
@end

@implementation XYTipsAlertAction


+ (instancetype)tipsActionWithTitle:(NSString *)title handler:(Handler)handler{
    XYTipsAlertAction *action = [[XYTipsAlertAction alloc]initWithTitle:title];
    action.handler = handler;
    
    return action;


}

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setTitle:title forState:UIControlStateNormal];
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}


- (void)click:(XYTipsAlertAction *)sender{
    sender.selected = !sender.selected;
    XYTipsAlert *alert = (id)sender.superview.superview;
    if (alert.isShow) {
        [alert setShow:NO];
    }
    sender.handler(sender.selected);
    
}

#pragma mark -- setter

- (void)setFirst:(BOOL)first{
    _first = first;
    CAShapeLayer *layer = (id)[self layer];
    layer.lineWidth = 1.0f;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), 0)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    
    if (first) {
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2 + 10, CGRectGetHeight(self.frame))];
        
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)+10)];
        
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame)/2 - 10,CGRectGetHeight(self.frame))];
        
    }
    [path closePath];
    layer.path = path.CGPath;

}

+ (Class)layerClass{
    
    return [CAShapeLayer class];
}

#pragma mark -- copy

- (id)copyWithZone:(NSZone *)zone{
    XYTipsAlertAction *action = [self copyWithZone:zone];
    action.handler = self.handler;
    action.first = self.first;
    return action;
}

@end

@interface XYTipsAlert ()

@property (assign, nonatomic) CGRect orignFrame;
@property (assign, nonatomic) CGRect newFrame;

@property (nonatomic, strong) NSMutableArray<XYTipsAlertAction *> *actions;

@property (nonatomic, strong) UIButton *titleButton;

@property (nonatomic, strong) UIView *titlesView;


@end

@implementation XYTipsAlert

#pragma mark -- init 

+ (instancetype)tipsAlertWithFrame:(CGRect)frame Title:(NSString *)title{
    
    XYTipsAlert *tipsAlert = [[XYTipsAlert alloc]initWithFrame:frame title:title];
    return tipsAlert;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.orignFrame = self.frame;
        [self.titleButton setFrame:frame];
        [self.titleButton setTitle:title forState:UIControlStateNormal];
        [self addSubview:self.titleButton];
    }
    return self;
}

#pragma mark -- addAction

- (void)addAction:(XYTipsAlertAction *)action{
    [self.actions insertObject:action atIndex:0];
    [self setNeedsLayout];
    [self.titlesView addSubview:action];
    
}

- (void)layoutSubviews{
    
    CGFloat height = (self.titlesView.subviews.count +1) * CGRectGetHeight(self.orignFrame)+10;
    
    self.newFrame = CGRectMake(self.orignFrame.origin.x, self.orignFrame.origin.y - self.titlesView.subviews.count * CGRectGetHeight(self.orignFrame)-10, CGRectGetWidth(self.frame), height);
    
    self.titleButton.frame = CGRectMake(0, CGRectGetHeight(self.frame) - CGRectGetHeight(self.orignFrame), CGRectGetWidth(self.frame), CGRectGetHeight(self.orignFrame));
    self.titlesView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), self.titlesView.subviews.count * CGRectGetHeight(self.orignFrame));
    
    [self.actions enumerateObjectsUsingBlock:^(XYTipsAlertAction * _Nonnull action, NSUInteger idx, BOOL * _Nonnull stop) {
        action.frame = CGRectMake(0, idx * CGRectGetHeight(self.orignFrame), CGRectGetWidth(self.frame), CGRectGetHeight(self.orignFrame));
        if (idx == 1) {
            action.first = YES;
        }else{
            action.first = NO;
        }

    }];
    
}


#pragma mark -- IBAction

- (IBAction)tapClick:(UIButton *)sender{
    self.show = !self.isShow;
    
}

#pragma mark -- setter

- (void)setShow:(BOOL)show{
    _show = show;
    __weak XYTipsAlert *weakSelf = self;
    if (_show) {
        self.frame = self.newFrame;
        [self.titlesView setHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [weakSelf.titlesView setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [weakSelf.titlesView setHidden:NO];
        }];
        
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            [weakSelf.titlesView setAlpha:0.f];
        } completion:^(BOOL finished) {
            [weakSelf.titlesView setHidden:YES];
            weakSelf.frame = weakSelf.orignFrame;
        }];
    
    }

}

#pragma mark -- getter

- (NSMutableArray<XYTipsAlertAction *> *)actions{
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;

}

- (UIButton *)titleButton{
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [_titleButton addTarget:self action:@selector(tapClick:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _titleButton;
}

- (UIView *)titlesView{
    if (!_titlesView) {
        _titlesView = [[UIView alloc]init];
        _titlesView.backgroundColor = [UIColor whiteColor];
        [_titlesView setAlpha:0];
        [_titlesView setHidden:YES];
        [self addSubview:_titlesView];
    }
    return _titlesView;
}

#pragma mark -- TouchHandle

////在该视图所在的区域，点击空白收回View；
//
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    

    BOOL isContaint =  [self pointInside:point withEvent:event];
    
    if (isContaint) {
        
        if ([self.titleButton pointInside:[self.titleButton convertPoint:point fromView:self] withEvent:event]) {
            return self.titleButton;
        }else{
            for (XYTipsAlertAction *action in self.actions) {
                if ([action pointInside:[action convertPoint:point fromView:self] withEvent:event]) {
                    return action;
                }
            }
            return nil;
        }
        
    }else{
        
        self.show = NO;
        return nil;
    }
}

@end

