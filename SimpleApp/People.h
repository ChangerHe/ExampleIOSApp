//
//  People.h
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


// 类内使用成员变量, 类外使用属性
@interface People : NSObject
{
//    @public
    NSString *_peopleName;
    // 新版可以直接写在.m文件中
//    int _peopleAge;
//    int _peopleSex;
}
// 属性让类外可以访问成员变量
// 换句话说 属性是成员变量的外部接口
// 其实等同于暴露了对应属性的getter和setter方法
// 所以 当我们需要使用这个名称的时候, 需要进行一次指向操作, 指向成员变量的对应值
@property(nonatomic, strong)NSString *peopleName;

// + 代表类方法  - 代表实例方法, 类方法不通过实例即可调用
- (void) report;

+ (void) test;
@end

NS_ASSUME_NONNULL_END
