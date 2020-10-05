//
//  AppDelegate.m
//  Module1
//
//  Created by ketan khare on 18/08/20.
//  Copyright © 2020 . All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


// Use this method (and the corresponding application:didFinishLaunchingWithOptions: method) to initialize your app and prepare it to run.
// This method is called after your app has been launched and its main storyboard or nib file has been loaded, but before your app’s state has been restored.
// At the time this method is called, your app is in the inactive state.
// Tells the delegate that the launch process has begun but that state restoration has not yet occurred.
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary<UIApplicationLaunchOptionsKey, id> *)launchOptions {
    NSLog(@"APPDELEGATE: Inside willFinishLaunchingWithOptions");
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"APPDELEGATE: Inside didFinishLaunchingWithOptions");
    sleep(2);
    return YES;
}

// These will not be called if you are using Scenes
// UIKit posts a didEnterBackgroundNotification regardless of whether your app uses scenes.
- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"APPDELEGATE: ApplicationDidEnterBackground");
}

// These will not be called if you are using Scenes
// UIKit posts a didEnterBackgroundNotification regardless of whether your app uses scenes.
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"APPDELEGATE: ApplicationWillEnterForeground");
}

#pragma mark - UISceneSession lifecycle

// Called when the UIKit is about to create & vend a new UIScene instance to the application.
// The application delegate may modify the provided UISceneConfiguration within this method.
// If the UISceneConfiguration instance returned from this method does not have a systemType which matches the connectingSession's, UIKit will assert
- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    NSLog(@"APPDELEGATE: creating a new UIScene instance to the application");
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // Check when this happens !!
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    NSLog(@"APPDELEGATE: DidDiscardSceneSessions");
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:@"Module1"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
