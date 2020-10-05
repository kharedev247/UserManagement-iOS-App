//
//  AppDelegate.h
//  Module1
//
//  Created by ketan khare on 18/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

