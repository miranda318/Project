//
//  TestAmazonAPI.m
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "TestAmazonAPI.h"

@implementation TestAmazonAPI

+(void)test{
    NSString* upc = @"635753490879";
    NSDictionary* dic =  [AmazonAPI getProductInfoFromUPC:upc];
    NSLog(@"%@",dic);
}

@end
