//
//  AmazonAPI.h
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMACSHA256.h"
#import "Demo.h"


@interface AmazonAPI : NSObject

+(NSDictionary*)getProductInfoFromUPC:(NSString*)upcID;//find the info of a product according to upc



@end
