//
//  FavoriteViewController.m
//  Beauty
//
//  Created by WeifengCui on 8/1/15.
//  Copyright © 2015 QueensMan. All rights reserved.
//

#import "FavoriteViewController.h"
#import <Parse/Parse.h>

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidAppear:(BOOL)animated{
    _favList = [[NSMutableArray alloc] init];
    [self queryParse];// query
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


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



@end
