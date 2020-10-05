//
//  ViewController.m
//  Module1
//
//  Created by ketan khare on 18/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import "ViewController.h"
#import "HomeScreenController.h"
#import "LoginDataModel.h"
#import "SignUpController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = true;
    // update it later
    //    [self.userNameTextField becomeFirstResponder];
    self.loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    // Do any additional setup after loading the view.
    NSLog(@"VC:: viewDidLoad");
}

// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"VC:: viewWillAppear");
}

// Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewDidAppear:(BOOL)animated {
    self.userNameTextField.text = @"";
    self.passwordTextField.text = @"";
    NSLog(@"VC:: viewDidAppear");
}

// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated {
    LoginDataModel *dataModel = [self createLoginDataModel];
    [self.dataDelegate exchangeData:dataModel];
    NSLog(@"VC:: viewWillDisappear");
}

// Called after the view was dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"VC:: viewDidDisappear");
}

#pragma mark - Login button handlers

- (IBAction)loginButtonClick:(id)sender {
    // authenticate the user
    BOOL isAuthenticated = [self isUserRegisterAndAuthenticated:self.userNameTextField.text];
    if (isAuthenticated == YES) {
        HomeScreenController *homeScreen = [self.loginStoryBoard instantiateViewControllerWithIdentifier:@"HomeScreen"];
        self.dataDelegate = homeScreen;
        [self.navigationController pushViewController:homeScreen animated:true];
    } else {
        [self showAlertMessage:@"Username or Password is incorrect !!" title:@"Warning"];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"TextFieldShouldReturn");
    [self.view endEditing:true];
    return YES;
}

-(BOOL)isUserRegisterAndAuthenticated:(NSString *)userName {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectcontext = appDelegate.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
    NSError *error;
    NSArray *response = [[managedObjectcontext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (![managedObjectcontext save:&error]) {
        NSLog(@"Error while fetching user details !! %@ %@", error, [error localizedDescription]);
        return NO;
    }
    
    NSString *passwordFromStore;
    BOOL isUserRegistered = NO;
    for(int i=0; i<response.count; i++) {
        NSManagedObject *user = (NSManagedObject *)response[i];
        NSString *userNameFromStore = [user valueForKey:@"userName"];
        if ([userNameFromStore isEqualToString:userName]) {
            passwordFromStore = [user valueForKey:@"password"];
            isUserRegistered = YES;
        }
    }
    if (isUserRegistered == YES && [passwordFromStore isEqualToString:self.passwordTextField.text]) {
        return YES;
    }
    return NO;
}

/// Creates login data model that is send to home screen
- (LoginDataModel *)createLoginDataModel {
    NSString *dateString = [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    
    LoginDataModel *dataModel = [[LoginDataModel alloc] init];
    dataModel.userName = self.userNameTextField.text;
    dataModel.timeStamp = dateString;
    return dataModel;
}

- (IBAction)signUpButtonClicked:(id)sender {
    SignUpController *signUpScreen = [self.loginStoryBoard instantiateViewControllerWithIdentifier:@"SignUpScreen"];
    [self.navigationController pushViewController:signUpScreen animated:true];
}


-(void)showAlertMessage:(NSString* )message title:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //We add buttons to the alert controller by creating UIAlertActions:
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([title isEqualToString:@"Message"]) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
    //You can use a block here to handle a press on this button
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
