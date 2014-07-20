//
//  DataSource.h
//  Realm-Demo
//
//  Created by Benoit Sarrazin on 2014-07-19.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

@import Foundation;
@import CoreData;

#pragma mark - Interface

@interface DataSource : NSObject

#pragma mark - Properties

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark - Singleton

+ (instancetype)sharedDataSource;

#pragma mark - Core Data Stack

- (void)saveContext;

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory;

@end
