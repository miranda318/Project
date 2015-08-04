//
//  ProductReviewTableViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "ProductReviewTableViewController.h"
#import "RateView.h"
#import "FacebookShareTest.h"
#import "ProductWebViewController.h"
#import "SaveToParse.h"
#import "AddReviewViewController.h"
#import "UserReviewTableViewCell.h"
#import "QueryFromParse.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface ProductReviewTableViewController ()

@property (nonatomic, weak) IBOutlet RateView *starReviewView;
@property (nonatomic, strong) NSOperationQueue *imageLoadingQueue;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation ProductReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageLoadingQueue = [[NSOperationQueue alloc] init];
    self.imageLoadingQueue.maxConcurrentOperationCount = 4;
    self.imageLoadingQueue.name = @"ProductReviewImageLoadingQueue";
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    
    self.tableView.estimatedRowHeight = 125;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIColor *themePurpleColor = [UIColor colorWithRed:160/255.0 green:21/255.0 blue:86/255.0 alpha:1];
    self.favButton.backgroundColor = themePurpleColor;
    self.reviewButton.backgroundColor = themePurpleColor;
    self.amazonButton.backgroundColor = themePurpleColor;
    
    self.productName.text = _viewDic[@"title"];
    self.brand.text = _viewDic[@"brand"];
    // Setup rate view
    self.starReviewView.backgroundColor = [UIColor clearColor];
    self.starReviewView.rating = 5; //TODO: Define ratings here. Make sure it's a CGFloat.
    self.starReviewView.starSize = 30;
    self.starReviewView.starBorderColor = [UIColor clearColor];
    self.starReviewView.starFillColor = [UIColor colorWithRed:255/255.0f green:173/255.0f blue:8/255.0f alpha:1.0f];
    self.starReviewView.starNormalColor = [UIColor clearColor];
    self.starReviewView.canRate = NO;
    
    [self.imageLoadingQueue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:_viewDic[@"imageURL"]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.productImage.image= [[UIImage alloc] initWithData:data ];
        }];
    }];
    
    if(self.fromFavorite){
        self.favButton.titleLabel.text = @"Saved To Favorite";
        [self.favButton setEnabled:false];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    _reviewList = [[NSMutableArray alloc] init];
    [self queryParse];
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
    UserReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary* dic = _reviewList[indexPath.row];
    
    cell.userNameLabel.text = dic[@"userName"];
    
    cell.titleLabel.text = dic[@"title"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dic[@"time"] doubleValue]];
    cell.dateLabel.text = [self.dateFormatter stringFromDate:date];
    
    cell.reviewLabel.text = dic[@"review"];
    cell.reviewLabel.numberOfLines = 0;
    
    cell.starRateView.backgroundColor = [UIColor clearColor];
    cell.starRateView.rating = [dic[@"rate"] floatValue]; //TODO: Define ratings here. Make sure it's a CGFloat.
    cell.starRateView.starSize = 27;
    cell.starRateView.starBorderColor = [UIColor clearColor];
    cell.starRateView.starFillColor = [UIColor colorWithRed:255/255.0f green:173/255.0f blue:8/255.0f alpha:1.0f];
    cell.starRateView.starNormalColor = [UIColor clearColor];
    cell.starRateView.canRate = NO;
    
    [self.imageLoadingQueue addOperationWithBlock:^{
        NSURL* url = [NSURL URLWithString:dic[@"userProfileUrl"]];
        NSData* data  = [[NSData alloc] initWithContentsOfURL:url];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.userImageView.image = [[UIImage alloc] initWithData:data];
        }];
    }];
    
    return cell;
}





- (IBAction)showInformationInAmazon:(id)sender {
    
    [self performSegueWithIdentifier:@"showWebView" sender:self];
    
}

- (IBAction)writeReview:(id)sender {
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"writeReviews" sender:self];
    }
    else {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"To write a review, you have to sign in first." preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
