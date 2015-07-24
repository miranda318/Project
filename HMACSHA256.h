//
//  HMACSHA256.h
//  Amazon_API_Test
//
//  Created by WeifengCui on 7/22/15.
//  Copyright © 2015 Weifeng Cui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMACSHA256 : NSObject
{
    
}

#pragma mark Public Interface
+ (NSString *)getSignedRequest:(NSString *)undatedUnsortedUnsignedUrlString
                    withSecret:(NSString *)secretKey;

#pragma mark Helpers for Creation of Signed Amazon.com AWS REST Request
+ (NSString *)appendTimestamp:(NSString *)undatedUrlString;
+ (NSString *)sortUrlString:(NSString *)unsortedUrlString;
+ (NSString *)signUrlString:(NSString *)unsignedUrlString
                 withSecret:(NSString *)secretKey;

#pragma mark HMAC SHA256 signing, Base64 encoding, and Canonical Transformation
+ (NSData *)HMACforString:(NSString *)string
               withSecret:(NSString *)secretKey;
+ (NSString *)base64forData:(NSData *)data;
+ (NSString *)transformServiceAddress:(NSString *)serviceAddress;

@end