//
//  ProductReviewTableViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "ProductReviewTableViewController.h"
#import "TPFloatRatingView.h"
#import "FacebookShareTest.h"
#import "ProductWebViewController.h"
#import "SaveToParse.h"
#import "AddReviewViewController.h"
#import "UserReviewTableViewCell.h"
#import "QueryFromParse.h"

@interface ProductReviewTableViewController ()



@end

@implementation ProductReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    
    if(_fromFavorite != nil && _fromFavorite == true){
        _favButton.titleLabel.text = @"Saved To Favorite";
        [_favButton setEnabled:false];
    }
    
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    _reviewList = [[NSMutableArray alloc] init];
    [self queryParse];
}




//set the view
-(void)initView{
    _productName.text = _viewDic[@"title"];
    _brand.text = _viewDic[@"brand"];
    
    NSURL *url = [NSURL URLWithString:_viewDic[@"imageURL"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    _productImage.image= [[UIImage alloc] initWithData:data ];
    


}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _reviewList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
 forIndexPath:indexPath];
    
    cell.textView.text = _reviewList[indexPath.row][@"review"];

    
    return cell;
}





- (IBAction)showInformationInAmazon:(id)sender {
    
    [self performSegueWithIdentifier:@"showWebView" sender:self];
    
}

- (IBAction)writeReview:(id)sender {
    
    [self performSegueWithIdentifier:@"writeReviews" sender:self];
}




-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"showWebView"]){
        ProductWebViewController* controller = [segue destinationViewController];
        controller.url = _viewDic[@"webURL"];
    }
    
    
    if([segue.identifier isEqualToString:@"writeReviews"]){
        AddReviewViewController* controller = [segue destinationViewController];
        controller.storeDic = [[NSMutableDictionary alloc] init];
        
        [controller.storeDic addEntriesFromDictionary:@{@"title":_viewDic[@"title"]}];
        controller.productImage = _productImage.image;
    }
}





- (IBAction)addToFavorite:(id)sender {
    
    
    //save to parse, the viewDic
     _favButton.titleLabel.text = @"Saved To Favorite";
    [_favButton setEnabled:false];
   
    [SaveToParse saveToParse:@"favorites" properties:_viewDic];
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Notice"
                              message:@"You have add this to favorite"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}

-(void)queryParse{
    
    PFQuery *query = [PFQuery queryWithClassName:@"reviews"];
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %td scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [_reviewList addObject:object];
            }
            
            [self.tableView reloadData];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}




@end
