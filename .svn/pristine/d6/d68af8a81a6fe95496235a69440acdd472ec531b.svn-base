//
//  CommunityCoreDataManager.h
//  Community
//
//  Created by SYZ on 13-12-7.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommunityCoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CommunityCoreDataManager *)sharedInstance;

- (void)saveContext;

@end
