//
//  UserManagermentViewController.m
//  Module1
//
//  Created by ketan khare on 06/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import "UserManagermentViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "UserViewCell.h"
#import "SignUpController.h"

@interface UserManagermentViewController () {
    int totalUser;
    NSMutableArray *users;
}

@end

@implementation UserManagermentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.usersTable registerNib:[UINib nibWithNibName:@"UserViewCell" bundle:nil] forCellReuseIdentifier:@"UserViewCell"];
    self.usersTable.delegate = self;
    self.usersTable.dataSource = self;
    self.userManagmentStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"View Will Appear of UserManagement");
    self.navigationController.navigationBar.hidden = false;
    users = [[NSMutableArray alloc] init];
    [self fetchUsers];
    [self.usersTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Fetch Users Utility Method

- (void)fetchUsers {
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectcontext = appDelegate.persistentContainer.viewContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
    
    NSError *error;
    NSArray *allUsers = [[managedObjectcontext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (![managedObjectcontext save:&error]) {
        NSLog(@"Error while fetching user details !! %@ %@", error, [error localizedDescription]);
        return;
    }
    
    [self addUsersToList:allUsers];
}

- (void)addUsersToList:(NSArray *)allUsers {
    for(int i=0; i<allUsers.count; i++) {
        NSManagedObject *userFromList = (NSManagedObject *)allUsers[i];
        User *userObj = [[User alloc] init];
        userObj.userName = [userFromList valueForKey:@"userName"];
        userObj.password = [userFromList valueForKey:@"password"];
        userObj.dob = [userFromList valueForKey:@"dob"];
        userObj.country = [userFromList valueForKey:@"country"];
        userObj.email = [userFromList valueForKey:@"email"];
        userObj.gender = [userFromList valueForKey:@"gender"];
        userObj.firstName = [userFromList valueForKey:@"firstName"];
        userObj.lastName = [userFromList valueForKey:@"lastName"];
        userObj.phoneNo = [userFromList valueForKey:@"phoneNo"];
        userObj.profilePic = [userFromList valueForKey:@"profilePic"];
        [users addObject:userObj];
    }
}

#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserViewCell *cell = (UserViewCell *)[tableView dequeueReusableCellWithIdentifier:@"UserViewCell"];
    User *user = users[indexPath.row];
    cell.userEmailLbl.text = user.email;
    cell.userCountryLbl.text = user.country;
    cell.userDobLbl.text = user.dob;
    cell.profileImageView.image = [UIImage imageWithData:user.profilePic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *user = users[indexPath.row];
    SignUpController *signUpScreen = [self.userManagmentStoryBoard instantiateViewControllerWithIdentifier:@"SignUpScreen"];
    signUpScreen.userInfo = user;
    [self.navigationController pushViewController:signUpScreen animated:true];
}
@end

