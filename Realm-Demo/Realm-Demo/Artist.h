//
//  Artist.h
//  Realm-Demo
//
//  Created by Benoit Sarrazin on 2014-07-19.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Artist : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * identifier;

@end
