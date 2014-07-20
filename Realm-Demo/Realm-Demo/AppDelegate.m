//
//  AppDelegate.m
//  Realm-Demo
//
//  Created by Benoit Sarrazin on 2014-07-19.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import "AppDelegate.h"
#import "DataSource.h"

#pragma mark - Implementation

@implementation AppDelegate

#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[DataSource sharedDataSource] saveContext];
}

@end
