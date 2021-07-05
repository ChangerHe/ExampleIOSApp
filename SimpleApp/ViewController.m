//
//  ViewController.m
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/4.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear {
    [super viewDidAppear:false];
    NSLog(@"view appeared");
}

// 视图渲染完成的生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"view loaded");
    // 初始化一个hello world
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        
        label.text = @"hello world";
        [label sizeToFit];
        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        label;
    })];
    
    // 创建一个红色块, 距离为100, 100, 宽高为100, 100
    // 初始化UIView, 在视图中申请空间
    UIView *view = [[UIView alloc] init];
    // 设置其背景色
    view.backgroundColor = [UIColor redColor];
    // 设置其布局方式, x,y为100, 宽高为100
    view.frame = CGRectMake(100, 100, 100, 100);
    // 将创建的视图作为子视图, 加入到父视图中
    [self.view addSubview:view];
    
    // 创建一个绿色块, 距离为100, 100, 宽高为100, 100
    // 初始化UIView, 在视图中申请空间
    UIView *view2 = [[UIView alloc] init];
    // 设置其背景色
    view2.backgroundColor = [UIColor greenColor];
    // 设置其布局方式, x,y为100, 宽高为100
    view2.frame = CGRectMake(150, 150, 100, 100);
    // 将创建的视图作为子视图, 加入到父视图中
    [self.view addSubview:view2];
    
    // view的添加顺序决定了他们直接的覆盖关系, 如上: 绿色色块覆盖住了红色的色块
    
    
}


@end
