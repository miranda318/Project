//
//  SaveToParse.m
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "SaveToParse.h"

@implementation SaveToParse

+(void)saveToParse:(NSString *)className properties:(NSDictionary *)dic{

    PFObject *savedObject = [PFObject objectWithClassName:className];
    
    for (NSString* key in dic) {
        id value = [dic objectForKey:key];
        savedObject[key] = value;
    }
    [savedObject saveInBackground];
}

@end
