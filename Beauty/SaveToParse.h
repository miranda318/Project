//
//  SaveToParse.h
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface SaveToParse : NSObject

+(void)saveToParse:(NSString*)className properties:(NSDictionary*)dic;//save an object to parse, the dic is its property name and value


@end
