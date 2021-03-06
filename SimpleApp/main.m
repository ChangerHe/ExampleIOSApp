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
#import "MyClass.h"
#import "People+Test.h"
#import "Person.h"
#import "BigDog.h"
#import "Student.h"

@interface SampleClass: NSObject

-(int)max:(int)num1:(int)num2;

@end

@implementation SampleClass

-(int)max:(int)num1:(int)num2 {
    int result;
    if (num1 > num2) {
        result = num1;
    } else {
        result = num2;
    }
    return result;
}

@end

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
        
        People *p3 = [[People alloc] initWithPeopleNameAndAge:@"王五" andAge:18];
        
//        p1.peopleName = @"张三";
        p2.peopleName = @"lisi";
        // 当装饰符为public时, 可以这样进行调用, 但不推荐这样使用
//        p2->_peopleName;
        // 默认情况下, 因为初始化的时候回调用init的方法
        // 所以在不赋值的情况下, 也能够获取到默认的peopleName是张三
        NSLog(@"p1 peoplename %@", p1.peopleName);
        NSLog(@"p2 peoplename %@", p2.peopleName);
        NSLog(@"p3 peoplename %@", p3.peopleName);
        
        // 调用-号方法的report
        [p1 report];
        // 调用+号方法的test
        [People test];
        NSLog(@"p1 --- %p %a", p1, p2);
        NSLog(@"p2 --- %d", p2);
        NSLog(@"p1 test1 --- %@", [p1 test1]);
        NSLog(@"p2 test3 --- %@", p2.test3);
        // 使用类的扩展, 引入类的扩展的声明之后, 类的扩展方法就可以直接调用了
        // 但是需要注意的是, 类的扩展中, 不能扩展内置变量
        // 同时, 有些情况下, 基类有内置变量, 但是没有getter和setter方法时, 可以在扩展类中定义对应内置变量的属性
        // 扩展类中定义了内置变量的属性之后, 就可以使用这个内置变量了
        [p1 extendTest];
        
        // 注意 这样子调用赋值是不行的, 赋值不上去, 每个对象都需要独立进行声明之后赋值
        p1.book.name = @"测试书";
        [p1 showBook];
        
        // 只有声明之后的对象, 才可以被修改和赋值调用
        Book *book1 = [Book new];
        book1.name = @"测试书";
        book1.price = 13;
        p1.book = book1;
        [p1 showBook];
        NSLog(@"people description formatted value is: %@", p1);
        
        
        int a1 = [p1 showWithA:10];
        int a2 = 20;
        int a3 = [p2 showWithA:a1 andB: a2];
        NSLog(@"%d + %d = %d", a1, a2, a3);
        
        MyClass *mc = [[MyClass alloc]init];
        mc.className = @"我的类";
        // 如果声明为@public的成员变量, 则只可以通过指向来进行调用
        mc->_classInt = 1001;
        [mc report];
        
        
        
    }
    
    // Objective-C 语法
//    一. 类型
//      类型分为: 基本类型/枚举类型/void类型/派生类型
//      1. 整数类型
//    char:  1字节 -128 ~ 127 或 0 ~ 255
//    unsigned char: 1字节 0 ~ 255
//    signed char: 1字节 -128 ~ 127
//    int: 2或4字节 -32,768 ~ 32,767 或 -2,147,483,648 ~ 2,147,483,647
//    unsigned int: 2或4字节 0 ~ 65,535 或 0 ~ 4,294,967,295
//    short: 2字节 -32,768 ~ 32,767
//    unsigned short: 2字节 0 ~ 65,535
//    long: 4字节 -2,147,483,648 ~ 2,147,483,647
//    unsigned long: 4字节 0 ~ 4,294,967,295
    
    // 使用sizeof, 获取到的是其占用的字节数量
    NSLog(@"Storage size for int : %d \n", sizeof(int));
//      2. 浮点类型
//    float: 4字节 1.2E-38 ~ 3.4E+38 6位小数
//    double: 8字节 2.3E-308 ~ 1.7E+308 15位小数
//    long double: 10字节 3.4E-4932 ~ 1.1E+4932 19位小数
    NSLog(@"Storage size for float : %d , maxval=%f \n", sizeof(float), FLT_MAX);
