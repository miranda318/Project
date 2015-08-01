//
//  ProductWebViewController.h
//  Beauty
//
//  Created by WeifengCui on 7/31/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductWebViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property NSDictionary* itemDic;//the dic of item
@property NSString* url; //the url string

@end
