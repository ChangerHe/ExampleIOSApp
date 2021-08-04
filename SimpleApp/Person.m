//
//  Person.m
//  SimpleApp
//
//  Created by ChangerHe on 2021/8/4.
//

#import "Person.h"
#import "Dog.h"

@implementation Person

- (void) lootAtHome {
//    Dog* xiaobai = [Dog new];
//
//    [xiaobai bark];
    
    [self.delegate bark];
}

@end
