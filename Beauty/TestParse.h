//
//  TestParse.h
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "SaveToParse.h"
#import "QueryFromParse.h"

@interface TestParse : NSObject

+(void)testConnection;
+(void)testSaveToParse;
+(void)testQueryFromParse;

+(void)test;

@end
