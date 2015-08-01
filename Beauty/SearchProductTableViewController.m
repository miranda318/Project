//
//  SearchProductTableViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "SearchProductTableViewController.h"
#import "AmazonAPI.h"
#import "ProductListTableViewCell.h"


@interface SearchProductTableViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *scanBarcodeButton;
@property NSArray *cellList;// all the product
@property NSMutableArray *imageURLList;

@end

@implementation SearchProductTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _imageURLList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}


#pragma event
//search
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    // Do the search...
    
    NSDictionary* dic = [AmazonAPI getProductsByKeyWorkds:searchBar.text];
    _cellList = dic[@"ItemSearchResponse"][@"Items"][@"Item"];
    
    NSLog(@"cell count%d",_cellList.count);
//    
//    for(int i = 0; i < _cellList.count;i++){
//        NSString* asin = _cellList[i][@"ASIN"][@"text"];
//        NSDictionary* imageDic = [AmazonAPI getProductImages:asin];
//        
//        NSString* imageURL = imageDic[@"ItemLookupResponse"][@"Items"][@"Item"][@"ImageSets"][@"ImageSet"][0][@"SmallImage"][@"URL"][@"text"];
//        
//        NSLog(@"%@",imageURL);
//        [_imageURLList addObject:imageURL];
//    }
    
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_cellList != nil){
        return _cellList.count;
    }else{
        return 0;
    }
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ProductListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//
//    //NSLog(@"%@",_imageURLList[indexPath.row]);
//   // cell.productImage.image =
//    
////    NSURL *url = [NSURL URLWithString:_imageURLList[indexPath.row]];
////    NSData *data = [NSData dataWithContentsOfURL:url];
////    cell.productImage.image = [[UIImage alloc] initWithData:data];
////
//    
//    cell.priceLabel.text = _cellList[indexPath.row][@"ItemAttributes"][@"Title"][@"text"];
//    return cell;
    
    
    UITableViewCell* basicCell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];
    
    basicCell.textLabel.text = _cellList[indexPath.row][@"ItemAttributes"][@"Title"][@"text"];
    
    return basicCell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
