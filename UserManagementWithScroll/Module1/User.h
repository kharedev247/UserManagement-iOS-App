//
//  User.h
//  Module1
//
//  Created by ketan khare on 29/09/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (strong, nonatomic)NSString *userName;
@property (strong, nonatomic)NSString *password;
@property (strong, nonatomic)NSString *gender;
@property (strong, nonatomic)NSString *email;
@property (strong, nonatomic)NSString *dob;
@property (strong, nonatomic)NSString *country;
@property (strong, nonatomic)NSString *firstName;
@property (strong, nonatomic)NSString *lastName;
@property (strong, nonatomic)NSString *phoneNo;
@property (strong, nonatomic)NSData *profilePic;
@end

NS_ASSUME_NONNULL_END
