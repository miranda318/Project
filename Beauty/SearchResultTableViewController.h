//
//  SearchResultTableViewController.h
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultTableViewController.h"
#import "ProductListTableViewCell.h"
#import "AmazonAPI.h"

@interface SearchResultTableViewController : UITableViewController
@property (strong, nonatomic) NSString *searchText;
@property NSArray *cellList;


@end
