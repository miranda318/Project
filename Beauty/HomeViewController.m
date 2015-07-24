//
//  HomeViewController.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchResultTableViewController.h"

@interface HomeViewController () <UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *scanBarcodeButton;

@property (strong, nonatomic) NSString *searchString;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //test server
    [self testServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - Search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search button hit in Home screen.");
    self.searchString = self.searchBar.text;
    
    // Segue to Search Result Tabel View Controller
    [self performSegueWithIdentifier:@"toProductTableViewBySearch" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toProductTableViewBySearch"])
    {
        SearchResultTableViewController *destionationController = segue.destinationViewController;
        destionationController.searchText = self.searchString;
    }}


#pragma mark test model
-(void)testServer{
    [TestParse test];
}


@end
