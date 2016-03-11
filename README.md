# TipsAlert


转载请注明出处

简介：按钮点击弹按钮列表，点击父视图空白处或其它响应事件，收回列表。

<p>使用方法：</p>

  1. 将XYTipsAlert.h、XYTipsAlert.m导入工程，相应的控制器`#import "XYTipsAlert.h"`。
  1. alert初始化
  
    <code> XYTipsAlert *alert = [XYTipsAlert tipsAlertWithFrame:CGRectMake(0, 500, 100, 40) Title:@"详情"]; </code>

  2. action初始化
  
    <code>    XYTipsAlertAction *action1 = [XYTipsAlertAction tipsActionWithTitle:@"action1" handler:^(BOOL isSelected) {
        NSLog(@"action1");
    }];
</code>

  3. 添加Action
  
    <code>[alert addAction:action1];</code>
    
  4. 将alert添加到父视图
  
 ` [self.view addSubview:alert];`
