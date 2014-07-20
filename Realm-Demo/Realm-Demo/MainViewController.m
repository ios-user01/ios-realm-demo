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

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _insertNewCoreDataArtist];
}

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
    
    for (int i = 0; i < nbInserts; i++) {
        [self _insertNewCoreDataArtist];
        NSLog(@"[%@:%d] %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), @"Inserting artist into Core Data");
    }
    
    NSDate *coreDataEndDate = [NSDate date];
    NSTimeInterval coreDataTimeInterval = [coreDataEndDate timeIntervalSinceDate:coreDataStartDate];
    self.coreDataEndLabel.text = coreDataEndDate.description;
    self.coreDataDeltaLabel.text = @(coreDataTimeInterval).stringValue;
    
    // [BS] Jul 19, 2014
    // Realm
    
    NSDate *realmStartDate = [NSDate date];
    self.realmStartLabel.text = realmStartDate.description;
    
    for (int i = 0; i < nbInserts; i++) {
        [self _insertNewRealArtist];
        NSLog(@"[%@:%d] %@ | %@", NSStringFromClass(self.class), __LINE__, NSStringFromSelector(_cmd), @"Inserting artist into Realm");
    }
    
    NSDate *realmEndDate = [NSDate date];
    NSTimeInterval realmTimeInterval = [realmEndDate timeIntervalSinceDate:realmStartDate];
    self.realmEndLabel.text = realmEndDate.description;
    self.realmDeltaLabel.text = @(realmTimeInterval).stringValue;
    
    // [BS] Jul 19, 2014
    // UI Update
    
    sender.enabled = YES;
}

#pragma mark - Core Data

- (void)_insertNewCoreDataArtist {
    DataSource *ds = [DataSource sharedDataSource];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Artist" inManagedObjectContext:ds.managedObjectContext];
    Artist *artist = [NSEntityDescription insertNewObjectForEntityForName:entityDescription.name inManagedObjectContext:ds.managedObjectContext];
    artist.name = @"James Sullivan";
    artist.identifier = @"The Rev";
    [ds saveContext];
}

- (void)_insertNewRealArtist {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    RealmArtist *artist = [[RealmArtist alloc] init];
    artist.name = @"James Sullivan";
    artist.identifier = @"The Rev";
    [realm addObject:artist];
    [realm commitWriteTransaction];
}


@end
