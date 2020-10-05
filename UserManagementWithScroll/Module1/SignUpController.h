//
//  SignUpController.h
//  Module1
//
//  Created by ketan khare on 05/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignUpController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate, UIPickerViewDataSource> {
    IBOutlet UIScrollView *scrollView;
}

@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *dateOfBirthTextField;
@property (strong, nonatomic) IBOutlet UITextField *genderTextField;
@property (strong, nonatomic) IBOutlet UITextField *countryTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNoTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIImageView *profileImageView;
@property (strong, nonatomic) IBOutlet UIButton *updateUserButton;
@property (strong, nonatomic) IBOutlet UIPickerView *countryPickerView;
@property (strong, nonatomic) IBOutlet UIView *pickerViewParent;


@property (strong, nonatomic) User *userInfo;
@property (strong, nonatomic) UIStoryboard *signUpStoryboard;

@end

NS_ASSUME_NONNULL_END
