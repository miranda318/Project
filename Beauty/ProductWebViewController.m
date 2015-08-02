//
//  ProductWebViewController.m
//  Beauty
//
//  Created by WeifengCui on 7/31/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "ProductWebViewController.h"

@interface ProductWebViewController ()

@end

@implementation ProductWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showWeb];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}




-(void)showWeb{
    //_url = _itemDic[@"DetailPageURL"][@"text"];
    
    NSURL *websiteUrl = [NSURL URLWithString:_url];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [_webView loadRequest:urlRequest];

}


@end
