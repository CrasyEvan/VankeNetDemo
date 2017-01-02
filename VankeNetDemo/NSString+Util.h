//
//  NSString+Util.h
//  ZKFramework
//
//  Created by kyori.hu on 12-10-10.
//  Copyright (c) 2012 kyori.hu@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Trim)

//去掉空格
- (NSString *)trim;

@end


@interface NSString (Util)

- (NSString *)md5String;
- (NSString *)base64String;
- (NSString *)urlencodeString;
- (NSString *)chineseNumString;

@end
