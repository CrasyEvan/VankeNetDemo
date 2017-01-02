//
//  NSString+Util.m
//  ZKFramework
//
//  Created by kyori.hu on 12-10-10.
//  Copyright (c) 2012 kyori.hu@gmail.com. All rights reserved.
//

#import "NSString+Util.h"
#import "base64.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Trim)

- (NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end


@implementation NSString (Util)

- (NSString *)base64String
{
	const char *szUtf8 = [self UTF8String];
	if ( szUtf8 ) {
		char szBase64[2048];
		memset( szBase64, 0, sizeof(szBase64) );
		Base64Encode( szBase64, (const unsigned char*)szUtf8, strlen(szUtf8) );
		NSString *strBase64 = [NSString stringWithUTF8String:szBase64];
		return strBase64;
	}
	return nil;
}


- (NSString *)md5String
{
	NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5([data bytes], [data length], result);
	return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]] lowercaseString];
}


- (NSString *)urlencodeString
{
	NSString *strUrlencode =  [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	strUrlencode = [strUrlencode stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
	strUrlencode = [strUrlencode stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
	return strUrlencode;
}

- (NSString *)chineseNumString
{

     //该转换方法会随系统语言变化而变化
     // kCFNumberFormatterRoundCeiling = 0,  //四舍五入,直接输出4
     // kCFNumberFormatterRoundFloor = 1 ,    //保留小数输出3.8
     // kCFNumberFormatterRoundDown = 2,   //加上了人民币标志,原值输出￥3.8
     // kCFNumberFormatterRoundUp = 3,      //本身数值乘以100后用百分号表示,输出380%
     // kCFNumberFormatterRoundHalfEven = 4,//输出3.799999999E0
     // kCFNumberFormatterRoundHalfDown = 5,//原值的中文表示,输出三点七九九九。。。。
     // kCFNumberFormatterRoundHalfUp = 6//原值中文表示,输出第四
     
     
     NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
     formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
     formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
     
     NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt: [self intValue]]];
     
     return string;
    
}


@end

