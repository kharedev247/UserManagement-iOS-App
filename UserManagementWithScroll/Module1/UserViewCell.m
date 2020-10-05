//
//  UserViewCell.m
//  Module1
//
//  Created by ketan khare on 29/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import "UserViewCell.h"

@implementation UserViewCell

@synthesize userDobLbl, userEmailLbl, userCountryLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.profileImageView.layer.cornerRadius = 25;
    self.profileImageView.layer.masksToBounds = YES;
    // Configure the view for the selected state
}

@end
