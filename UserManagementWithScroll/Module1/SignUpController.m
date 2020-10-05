//
//  SignUpController.m
//  Module1
//
//  Created by ketan khare on 05/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import "SignUpController.h"
#import "AppDelegate.h"

@interface SignUpController () {
    UIToolbar *keyboardToolbar;
    UIDatePicker *datePicker;
    NSMutableArray *genderArray;
    NSMutableArray *countryArray;
    NSManagedObject *existingUser;
}
@end

@implementation SignUpController

@synthesize scrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
   
    [self.profileImageView addGestureRecognizer:tapGestureRecognizer];
    self.countryPickerView.delegate = self;
    self.countryPickerView.dataSource = self;
    genderArray = [[NSMutableArray alloc] initWithObjects:@"Male",@"Female", nil];
    countryArray = [[NSMutableArray alloc] initWithObjects:@"India",@"USA",@"Canada",@"Srilanka",@"China",@"Singapore",@"Dubai",@"South Africa",@"Austraila", nil];
    [self initialiseKeyboardToolbar];
    self.signUpStoryboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = false;
    self.navigationController.navigationBar.hidden = false;
    UINavigationBarAppearance *navbarAppearance = [[UINavigationBarAppearance alloc] init];
    [navbarAppearance configureWithTransparentBackground];
    navbarAppearance.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.standardAppearance = navbarAppearance;
    if (self.userInfo == NULL) {
        [self.firstNameTextField becomeFirstResponder];
        self.deleteButton.hidden = true;
        self.updateUserButton.hidden = true;
        self.signUpButton.hidden = false;
    } else {
        self.deleteButton.hidden = false;
        self.updateUserButton.hidden = false;
        self.signUpButton.hidden = true;
        [self updateSignUpForm:self.userInfo];
        
    }
    self.pickerViewParent.hidden = true;
    self.profileImageView.layer.cornerRadius = 25;
    self.profileImageView.layer.masksToBounds = YES;
}


#pragma mark - Keyboard Toolbar method
- (void)initialiseKeyboardToolbar {
    keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(keyboardToolBarDoneBtnPressed)];
    
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
}

-(void)keyboardToolBarDoneBtnPressed{
    [self.view endEditing:true];
    [self stopAnimation];
}


#pragma mark - textField delegate method
// allow you to give permission whether to edit or not
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    textField.inputAccessoryView = keyboardToolbar;
    [self startAnimation:(int)textField.tag];
    if (textField == self.dateOfBirthTextField) {
        datePicker = [[UIDatePicker alloc] init];
        if (self.userInfo && self.userInfo.dob) {
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
            NSDate *date = [dateFormat dateFromString:self.userInfo.dob];
            [datePicker setDate:date];
        } else {
            [datePicker setDate:[NSDate date]];
        }
        datePicker.datePickerMode = UIDatePickerModeDate;
        [datePicker setMaximumDate:[NSDate date]];
        [datePicker addTarget:self action:@selector(selectedDateChange) forControlEvents:UIControlEventValueChanged];
        [self.dateOfBirthTextField setInputView:datePicker];
        self.pickerViewParent.hidden = true;
    } else if (textField == self.countryTextField) {
        if (!self.userInfo && [self.countryTextField.text isEqualToString:@""]) {
            self.countryTextField.text = countryArray[0];
        } else if (self.userInfo) {
            NSInteger countryIndex = [countryArray indexOfObject:self.userInfo.country];
            [self.countryPickerView selectRow:countryIndex inComponent:0 animated:YES];
        }
        [textField resignFirstResponder];
        [self.view endEditing:true];
        [self.countryTextField setInputView:self.countryPickerView];
        [UIView transitionWithView:self.pickerViewParent duration:0.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.pickerViewParent.hidden = false;
        } completion:NULL];
    } else {
        self.pickerViewParent.hidden = true;
    }
}

- (IBAction)pickerViewDoneBtnClick:(id)sender {
    [self.view endEditing:true];
    [UIView transitionWithView:self.view duration:0.6 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.pickerViewParent.hidden = true;
    } completion:NULL];
}


// this method gets called whenever the date is changed in Datepicker
-(void)selectedDateChange {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEEE, MMM d, yyyy"];
     
    NSDate *eventDate = datePicker.date;
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    self.dateOfBirthTextField.text = [NSString stringWithFormat:@"%@",dateString];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:true];
    [self stopAnimation];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return  YES;
}

