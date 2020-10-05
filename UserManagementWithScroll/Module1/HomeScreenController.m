//
//  HomeScreenController.m
//  Module1
//
//  Created by ketan khare on 22/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import "HomeScreenController.h"
#import "LoginDataModel.h"
#import "UserManagermentViewController.h"


@interface HomeScreenController () {
    UIStoryboard *storyBoard;
}

@end

@implementation HomeScreenController

- (void)viewDidLoad{
    [super viewDidLoad];
    storyBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    NSLog(@"HSC:: ViewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = false;
    self.navigationController.navigationBar.hidden = false;
    UINavigationBarAppearance *navbarAppearance = [[UINavigationBarAppearance alloc] init];
    [navbarAppearance configureWithTransparentBackground];
    navbarAppearance.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.standardAppearance = navbarAppearance;
    NSLog(@"HSC:: ViewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"HSC:: ViewDidAppear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"HSC:: ViewWillDisappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"HSC:: ViewDidDisappear");
}

- (void)exchangeData:(LoginDataModel *)data {
    self.timeStamp.text = data.timeStamp;
    NSLog(@"Data recieved:: %@", data);
    
}

- (IBAction)chartStyleButtonClick:(id)sender {
}

- (IBAction)userManagementButtonClick:(id)sender {
    UserManagermentViewController *userManagement = [storyBoard instantiateViewControllerWithIdentifier:@"UserManagement"];
    [self.navigationController pushViewController:userManagement animated:true];
}

@end
