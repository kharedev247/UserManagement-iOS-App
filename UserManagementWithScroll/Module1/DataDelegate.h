//
//  DataDelegate.h
//  Module1
//
//  Created by ketan khare on 22/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import "LoginDataModel.h"

@protocol DataDelegate <NSObject>

- (void)exchangeData:(LoginDataModel *)data;

@end