#pragma mark - Animation methods
-(void)startAnimation:(int)ycordinate {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        CGRect rect= self.view.frame;
        switch (ycordinate) {
            case 7:
                rect.origin.y = -20;
                break;
            case 8:
                rect.origin.y = -100;
                break;
            case 9:
                rect.origin.y = -180;
                break;
            case 10:
                rect.origin.y = -250;
                break;
            default:
                break;
        }
           self.view.frame = rect;
      } completion:^(BOOL finished) {
      }];
}
-(void)stopAnimation {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
         CGRect rect= self.view.frame;
         rect.origin.y = 0;
         self.view.frame = rect;
    } completion:^(BOOL finished) {
    }];
}



#pragma mark - Pickerview delegate methods

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return countryArray.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return countryArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.countryTextField.text = countryArray[row];
}



#pragma mark - Update/Cancel button handlers
- (IBAction)updateUserBtnClick:(id)sender {
    if(![self validateEmptyString]){
        [self showAlertMessage:@"Please fill mandatory fields (FirstName, LastName, Email, Username, Password, DOB, Gender)" title:@"Error"];
        return;
    }
    if (![self validateEmailWithString:self.emailTextField.text]) {
        [self showAlertMessage:@"Please enter valid email" title:@"Error"];
        return;
    }
    if (![self validatePasswordAndConfirmPassword])
    {
        [self showAlertMessage:@"Password and Confirm Password doesn't match" title:@"Error"];
        return;
    }
    if (self.userInfo) {
        BOOL isUserUpdated = [self updateUserInStore:self.userInfo];
        if (isUserUpdated) {
            [self showAlertMessage:@"UserInfo is updated successfully!!" title:@"Message"];
        } else {
            [self showAlertMessage:@"UserInfo is not updated !!" title:@"Info"];
        }
    }
}

-(BOOL)updateUserInStore:(User *)user {
    AppDelegate *appDelegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;
    
    NSArray *response = [self getExistingArrayResponse:user.userName];
    if (response && response.count >= 1) {
        existingUser = [response objectAtIndex:0];
        
        [existingUser setValue:self.emailTextField.text forKey:@"email"];
        [existingUser setValue:self.countryTextField.text forKey:@"country"];
        [existingUser setValue:self.genderTextField.text forKey:@"gender"];
        [existingUser setValue:self.dateOfBirthTextField.text forKey:@"dob"];
        [existingUser setValue:self.passwordTextField.text forKey:@"password"];
        [existingUser setValue:self.phoneNoTextField.text forKey:@"phoneNo"];
        [existingUser setValue:self.firstNameTextField.text forKey:@"firstName"];
        [existingUser setValue:self.lastNameTextField.text forKey:@"lastName"];
        NSData *imageData = UIImagePNGRepresentation(self.profileImageView.image);
        [existingUser setValue:imageData forKey:@"profilePic"];
        NSError *error = nil;
        if (![managedObjectContext save:&error]) {
            [self showAlertMessage:[error localizedDescription] title:@"Error"];
            return NO;
        }
        return YES;
    }
    return NO;
}

- (IBAction)deleteUser:(UIButton *)sender {
    if(self.userInfo && existingUser) {
        AppDelegate *appDelegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;
        
        [managedObjectContext deleteObject:existingUser];
        [self showAlertMessage:@"User deleted successfully" title:@"Message"];
    }
}


#pragma mark - Signup button handler
-(IBAction)signUpButtonClick:(id)sender {
    if(![self validateEmptyString]){
        [self showAlertMessage:@"Please fill mandatory fields (FirstName, LastName, Email, Username, Password, DOB, Gender)" title:@"Error"];
        return;
    }
    if (![self validateEmailWithString:self.emailTextField.text]) {
        [self showAlertMessage:@"Please enter valid email" title:@"Error"];
        return;
    }
    if (![self validatePasswordAndConfirmPassword])
    {
        [self showAlertMessage:@"Password and Confirm Password doesn't match" title:@"Error"];
        return;
    }
    if (self.userInfo == NULL) {
        BOOL isUserRegisterd = [self checkIfUserPresent:self.userNameTextField.text];
        if (isUserRegisterd) {
            [self showAlertMessage:@"Please use different userName !!" title:@"Error"];
            return;
        }
        BOOL result = [self saveDataInStore];
        if (result) {
            [self showAlertMessage:@"User registered successfully !!" title:@"Message"];
        } else {
            [self showAlertMessage:@"User registration failed !!" title:@"Warning"];
        }
    }
}


