//
//  People.m
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/12.
//

#import "People.h"

@implementation People
{
    int _peopleAge;
    int _peopleSex;
}
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

// 这里需要将成员变量与属性进行一次映射
// 相当于是建立了属性和成员变量之间的一种映射关系
// 但是, 因为类实例中, 是可以调用成员变量, 也可以调用属性的
// 这里如果成员变量和属性如果同名, 就会出现问题
// 所以一般来讲, 对应属性的成员变量, 我们一般加一个下划线开头, 表示成员变量是仅类内调用的
@synthesize peopleName = _peopleName;

- (instancetype) init {
    self = [super init];
    if (self) {
        // 在类内, 需要调用成员变量而不是属性, 属性是给类外使用的
        _peopleName = @"张三";
        
        // 在新版本的ios中, 属性的成员变量不需要我们自己来声明, 而是在我们声明了属性之后, 成员变量自动生成
        // 也就意味着, 我们声明了@property(nonatomic, strong)NSString *peopleName;
        // 那么成员变量会自动生成一个*_peopleName
        
        // 对于没有属性的成员变量, 我们也不需要在声明中书写了, 直接写在.m文件中即可
        
    }
    return self;
}

@end
