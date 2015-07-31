//
//  Product.m
//  Beauty
//
//  Created by WeifengCui on 7/30/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(void)setProductImageFromURL:(NSString *)productImageURL{
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: productImageURL]];
    _productImage = [UIImage imageWithData: imageData];
}

@end
