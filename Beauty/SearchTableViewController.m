//
//  SearchTableViewController.m
//  
//
//  Created by Miranda Yang on 7/25/15.
//
//

#import "SearchTableViewController.h"
#import "SearchResultTableViewController.h"

@interface SearchTableViewController ()  <UISearchBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (strong, nonatomic) NSString *searchString;
@property (strong, nonatomic) NSArray *skinCareArray;
@property (strong, nonatomic) NSArray *makeupArray;
@end

@implementation SearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search a Product";
    
    //test server
    //[self testServer];


    // Hard-coded table
    self.skinCareArray = @[@"Cleanser", @"Moisturize", @"Treatment", @"Mask", @"Sunscreen & Sun Protection", @"Other Needs"];
    self.makeupArray =@[@"Face Makeup", @"Eye Makeuo", @"Lips"];
   
    self.tableView.tableFooterView = [[UIView alloc] init];


}

-(void)viewDidDisappear:(BOOL)animated{
     [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


#pragma table view

//select one cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //get search string
    NSArray *array;
    if(indexPath.section == 0){
        array = _skinCareArray;
    }else{
        array = _makeupArray;
    }
    
    _searchString = array[indexPath.row];
    
    //go to next view controller
    [self performSegueWithIdentifier:@"toSearchPrpdoctBySearch" sender:self];
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"SKIN CARE";
    } else {
        return @"MAKEUP";
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        return self.skinCareArray.count;
    }
    else {
        return self.makeupArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = self.skinCareArray[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:@"cleanser_icon"];
    } else {
        cell.textLabel.text = self.makeupArray[indexPath.row];
    }
    
    return cell;
}
*/
#pragma mark - Search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.searchString = self.searchBar.text;
    [self performSegueWithIdentifier:@"toSearchPrpdoctBySearch" sender:self];
   [self.view endEditing:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    if ([[segue identifier] isEqualToString:@"toSearchPrpdoctBySearch"])
    {
        SearchResultTableViewController *destionationController = segue.destinationViewController;
        destionationController.cellList = [self searchOnAmazon:_searchString];
    }

}




#pragma mark test model
-(void)testServer{
    //[TestParse test];
    [TestAmazonAPI test];
}

-(NSArray*)searchOnAmazon:(NSString*)searchText{
    NSDictionary* dic = [AmazonAPI getProductsByKeyWorkds:searchText];
    NSArray* cellList = dic[@"ItemSearchResponse"][@"Items"][@"Item"];
    
    NSMutableArray* resultList = [[NSMutableArray alloc] init];
    for(int i = 0; i < cellList.count;i ++){
        NSDictionary* dic = cellList[i];
        NSString* title = dic[@"ItemAttributes"][@"Title"][@"text"];
        NSString* webURL = dic[@"DetailPageURL"][@"text"];
        NSString* brand = dic[@"ItemAttributes"][@"Brand"][@"text"];
        NSString* imageURL = dic[@"SmallImage"][@"URL"][@"text"];
        
        title = [self dealNil:title];
        webURL = [self dealNil:webURL];
        brand = [self dealNil:brand];
        imageURL = [self dealNil:imageURL];
        
        
        
        NSArray* valueArray = @[title,webURL,brand,imageURL];
        NSArray* keyArray = @[@"title",@"webURL",@"brand",@"imageURL"];
        NSDictionary* returnDic = [[NSDictionary alloc] initWithObjects:valueArray forKeys:keyArray];
        

        
        NSLog(@"%@",returnDic);
        [resultList addObject:returnDic];
    }
    
    return resultList;
}


-(NSString*)dealNil:(NSString*)input{
    if(input == nil){
        return @"";
    }
    return  input;
}

#pragma Navigation
-(IBAction)unwindToSearch:(UIStoryboardSegue *)sender {
    
}

@end
