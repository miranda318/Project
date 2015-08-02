//
//  SearchResultTableViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "ProductWebViewController.h"
#import "ProductReviewTableViewController.h"

@interface SearchResultTableViewController ()


@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self searchOnAmazon];
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
    if(_cellList == nil){
        return 0;
    }else{
        return _cellList.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(_cellList !=nil){
        NSDictionary* dic = _cellList[indexPath.row];
        cell.textLabel.text = dic[@"title"];
    }
    
    return cell;
    */
    
    ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.productNameLabel.text = _cellList[indexPath.row][@"title"];
    cell.brandLabel.text = _cellList[indexPath.row][@"brand"];
    
    NSURL *url = [NSURL URLWithString:_cellList[indexPath.row][@"imageURL"]];
    NSData *data = [NSData dataWithContentsOfURL:url];
    cell.productImage.image= [[UIImage alloc] initWithData:data ];
    
    return cell;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectDic = _cellList[indexPath.row];
    [self performSegueWithIdentifier:@"showProductDetail" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"showProductWeb"]){
        ProductWebViewController* mvc = [segue destinationViewController];
        mvc.url =_selectDic[@"webURL"];
    }
    
    if([segue.identifier isEqualToString:@"showProductDetail"]){
        ProductReviewTableViewController* mvc = [segue destinationViewController];
        
        mvc.viewDic = _selectDic;
        mvc.fromFavorite = _fromFavorite;
    }

    
    
}


@end
