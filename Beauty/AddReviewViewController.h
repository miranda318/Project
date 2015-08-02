//
//  AddReviewViewController.h
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddReviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextView *textView;

- (IBAction)post:(id)sender;


- (IBAction)postAndShare:(id)sender;


@property NSMutableDictionary* storeDic;
/*
    key: title,
*/


-(void)shareOnFaceBook:(NSString*)content;
-(void)saveToParse;
@property UIImage *productImage;


@end
