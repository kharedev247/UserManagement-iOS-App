//
//  LoginDataModel.h
//  Module1
//
//  Created by ketan khare on 24/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginDataModel : NSObject

@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *timeStamp;
@property (strong, nonatomic) NSString *isAdmin;

@end

NS_ASSUME_NONNULL_END
