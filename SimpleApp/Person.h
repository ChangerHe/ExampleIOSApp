//
//  Person.h
//  SimpleApp
//
//  Created by ChangerHe on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LookHomeDelegate <NSObject>

- (void) bark;

@end

@interface Person : NSObject

// 构建一个指针, 用来保存所有可以帮看家的对象
@property (strong, nonatomic) id<LookHomeDelegate> delegate;

- (void) lootAtHome;

@end

NS_ASSUME_NONNULL_END
