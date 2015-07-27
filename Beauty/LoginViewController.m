//
//  LoginViewController.m
//  Beauty
//
//  Created by WeifengCui on 7/27/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "LoginViewController.h"



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)loginWithFacebook{
//    if ([FBSDKAccessToken currentAccessToken]) {
//        // User is logged in, do work such as go to next view controller.
//        [self goToTabBarNavigationController];
//        return;
//    }
    
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
        if (error) {
            // Process error
            NSLog(@"error");
           
        } else if (result.isCancelled) {
            // Handle cancellations
            NSLog(@"cancelled");
            
        } else {
            
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            NSLog(@"permitted");
            [self goToTabBarNavigationController];
            
            if ([result.grantedPermissions containsObject:@"email"]) {
                // Do work
            }
        }
    }];
  
}


-(void)goToTabBarNavigationController{
    [self performSegueWithIdentifier:@"showTab" sender:self];

}
- (IBAction)login:(id)sender {
    [self loginWithFacebook];
}

@end
