//
//  AmazonAPI.m
//  Beauty
//
//  Created by WeifengCui on 7/24/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "AmazonAPI.h"

@implementation AmazonAPI

+(NSDictionary*)getProductInfoFromUPC:(NSString *)upcID{
    
    
    NSString* url = [NSString stringWithFormat:@"%@",[Demo getUPCURL:upcID] ];
    return [self urlToDic:url];
   

}


+(NSDictionary*)urlToDic:(NSString*)url{
    NSURL *URL = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
    NSError *error = nil;
    
    NSDictionary *dictionary = [XMLReader dictionaryForXMLData:data error:&error];
    return dictionary;
}



//search by key word
+(NSDictionary*)getProductsByKeyWorkds:(NSString *)keyWord{
    NSString* url = [NSString stringWithFormat:@"%@",[Demo getKeyWordSearchURL:keyWord] ];
    return [self urlToDic:url];

}


//search customer reviews
+(NSDictionary*)getCustomerReviews:(NSString *)upcID{
    NSString* url = [NSString stringWithFormat:@"%@",[Demo getReviewsURL:upcID] ];
    return [self urlToDic:url];

}


@end
