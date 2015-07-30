//
//  FacebookShareTest.m
//  Beauty
//
//  Created by WeifengCui on 7/30/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "FacebookShareTest.h"

@implementation FacebookShareTest

+(void)shareOnFacebook:(NSString *)content viewController:(UIViewController *)controller{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookView setInitialText:content];
        
        [controller presentViewController:facebookView animated:YES completion:nil];
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }

}


@end
