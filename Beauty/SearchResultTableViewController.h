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
@property NSArray *cellList;
@property NSDictionary* selectDic;//the selected dic

/*
 key: title, webURL,image, brand
 */

@property bool fromFavorite;

@end
