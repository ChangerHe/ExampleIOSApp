//
//  main.m
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/4.
//

// IOS声明周期:
// 1. 加载info.plist文件中的配置进行解析
// 2. 沙盒, (iOS8之后会每次生成一个新的沙盒, 参考模拟器运行时的沙盒路径)
// 3. 加载Mach-O可执行文件,读取dyld路径兵运行dyld动态链接器。 runtime就是在这个时候被初始化的, 同时还会加载c函数, Category以及C++静态函数, OC的+load方法, 最后dyld返回main函数地址, main函数被调用.(
//     1. load方法: 当类被引用进项目的时候就会执行load函数(在main函数开始执行之前） 与这个类是否被用到无关; 另外: load调用时机比较早,当load调用时,其他类可能还没加载完成,运行环境不安全. load方法是线程安全的，它使用了锁，我们应该避免线程阻塞在load方法)
//         1. 一个类的+load方法在其父类的+load方法后调用
//         2. 一个Category的+load方法在被其扩展的类自由+load方法后调用.当有多个类别(Category)都实现了load方法, 这几个load方法都会执行, 但执行顺序不确定(其执行顺序与类别在Compile Sources中出现的顺序一致)
//     2. initialize方法: 该方法在类或者子类的第一个方法被调用前调用, 即使类文件被引用进项目, 但是没有使用, initialize不会被调用, initialize与load方法相同为系统自动调用, 无需[super initialize]
//         1. 父类的initialize方法会比子类的initialize方法先执行
//         2. 当子类未实现initialize方法时, 会调用父类initialize方法.子类实现initialize方法时, 会覆盖父类initialize方法.
//         3. 当有多个Category都实现了initialize方法, 会覆盖类中的方法,只执行一个(会执行Compile Sources列表中最后一个Category的initialize方法)
// 4. main函数: main函数是iOS程序的入口, 返回值为int, 死循环并不会返回.

// 扩展阅读: [iOS应用程序的生命周期](https://www.jianshu.com/p/aa50e5350852)
// 扩展阅读: [iOS App生命周期理解](https://juejin.cn/post/6844903920079208461)

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "People.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        
        // 实例化对象  [类名  方法名]   或者  [对象名 方法名]
        // alloc用来为对象分配内存空间
        // init 用来进行初始化操作
        People *p1 = [[People alloc] init];
        // 使用new的方式也可以生成一个实例化对象
        People *p2 = [People new];
        
        p1.peopleName = @"张三";
        p2.peopleName = @"lisi";
        // 当装饰符为public时, 可以这样进行调用, 但不推荐这样使用
//        p2->_peopleName;
        NSLog(@"p1 peoplename %@", p1.peopleName);
        NSLog(@"p2 peoplename %@", p2.peopleName);
        
        // 调用-号方法的report
        [p1 report];
        // 调用+号方法的test
        [People test];
        NSLog(@"p1 --- %p %a", p1, p2);
        NSLog(@"p2 --- %d", p2);
        
        
    }
    // UIApplicationMain: 这个方法会初始化一个UIApplication实例以及他的代理
    //     argc: 参数个数
    //     argv: 参数
    //     principalClassName 根据该参数初始化一个UIApplication或其子类的对象并开始接收事件(传入nil, 意味使用默认的UIApplication)
    //     delegateClassName 该参数指定AppDelegate类作为委托, delegate对象主要用于监听, 类似于生命周期的回调函数
    //     返回: 返回值为int, 但是并不会返回(runloop), 会一直在内存中 直到程序终止
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
