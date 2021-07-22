//
//  People.m
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/12.
//

#import "People.h"

// 这里代表类的扩展
// 一般情况来讲, 一个类并不是所有内容都需要对外暴露出来
// 而往往, 我们的类中会存在大量的类处理的逻辑等, 需要进行声明和定义
// 这个时候, 我们将属性和方法写在类扩展中, 就能够很方便的进行类的扩展声明, 而且不会影响到对外暴露的内容
@interface People ()

@end

@implementation People
{
//    int _peopleAge;
    int _peopleSex;
}

@synthesize test1;
@synthesize test2;

- (void) report {
    NSLog(@"-号: report");
    // 在实例方法中也可以调用类方法
    [People test];
    // 在-号方法中可以直接调用类的成员变量
    _peopleName = @"123";
}
static NSString *_peopleName1;
+ (void) test {
    NSLog(@"+hao  test");
    // 在+号方法中, 只能调用静态变量
    // 其他
    _peopleName1 = @"222";
}

- (int)showWithA:(int)a {
    return a;
}
- (int)showWithA:(int)a andB: (int)b {
    return a + b;
}

// 这里需要将成员变量与属性进行一次映射
// 相当于是建立了属性和成员变量之间的一种映射关系
// 但是, 因为类实例中, 是可以调用成员变量, 也可以调用属性的
// 这里如果成员变量和属性如果同名, 就会出现问题
// 所以一般来讲, 对应属性的成员变量, 我们一般加一个下划线开头, 表示成员变量是仅类内调用的
//@synthesize peopleName = _peopleName;
//@synthesize peopleAge = _peopleAge;

// 初始化方法  id类型 可以是任意类型, instancetype 当前类的实例的类型
// 一般来说, init方法应该使用instancetype类型
- (instancetype) init {
    self = [super init];
    if (self) {
        // 在类内, 需要调用成员变量而不是属性, 属性是给类外使用的
        _peopleName = @"张三";
        _test1 = @"test1";
        _test3 = @"test3";
//        _test2 = @"test2";
//        NSLog(@"test1 and test2 %@ %@", _test1. _test2);
        // 在新版本的ios中, 属性的成员变量不需要我们自己来声明, 而是在我们声明了属性之后, 成员变量自动生成
        // 也就意味着, 我们声明了@property(nonatomic, strong)NSString *peopleName;
        // 那么成员变量会自动生成一个*_peopleName
        
        // 对于没有属性的成员变量, 我们也不需要在声明中书写了, 直接写在.m文件中即可
        
    }
    return self;
}

- (instancetype) initWithPeopleNameAndAge:(NSString *)name andAge:(int)age {
    self = [super init];
    if (self) {
        _peopleName = name;
        _peopleAge = age;
    }
    NSLog(@"people age %d", _peopleAge);
    return self;
}

@end
