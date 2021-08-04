//
//  WorkerDelegate.h
//  SimpleApp
//
//  Created by ChangerHe on 2021/8/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WorkerDelegate <NSObject>

// 公布一些协议的方法
- (void)debug;
- (void)coding;
- (void)readWords;

@end

NS_ASSUME_NONNULL_END
