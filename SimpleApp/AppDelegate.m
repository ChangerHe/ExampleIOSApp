//
//  AppDelegate.m
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/4.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// app启动完成, 会走到这里
// 如果由通知打开, launchOptions对应的key有值
// iOS10之后UNUserNotificationCenterDelegate中的didReceiveNotificationResponse方法也能响应
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSLog(@"%s", __func__);
    // 初始化window视图
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabbarController = [[UITabBarController alloc] init];

    // 创建四个UIViewController, 来作为不同tab的切换页面
    UIViewController *controller1 = [[UIViewController alloc] init];
    controller1.view.backgroundColor = [UIColor redColor];
    controller1.tabBarItem.title = @"新闻";

    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor yellowColor];
    controller2.tabBarItem.title = @"新闻";

    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = [UIColor greenColor];
    controller3.tabBarItem.title = @"新闻";

    UIViewController *controller4 = [[UIViewController alloc] init];
    controller4.view.backgroundColor = [UIColor lightGrayColor];
    controller4.tabBarItem.title = @"新闻";

    // 将四个UIViewController加入到tabbar的视图中
    [tabbarController setViewControllers:@[controller1,controller2,controller3,controller4]];

    // 将tabbar视图加入到window根视图中
    self.window.rootViewController = tabbarController;
//    [self.window addSubview:tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

//// 程序由后台转入前台, 会调用此方法???
//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    NSLog(@"%s", __func__);
//}
//
//// 程序进入活跃状态 ??
//// 该方法app首次进入就会调用, 由后台转入前台, 也会在applicationWillEnterForeground方法之后调用
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    NSLog(@"%s", __func__);
//}
//
//// 程序进入非活跃状态 ??
//// 比如有电话进来或者锁屏等情况, 此时应用会先进入非活跃状态, 也有可能是程序即将进入后台(进入后台前会先调用)
//- (void)applicationWillResignActive:(UIApplication *)application {
//    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
//    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
//
//    NSLog(@"%s", __func__);
//}
//
//// 程序进入后台 ??
//// 当程序进入后台，很快便会就如挂起状态，在挂起状态下，无法执行任何代码。等到系统内存告急时会被杀死，
//// 如果有未完成的任务，可以在该方法下申请延时180s执行代码.
//- (void)applicationDidEnterBackground:(UIApplication *)application {
//    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
//    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    NSLog(@"%s", __func__);
//}
//
//// 程序即将退出 ??
//- (void)applicationWillTerminate:(UIApplication *)application {
//    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    NSLog(@"%s", __func__);
//}
//
//
//
//#pragma mark - UISceneSession lifecycle
//
//
//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}

@end