//      3. void类型
//    void类型指定没有可用的值。它用于两种情况: 1.函数指定返回void 2.函数参数为void
//    二. 变量
//      1. Objective-C变量定义: type variable_list;
//          这里，type必须是有效的Objective-C数据类型，它包括：char，w_char，int，float，double，bool或任何用户定义的对象等
//          variable_list可以包含一个或多个用逗号分隔的标识符名称。下面显示了一些有效的声明
//            int    i, j, k;
//            char   c, ch;
//            float  f, salary;
//            double d;
//        同时, 我们也可以为变量声明一个值
//            extern int d = 2, f = 3;
//            int d = 3, f = 5;
//            byte z = 22;
//            char x = 'x';
//      2.  使用extern关键字在任何地方声明变量。 虽然可以在Objective-C程序中多次声明变量，但它只能在文件，函数或代码块中定义一次。
//    三. 常量
//        1. 常用常量
//      212, 215u, 0xFeeL, 3.14159, 314159E-5L // 这些都是合法有效的常量
//       \\ , \', , \a 警报, \b 退格, \f 换页, \n 换行, \r 回车, , \t 水平制表, \v 垂直制表, \ooo 八进制的一到三位数
//        NSLog(@"Yiibai\t.com\n\n"); // Yiibai    .com
//        2. 定义常量
//          可以使用#define预处理器 或者使用const关键字。
    
    // 定义常量 ???
    const int  LENGTH = 10;
    const int  WIDTH  = 15;
            int area = LENGTH * WIDTH;
    NSLog(@"value of area : %d");
    // 使用const关键字作为前缀来声明具有特定类型的常量，如下所示 -
//    const type variable = value;
    
//    四. 函数
    int a = 123;
    int b = 456;
    int ret;
    SampleClass *sampleClass = [[SampleClass alloc] init];
    ret = [sampleClass max: a: b];
    NSLog(@"max value is: %d \n", ret);
    
    // Fundation常用的方法
    //    1. NSString
    NSString *str0 = @"1948 beijing";
    NSString *str1 = [NSString stringWithFormat:@"%d beijing", 1948];
    NSLog(@"string with formated value: %@", str1);
    NSString *str2 = [[NSString alloc] initWithFormat:@"%d beijing", 1987];
    NSLog(@"string init with formated value: %@", str2);
    NSUInteger length = str1.length;
    NSLog(@"nsu integer str1 length: %ld, and normal length: %ld", length, [str1 length]);
    BOOL isEqual = [str0 isEqualToString:str1];
    BOOL isNormalEqual = [str0 isEqual:str1];
    NSLog(@"str0 and str1 is equal: %d, normal equal: %d", isEqual, isNormalEqual);
    if (isNormalEqual) {
        NSLog(@"相等");
    }
    
    //    2. NSMutableArray  可变数组
    //       NSMutableArray 可以存放任意类型的对象
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array addObject:@"obj1"];
    [array addObject:@"obj2"];
    [array removeObjectAtIndex:0];
    NSLog(@"get array index 0: %@", array[0]); // obj2 因为obj1已经删除
    
    // 读取沙盒
    NSString* documentPath = NSHomeDirectory();
    
    // 拼接路径
    NSString* directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    // 住: 拼接路径可被读写的  只有Document
    NSLog(@"documentPath = %@, directory is =", documentPath, directory);
    // 读取应用程序束
    NSString* routeFilePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSString* myData = @"赵";
    
    NSArray* datasource = [NSArray arrayWithContentsOfFile: routeFilePath];
    
    NSLog(@"routeFilePath =  %@", routeFilePath);
    NSLog(@"datasource =  %@", datasource);
    
    // 错误处理
    @try {
        YES == nil;
    } @catch (NSException *exception) {
        NSLog(@"error happened: %@", exception);
    } @finally {
        NSLog(@"goto here whenever error happened");
    }
    
    // 时间处理
    NSDate* now = [NSDate date];
    NSLog(@"current time is: %@", now);
    // 超过当前时间的一段时间
    NSDate* offsetNow = [now dateByAddingTimeInterval:16*60];
    NSLog(@"time offset 16min is: %@", offsetNow);
    // 计算两个时间中的差值
    NSTimeInterval offsetTime = [offsetNow timeIntervalSinceDate:now];
    NSLog(@"time between two time: %f", offsetTime);
    // 日期格式化
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm:ss"];
    NSString* dateString = [dateFormatter stringFromDate:now];
    NSLog(@"current formatted date is: %@", dateString);
    
    Person* person1 = [Person new];
    BigDog* bigDog = [BigDog new];
    // 使用delegate属性, 挂载对应的对象, 从而达到使用对应对象的相应方法或者属性的目的
    person1.delegate = bigDog;
    
    [person1 lootAtHome];
    
    // 定义了协议的类, 需要完成协议对应的属性和方法
    Student* student1 = [Student new];
    [student1 coding];
    [student1 readWords];
    [student1 debug];
    
    // UIApplicationMain: 这个方法会初始化一个UIApplication实例以及他的代理s
    //     argc: 参数个数
    //     argv: 参数
    //     principalClassName 根据该参数初始化一个UIApplication或其子类的对象并开始接收事件(传入nil, 意味使用默认的UIApplication)
    //     delegateClassName 该参数指定AppDelegate类作为委托, delegate对象主要用于监听, 类似于生命周期的回调函数
    //     返回: 返回值为int, 但是并不会返回(runloop), 会一直在内存中 直到程序终止
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);

}
