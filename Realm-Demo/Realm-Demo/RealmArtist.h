//
//  RealmArtist.h
//  Realm-Demo
//
//  Created by Benoit Sarrazin on 2014-07-19.
//  Copyright (c) 2014 Berzerker Design. All rights reserved.
//

#import <Realm/Realm.h>

@interface RealmArtist : RLMObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *name;

@end
