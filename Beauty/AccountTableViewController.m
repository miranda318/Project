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

@property BOOL isSignedIn;

@end

@implementation AccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isSignedIn = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
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
        self.isSignedIn = YES;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.loginButton.hidden = YES;
            [self.tableView reloadData];
        }];
        NSString* userID = [[FBSDKProfile currentProfile] userID];//get user id
        [self setFacebookPic:userID]; // set the pictrue
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

#pragma mark - Table view data source & delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSignedIn) {
        return 2;
    }
    else {
        return 0;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"My Account";
    }
    else if (section == 1) {
        return @"Others";
    }
    else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSignedIn) {
        if (section == 0) {
            return 2;
        }
        else {
            return 3;
        }
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"My Favorite Products";
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"My Reviews";
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Privacy";
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"About Us";
        }
        else if (indexPath.row == 2) {
            cell.textLabel.text = @"Sign Out";
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //click the favorite one
    if(indexPath.section ==0 && indexPath.row == 0){
        [self queryParse];// qurey the favorite in parse
        
    }
}

@end
