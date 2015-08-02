//
//  AddReviewViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "AddReviewViewController.h"
#import "TPFloatRatingView.h"
#import "FacebookShareTest.h"
#import "SaveToParse.h"

@interface AddReviewViewController ()


@end

@implementation AddReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated{
    [self initView];
}


- (IBAction)post:(id)sender {
    [self saveToParse];
    [self showAlertView:@"Succeed" message:@"You have post this review"];
    
}

- (IBAction)postAndShare:(id)sender {
    //only share on face book
    [self shareOnFaceBook:@"hello"];
}


-(void)shareOnFaceBook:(NSString *)content{
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
        SLComposeViewController *facebookView = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [facebookView setInitialText:content];
        [facebookView addImage:_productImage];
        [self presentViewController:facebookView animated:YES completion:nil];
    }
}

-(void)initView{
    _titleLabel.text = _storeDic[@"title"];
}

-(void)saveToParse{
    [_storeDic addEntriesFromDictionary:@{@"review":_textView.text}];
    [SaveToParse saveToParse:@"reviews" properties:_storeDic];
    
}


-(void)showAlertView:(NSString*)title message:(NSString*)message{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


@end
