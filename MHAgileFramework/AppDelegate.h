//
//  AppDelegate.h
//  MHAgileFramework
//
//  Created by Steven Nelson on 14/11/19.
//  Copyright (c) 2014年 Steven Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "TestProtocol.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,TestProtocol>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) id <TestProtocol>dele;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

