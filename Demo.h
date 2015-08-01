//
//  Demo.h
//  Amazon_API_Test
//
//  Created by WeifengCui on 7/22/15.
//  Copyright © 2015 Weifeng Cui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMACSHA256.h"
#import "XMLReader.h"

@interface Demo : NSObject

+(void)UPCRequest; // get the signed upc request



+(NSString*)getUPCURL:(NSString*)upcID;
+(NSString*)getReviewsURL:(NSString*)upcID;
+(NSString*)getReviewsURLByASIN:(NSString *)asin;
+(NSDictionary*)getDicFromURL:(NSString*)url;
+(NSString*)getKeyWordSearchURL:(NSString*)keyword;
+(NSString*)getImagesURL:(NSString*)itemID;


+(void)testXMLReader;


@end
