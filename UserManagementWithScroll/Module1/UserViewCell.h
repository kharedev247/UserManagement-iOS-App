//
//  UserViewCell.h
//  Module1
//
//  Created by ketan khare on 29/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *userEmailLbl;
@property (strong, nonatomic) IBOutlet UILabel *userDobLbl;
@property (strong, nonatomic) IBOutlet UILabel *userCountryLbl;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;

@end

NS_ASSUME_NONNULL_END
