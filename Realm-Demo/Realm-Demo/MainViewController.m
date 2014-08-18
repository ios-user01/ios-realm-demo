//
//  MainViewController.m
//  Realm-Demo
//
//  Created by Benoit Sarrazin on 2014-07-19.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import "MainViewController.h"
#import "Artist.h"
#import "DataSource.h"
#import "RealmArtist.h"
#import <Realm/Realm.h>

#pragma mark - Class Extension

@interface MainViewController ()

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UITextField *nbInsertsTextField;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UILabel *coreDataStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *coreDataEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *coreDataDeltaLabel;
@property (weak, nonatomic) IBOutlet UILabel *realmStartLabel;
@property (weak, nonatomic) IBOutlet UILabel *realmEndLabel;
@property (weak, nonatomic) IBOutlet UILabel *realmDeltaLabel;

#pragma mark - IBActions

- (IBAction)_startButtonTapped:(UIButton *)sender;

@end

#pragma mark - Implementation

@implementation MainViewController

#pragma mark - IBActions

- (IBAction)_startButtonTapped:(UIButton *)sender {
    
    // [BS] Jul 19, 2014
    // UI Update
    [self.nbInsertsTextField resignFirstResponder];
    sender.enabled = NO;
    
    double nbInserts = self.nbInsertsTextField.text.doubleValue;
    
    // [BS] Jul 19, 2014
    // Core Data
    
    NSDate *coreDataStartDate = [NSDate date];
    self.coreDataStartLabel.text = coreDataStartDate.description;

    DataSource *ds = [DataSource sharedDataSource];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Artist" inManagedObjectContext:ds.managedObjectContext];
    for (int i = 0; i < nbInserts; i++) {
        Artist *artist = [NSEntityDescription insertNewObjectForEntityForName:entityDescription.name inManagedObjectContext:ds.managedObjectContext];
        artist.name = @"James Sullivan";
        artist.identifier = @"The Rev";
    }
    [ds saveContext];
    
    NSDate *coreDataEndDate = [NSDate date];
    NSTimeInterval coreDataTimeInterval = [coreDataEndDate timeIntervalSinceDate:coreDataStartDate];
    self.coreDataEndLabel.text = coreDataEndDate.description;
    self.coreDataDeltaLabel.text = @(coreDataTimeInterval).stringValue;
    
    // [BS] Jul 19, 2014
    // Realm
    
    NSDate *realmStartDate = [NSDate date];
    self.realmStartLabel.text = realmStartDate.description;

    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    for (int i = 0; i < nbInserts; i++) {
        RealmArtist *artist = [[RealmArtist alloc] init];
        artist.name = @"James Sullivan";
        artist.identifier = @"The Rev";
        [realm addObject:artist];
    }
    [realm commitWriteTransaction];
    
    NSDate *realmEndDate = [NSDate date];
    NSTimeInterval realmTimeInterval = [realmEndDate timeIntervalSinceDate:realmStartDate];
    self.realmEndLabel.text = realmEndDate.description;
    self.realmDeltaLabel.text = @(realmTimeInterval).stringValue;
    
    // [BS] Jul 19, 2014
    // UI Update
    
    sender.enabled = YES;
}

@end
