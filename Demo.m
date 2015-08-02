//
//  Demo.m
//  Amazon_API_Test
//
//  Created by WeifengCui on 7/22/15.
//  Copyright © 2015 Weifeng Cui. All rights reserved.
//

#import "Demo.h"

@implementation Demo

+(void)UPCRequest{

//    NSString* url = [self getUPCURL];
//    NSLog(@"url :%@",url);


}







+(NSString*)getUPCURL:(NSString*)upcID{
    
    NSString* AWSAccessKeyID=@"AKIAIX5TQ2GXCVNFZPZA";
    NSString* AWS_SECRET=@"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";
    
    NSString* urlString = [NSString stringWithFormat: @"http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemLookup&ResponseGroup=Large&SearchIndex=All&IdType=UPC&ItemId=%@&AWSAccessKeyId=%@&AssociateTag=weifcuiperswe-20",upcID,AWSAccessKeyID];
    
    NSString *signedURLString = [HMACSHA256 getSignedRequest:urlString withSecret:AWS_SECRET];
    NSURL *url	= [NSURL URLWithString:signedURLString];
    return url;
    
}


+(NSString*)getReviewsURL:(NSString*)upcID{
    return [self getReviewSURL_BYTYPE:upcID type:@"UPC"];

}

+(NSString*)getReviewsURLByASIN:(NSString *)asin{

    return [self getReviewSURL_BYTYPE:asin type:@"ASIN"];
}


+(NSString*)getReviewSURL_BYTYPE:(NSString*)upcID type:(NSString*)type{

    NSString* AWSAccessKeyID=@"AKIAIX5TQ2GXCVNFZPZA";
    NSString* AWS_SECRET=@"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";
    
    NSString* urlString = [NSString stringWithFormat: @"http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemLookup&ResponseGroup=Reviews&IdType=%@&ItemId=%@&AWSAccessKeyId=%@&AssociateTag=weifcuiperswe-20",type,upcID,AWSAccessKeyID];
    
    if([type isEqualToString:@"UPC"]){
    
        urlString = [urlString stringByAppendingString:@"&SearchIndex=All"];
    }
    
    NSString *signedURLString = [HMACSHA256 getSignedRequest:urlString withSecret:AWS_SECRET];
    NSURL *url	= [NSURL URLWithString:signedURLString];
    return url;

}




+(NSString*)getKeyWordSearchURL:(NSString*)keyword{
    NSString* AWSAccessKeyID=@"AKIAIX5TQ2GXCVNFZPZA";
    NSString* AWS_SECRET=@"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";
    
    NSString* urlString = [NSString stringWithFormat: @"http://webservices.amazon.com/onca/xml?Service=AWSECommerceService&Operation=ItemSearch&ResponseGroup=Large&SearchIndex=All&Keywords=%@&AWSAccessKeyId=%@&AssociateTag=weifcuiperswe-20",keyword,AWSAccessKeyID];
    
    NSString *signedURLString = [HMACSHA256 getSignedRequest:urlString withSecret:AWS_SECRET];
    NSURL *url	= [NSURL URLWithString:signedURLString];
    return url;
    
}

+(NSDictionary*)getDicFromURL:(NSString *)url{

    NSURL *URL = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc] initWithContentsOfURL:URL];
    NSError *error = nil;
    
    NSDictionary *dictionary = [XMLReader dictionaryForXMLData:data error:&error];

    NSLog(@"xml dic %@", dictionary);
    
    return dictionary;
}


+(void)testXMLReader{

    NSString *testXMLString = @"<items><item id=\"0001\" type=\"donut\"><name>Cake</name><ppu>0.55</ppu><batters><batter id=\"1001\">Regular</batter><batter id=\"1002\">Chocolate</batter><batter id=\"1003\">Blueberry</batter></batters><topping id=\"5001\">None</topping><topping id=\"5002\">Glazed</topping><topping id=\"5005\">Sugar</topping></item></items>";
    
    // Parse the XML into a dictionary
    NSError *parseError = nil;
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:testXMLString error:&parseError];
    
    // Print the dictionary
    NSLog(@"%@", xmlDictionary);

}

@end
