//
//  FacebookShareTest.h
//  Beauty
//
//  Created by WeifengCui on 7/30/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>


@interface FacebookShareTest : NSObject


+(void)shareOnFacebook:(NSString*)content viewController:(UIViewController*)controller;

@end
