//
//  TestParse.m
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "TestParse.h"

@implementation TestParse

+(void)test{
    [self testQueryFromParse];
}


+(void)testSaveToParse{
    NSDictionary* dic =  @{@"key1" : @"value1", @"key2" : @"value2", @"key3" : @"value3"};
    
    NSString* className = @"testSaveParse";
    [SaveToParse saveToParse:className properties:dic];

}



+(void)testConnection{

    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
}


+(void)testQueryFromParse{
    [QueryFromParse readFromParseDemo:@"testSaveParse"];

}

@end
