//
//  UserManagermentViewController.h
//  Module1
//
//  Created by ketan khare on 06/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserManagermentViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *usersTable;
@property (strong, nonatomic) UIStoryboard *userManagmentStoryBoard;
@end

NS_ASSUME_NONNULL_END
