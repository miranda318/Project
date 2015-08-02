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
    NSString* upc = @"022600939511";
    NSDictionary* dic =  [AmazonAPI getCustomerReviews:upc];
    NSLog(@"%@",dic);
    
    
//    NSDictionary* dic = [AmazonAPI getProductsByKeyWorkds:@"computer"];
//     NSLog(@"%@",dic);
}

@end
