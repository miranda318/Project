//
//  AccountTableViewController.h
//  Beauty
//
//  Created by WeifengCui on 8/3/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountTableViewController : UITableViewController
- (IBAction)login_bt_click:(id)sender;//facebook button login event
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
