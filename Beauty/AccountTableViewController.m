//
//  AccountTableViewController.m
//  Beauty
//
//  Created by WeifengCui on 8/3/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "AccountTableViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Parse/Parse.h>
#import "SearchResultTableViewController.h"

@interface AccountTableViewController ()

-(void)showFacebookPictrues;

@end

@implementation AccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self checkLoginStatus];
     _favList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark login with facebook
-(void)checkLoginStatus{
    //auto check the profile
    [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
    if ([FBSDKAccessToken currentAccessToken]) {
        //if already login
        NSString* userID = [[FBSDKProfile currentProfile] userID];//get user id
        [self setFacebookPic:userID]; // set the pictrue
        
        //hide the button
        [_loginButton removeFromSuperview];
        
    }
}

-(void)setFacebookPic:(NSString*)userId{
    FBSDKProfilePictureView *profilePictureview = [[FBSDKProfilePictureView alloc]initWithFrame:_imageView.frame];
    [profilePictureview setProfileID:userId];
    [_imageView removeFromSuperview];
    [self.view addSubview:profilePictureview];
}


-(void)loginFacebook{
    NSArray* permission = @[@"email",@"public_profile"];
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:permission handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
        } else if (result.isCancelled) {
            // Handle cancellations
        } else {
            //change the pic
            [self checkLoginStatus];
        }
    }];

}


#pragma mark get the favorite list

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"showFavorite"]){
        SearchResultTableViewController* controller = [segue destinationViewController];
        controller.cellList = _favList;
        controller.fromFavorite = true;
        
    }
    
}



-(void)queryParse{
    
    PFQuery *query = [PFQuery queryWithClassName:@"favorites"];
    //[query whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %td scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                [_favList addObject:object];
            }
            [self performSegueWithIdentifier:@"showFavorite" sender:self];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

#pragma mark action

- (IBAction)login_bt_click:(id)sender {
    
    
    [self loginFacebook];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == 0){
        return 2;
    }else{
        return 3;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    //click the favorite one
    if(indexPath.section ==0 && indexPath.row == 0){
        [self queryParse];// qurey the favorite in parse
        
    }

}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
