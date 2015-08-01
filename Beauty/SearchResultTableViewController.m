//
//  SearchResultTableViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "SearchResultTableViewController.h"
#import "ProductWebViewController.h"

@interface SearchResultTableViewController ()
@property NSDictionary* selectDic;//the selected dic

@end

@implementation SearchResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self searchOnAmazon];
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
//   ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListTableViewCell" forIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(_cellList !=nil){
        NSDictionary* dic = _cellList[indexPath.row];
        cell.textLabel.text = dic[@"ItemAttributes"][@"Title"][@"text"];
//        cell.detailTextLabel.text = dic[@"ItemLinks"][@"ItemLink"][@"Description"][@"text"];
        cell.detailTextLabel.text = _searchText;
    }
    
    return cell;
}


-(void)searchOnAmazon{
    NSDictionary* dic = [AmazonAPI getProductsByKeyWorkds:_searchText];
    _cellList = dic[@"ItemSearchResponse"][@"Items"][@"Item"];
    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectDic = _cellList[indexPath.row];
    [self performSegueWithIdentifier:@"showProductWeb" sender:self];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"showProductWeb"]){
        ProductWebViewController* mvc = [segue destinationViewController];
        mvc.itemDic = _selectDic;
    }

}


@end
