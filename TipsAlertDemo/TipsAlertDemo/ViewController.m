//
//  ViewController.m
//  TipsAlertDemo
//
//  Created by Jack on 16/3/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "ViewController.h"
#import "XYTipsAlert.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    XYTipsAlert *alert = [XYTipsAlert tipsAlertWithFrame:CGRectMake(0, 500, 100, 40) Title:@"详情"];
    XYTipsAlertAction *action1 = [XYTipsAlertAction tipsActionWithTitle:@"action1" handler:^(BOOL isSelected) {
        NSLog(@"action1");
    }];
    XYTipsAlertAction *action2 = [XYTipsAlertAction tipsActionWithTitle:@"action2" handler:^(BOOL isSelected) {
        NSLog(@"action2");
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self.view addSubview:alert];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
