//
//  Book.h
//  SimpleApp
//
//  Created by ChangerHe on 2021/7/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject

@property(strong, nonatomic) NSString *name;
@property(assign,  nonatomic) NSInteger price;

- (void) showBook;

@end

NS_ASSUME_NONNULL_END
