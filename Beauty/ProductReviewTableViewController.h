//
//  ProductReviewTableViewController.h
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserReviewTableViewCell.h"

@interface ProductReviewTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *productName;

@property (weak, nonatomic) IBOutlet UILabel *brand;

@property (weak, nonatomic) IBOutlet UIImageView *productImage;

- (IBAction)showInformationInAmazon:(id)sender;
- (IBAction)writeReview:(id)sender;

@property NSDictionary* upcDic;

@property NSDictionary* viewDic;
/*  
 key: title,brand,imageURL,webURL
 */

- (IBAction)addToFavorite:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;
@property (weak, nonatomic) IBOutlet UIButton *amazonButton;

@property BOOL fromFavorite;
@property NSMutableArray * reviewList;
@end
