//
//  Product.h
//  Beauty
//
//  Created by WeifengCui on 7/30/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject

@property NSString *productName;
@property NSString *brand;
@property UIImage *productImage;
@property NSString *price;


-(void)setProductImageFromURL:(NSString *)productImageURL;


@end
