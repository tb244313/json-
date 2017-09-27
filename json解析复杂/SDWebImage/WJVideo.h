//
//  WJVideo.h
//  json解析复杂
//
//  Created by apple on 2017/9/25.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJVideo : NSObject
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *url;
@property(nonatomic, assign) NSInteger length;
@property(nonatomic, strong) NSString *ID;
//@property(nonatomic, strong) NSString *description;


//工厂方法
//+(instancetype)videoWithDict:(NSDictionary *)dict;


@end