#pragma mark- Utility methods
-(BOOL)saveDataInStore {
    if(![self validateEmptyString]){
        [self showAlertMessage:@"Please fill mandatory fields (FirstName, LastName, Email, Username, Password, DOB, Gender)" title:@"Error"];
        return NO;
    }
    if (![self validateEmailWithString:self.emailTextField.text]) {
        [self showAlertMessage:@"Please enter valid email" title:@"Error"];
        return NO;
    }
    
    AppDelegate *appDelegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;
    NSManagedObject *userInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:managedObjectContext];
    
    [userInfo setValue:self.firstNameTextField.text forKey:@"firstName"];
    [userInfo setValue:self.lastNameTextField.text forKey:@"lastName"];
    [userInfo setValue:self.userNameTextField.text forKey:@"userName"];
    [userInfo setValue:self.emailTextField.text forKey:@"email"];
    [userInfo setValue:self.dateOfBirthTextField.text forKey:@"dob"];
    [userInfo setValue:self.genderTextField.text forKey:@"gender"];
    [userInfo setValue:self.countryTextField.text forKey:@"country"];
    [userInfo setValue:self.passwordTextField.text forKey:@"password"];
    [userInfo setValue:self.phoneNoTextField.text forKey:@"phoneNo"];
    NSData *imageData = UIImagePNGRepresentation(self.profileImageView.image);
    [userInfo setValue:imageData forKey:@"profilePic"];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        [self showAlertMessage:[error localizedDescription] title:@"Error"];
        return NO;
    }
    return YES;
}

-(void)showAlertMessage:(NSString* )message title:(NSString *)title {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        if ([title isEqualToString:@"Message"]) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
    [alertController addAction:actionOk];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(BOOL)checkIfUserPresent:(NSString *)userName {
    NSArray *response = [self getExistingArrayResponse:userName];
    if (response && response.count > 0) {
        return YES;
    }
    return NO;
}

-(NSArray *)getExistingArrayResponse:(NSString *)userName {
    AppDelegate *appDelegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"userName == %@", userName]];
    NSError *error;
    NSArray *response = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (![managedObjectContext save:&error]) {
        NSLog(@"Error while fetching user details !! %@ %@", error, [error localizedDescription]);
        [self showAlertMessage:[error localizedDescription] title:@"Error"];
        return nil;
    }
    return response;
}

- (void)updateSignUpForm:(User *)user {
    self.userNameTextField.text = user.userName;
    self.userNameTextField.enabled = NO;
    self.countryTextField.text = user.country;
    self.dateOfBirthTextField.text = user.dob;
    self.emailTextField.text = user.email;
    self.genderTextField.text = user.gender;
    self.passwordTextField.text = user.password;
    self.firstNameTextField.text = user.firstName;
    self.lastNameTextField.text = user.lastName;
    self.phoneNoTextField.text = user.phoneNo;
    self.confirmPasswordTextField.text = user.password;
    [self.signUpButton setTitle:@"Update" forState:UIControlStateNormal];
    self.profileImageView.image = [UIImage imageWithData:user.profilePic];
    
    AppDelegate *appDelegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.persistentContainer.viewContext;
    
    // fetch existing user object from store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"userName == %@", user.userName]];
    NSError *error;
    NSArray *response = [[managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (response.count > 0) {
        existingUser = [response objectAtIndex:0];
    }
}


#pragma mark - Validation methods
-(BOOL)validateEmailWithString:(NSString*)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

-(BOOL)validateEmptyString {
    if([self.emailTextField.text isEqualToString:@""] || [self.userNameTextField.text isEqualToString:@""] || [self.dateOfBirthTextField.text isEqualToString:@""] || [self.firstNameTextField.text isEqualToString:@""] || [self.lastNameTextField.text isEqualToString:@""]
       || [self.passwordTextField.text isEqualToString:@""] || [self.genderTextField.text isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

-(BOOL)validatePasswordAndConfirmPassword {
    if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]) {
        return YES;
    }
    return NO;
}


#pragma mark- Tap gesture controller
- (void)imageTapped:(UITapGestureRecognizer *)tapGestureRecognizer {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *choosenImage = info[UIImagePickerControllerOriginalImage];
    self.profileImageView.image = choosenImage;
    [picker dismissViewControllerAnimated:true completion:nil];
}
@end
