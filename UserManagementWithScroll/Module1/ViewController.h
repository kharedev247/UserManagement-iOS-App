//
//  ViewController.h
//  Module1
//
//  Created by ketan khare on 18/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataDelegate.h"

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIView *signUpButton;
@property (strong, nonatomic) id<DataDelegate> dataDelegate;
@property (strong, nonatomic) UIStoryboard *loginStoryBoard;
@end

