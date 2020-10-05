//
//  HomeScreenController.h
//  Module1
//
//  Created by ketan khare on 22/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDelegate.h"
#import "LoginDataModel.h"

@interface HomeScreenController : UIViewController<DataDelegate>

@property (strong, nonatomic) IBOutlet UIButton *chartStyles;
@property (strong, nonatomic) IBOutlet UIButton *textRepeater;
@property (strong, nonatomic) IBOutlet UIButton *stylishFonts;
@property (strong, nonatomic) IBOutlet UILabel *timeStamp;
@property (strong, nonatomic) IBOutlet UIButton *userManagementButton;
- (void)exchangeData:(LoginDataModel *)data;

@end

