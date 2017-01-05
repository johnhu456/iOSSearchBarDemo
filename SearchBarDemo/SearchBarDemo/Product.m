//
//  Product.m
//  SearchBarDemo
//
//  Created by 胡翔 on 2017/1/5.
//  Copyright © 2017年 胡翔. All rights reserved.
//

#import "Product.h"

@implementation Product
- (instancetype)initWithName:(NSString *)name
                        type:(NSUInteger)type {
    if (self = [super init]) {
        _name = name;
        _type = type;
    }
    return self;
}

+ (NSArray *)demoData {
    Product *iPhone5 = [[Product alloc] initWithName:@"iPhone5" type:0];
    Product *iPhone6 = [[Product alloc] initWithName:@"iPhone6" type:0];
    Product *watch = [[Product alloc] initWithName:@"Apple Watch" type:0];
    Product *osx = [[Product alloc] initWithName:@"macOS Sierra" type:1];
    Product *capsule = [[Product alloc] initWithName:@"AirPort Time Capsule" type:2];
    return @[iPhone5,iPhone6,watch,osx,capsule];
}
@end
