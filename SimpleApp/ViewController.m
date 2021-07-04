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
    // Do any additional setup after loading the view.
    [self.view addSubview:({
        UILabel *label = [[UILabel alloc] init];
        
        label.text = @"hello world";
        [label sizeToFit];
        label.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        label;
    })];
}


@end
