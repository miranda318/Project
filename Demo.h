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


+(NSString*)getUPCURL;
+(NSString*)getUPCURL:(NSString*)upcID;

/*
Adding the following to your Info.plist will disable ATS

"App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure"
 
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key><true/>
 </dict>
 
 */
+(NSDictionary*)getDicFromURL:(NSString*)url;




+(void)testXMLReader;


@end
