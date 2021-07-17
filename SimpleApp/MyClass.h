//
//  MyClass.h
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyClass : NSObject

// 成员变量访问修饰符
// 默认 protected
// @public  成员变量声明为public之后, 是可以直接在类外进行调用的
// @private  类内可以使用, 类外不可使用, 并且不可被继承
// @protected  类内可以使用, 类外不可使用, 可以继承
// @package  在框架内相当于受保护, 框架外相当于私有
// 成员变量需要声明在花括号里, 属性和函数需要声明在花括号外
{
    @public
    int _classInt;
    
}

// 属性
@property(nonatomic, strong) NSString *className;
// 方法(函数)
- (void) report;
 
@end

NS_ASSUME_NONNULL_END
