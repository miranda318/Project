//
//  ReviewTableViewCell.m
//  Beauty
//
//  Created by Yingyi Yang on 7/23/15.
//  Copyright (c) 2015 QueensMan. All rights reserved.
//

#import "UserReviewTableViewCell.h"

@implementation UserReviewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setValues:(NSDictionary *)dic{
    NSArray* arr = @[@"userName",@"title"];
    NSSet *set = [[NSSet alloc] init];
    
    
    _userNameLabel.text = dic[@"userName"];//good
    _titleLabel.text = dic[@"title"]; // good
    _reviewLabel.text = dic[@"review"];//good
    
    NSURL* url = [NSURL URLWithString:dic[@"userProfileUrl"]];
    NSData* data  = [[NSData alloc] initWithContentsOfURL:url];
    _userImageView.image = [[UIImage alloc] initWithData:data];
 
    
}



@end
