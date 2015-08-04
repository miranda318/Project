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


- (IBAction)cancel:(id)sender {
    [self performSegueWithIdentifier:@"returnToAccount" sender:self];
}

- (IBAction)post:(id)sender {
    [self saveToParse];
    [self showAlertView:@"Succeed" message:@"You have post this review"];
    [self performSegueWithIdentifier:@"returnToAccount" sender:self];
    
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
    
    NSString* userProfileUrl = @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xtf1/v/t1.0-1/p50x50/10516649_831440400213483_7314265121581642256_n.jpg?oh=f791d83e2121522ad1ccc7f6d0708c6f&oe=5644BAD9&__gda__=1447042719_89d6922fc9dbbaa8beab3fdc079c9646";
    NSDictionary* savedDic = @{@"review":_textView.text,@"title":_reviewTitle.text,@"userName":@"weifengcui",@"userProfileUrl":userProfileUrl};
    
    [SaveToParse saveToParse:@"reviews" properties:savedDic];
    
}


-(void)showAlertView:(NSString*)title message:(NSString*)message{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


#pragma mark rating view

//-(void)floatRatingView:(TPFloatRatingView *)ratingView continuousRating:(CGFloat)rating{
//
//    NSLog(@"%f",rating);
//}


@end
